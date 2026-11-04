# Taskwarrior와 Jira 작업 흐름

## taskwarrior-tui 사용법

- `c`를 누르고 `jira` context를 선택하면 Jira 작업만 보입니다. 전체 작업으로 돌아가려면 context를 해제하거나 `task context none`을 실행합니다.
- Jira 작업 하나를 선택한 뒤 `o`를 누르면 Zen Browser 새 탭에서 이슈가 열립니다.
- `Shift+S`는 Jira 동기화를 systemd에 비동기로 요청합니다. taskwarrior-tui는 바로 돌아오고, 이후 Taskwarrior 데이터베이스 변경을 감지해 동기화 완료 시 목록을 자동 갱신합니다. 변경 감지는 최대 1분 내 보정되며, 즉시 확인하려면 `r`을 누릅니다. 선택한 한 건만이 아니라 설정된 Jira 조회 전체를 갱신합니다.

## 데이터 흐름

```text
~/.env
  └─ Bugwarrior wrapper (PAT 설정은 XDG_RUNTIME_DIR의 tmpfs에 잠시 생성)
       └─ 담당자 지정, 미해결, 최근 3개월 내 갱신된 Jira 이슈 조회
            └─ ~/notes/taskwarrior (공용 Taskwarrior DB, jira 태그)
                 ├─ taskwarrior-tui의 jira context
                 └─ Taskwarrior 알림
```

Wrapper는 `~/.env`에서 Jira 인증 정보를 읽으며 PAT를 저장소나 영구 Bugwarrior 설정에 기록하지 않습니다. `~/.env` 권한은 `0600`으로 유지하세요. 동기화된 작업에는 `jira` 태그가 붙고, 성공 후 정리도 해당 태그에만 적용되어 일반 Taskwarrior 작업은 보존됩니다. Jira context에는 쓰기 기본값이 없으므로 그 context에서 수동으로 만든 작업이 Jira 작업으로 잘못 태깅되지 않습니다.

## 자동 실행

- `taskwarrior-jira-sync.timer`는 로그인 후 1분 뒤 시작하고 30분마다 Jira를 동기화합니다.
- `taskwarrior-reminder.timer`는 매분 확인하여 due/scheduled 시각 1시간 전과 해당 시각에 데스크톱 알림을 보냅니다. 날짜만 지정된 일정은 현지 시간 09:00으로 처리합니다. 사용자 정의 `reminder` UDA는 지정한 시각에 알립니다.

```sh
systemctl --user status taskwarrior-jira-sync.timer taskwarrior-reminder.timer
systemctl --user start taskwarrior-jira-sync.service
systemctl --user status taskwarrior-jira-sync.service
journalctl --user -u taskwarrior-jira-sync.service
~/.local/bin/bugwarrior pull --dry-run
```

## 소스와 런타임 symlink

`~/dotfiles`가 실제 실행에 사용하는 기준 소스입니다. `~/lg_dotfiles/files/taskwarrior`에는 chezmoi 배포와 분리된 커밋 미러를 둡니다. 아래 런타임 symlink는 `~/dotfiles`를 가리킵니다.

| 런타임 경로 | 저장소 소스 |
| --- | --- |
| `~/.local/bin/bugwarrior` | `~/dotfiles/.local/bin/bugwarrior` |
| `~/.local/bin/taskwarrior-reminder` | `~/dotfiles/.local/bin/taskwarrior-reminder` |
| `~/.taskrc` | `~/dotfiles/config/taskwarrior/taskrc` |
| `~/.config/taskwarrior-tui/shortcut-scripts` | `~/dotfiles/config/taskwarrior-tui/shortcut-scripts` |
| `~/.config/systemd/user/taskwarrior-{jira-sync,reminder}.{service,timer}` | `~/dotfiles/config/systemd/user/` |

Taskwarrior DB와 알림 중복 방지 상태는 저장소에 넣지 않습니다. 각각 `~/notes/taskwarrior`와 `~/.local/state/taskwarrior-reminder/`에 유지됩니다.
