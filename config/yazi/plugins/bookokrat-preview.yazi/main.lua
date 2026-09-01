local M = {}

function M:peek(job)
	local page = math.max(1, job.skip + 1)
	local output, err = Command("bookokrat")
		:arg({ "print", "--pages", tostring(page), tostring(job.file.url) })
		:stdout(Command.PIPED)
		:output()

	if not output then
		ya.preview_widget(job, ui.Text(tostring(err)):area(job.area))
		return
	end

	ya.preview_widget(job, ui.Text(output.stdout):area(job.area))
end

function M:seek(job)
	local step = math.max(1, job.units)
	ya.emit("peek", {
		tostring(math.max(0, cx.active.preview.skip + step)),
		only_if = tostring(job.file.url),
	})
end

return M
