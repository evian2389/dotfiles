define-command rofi-buffers \
-docstring 'Select an open buffer using Rofi' %{ %sh{
    BUFFER=$(printf %s\\n "${kak_buflist}" | tr : '\n' | rofi -dmenu)
    if [ -n "$BUFFER" ]; then
        echo "eval -client '$kak_client' 'buffer ${BUFFER}'" | kak -p ${kak_session}
    fi
} }


define-command rofi-files \
-docstring 'Select files in project using Ag and Rofi' %{ %sh{
    FILE=$(ag -g "" | rofi -dmenu)
    if [ -n "$FILE" ]; then
        printf 'eval -client %%{%s} edit %%{%s}\n' "${kak_client}" "${FILE}" | kak -p "${kak_session}"
    fi
} }
