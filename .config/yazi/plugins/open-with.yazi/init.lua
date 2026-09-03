local hovered_url = ya.sync(function()
	local h = cx.active.current.hovered
	return h and tostring(h.url) or nil
end)

local function notify(msg, level)
	ya.notify({ title = "open-with", content = msg, level = level or "warn", timeout = 4 })
end

return {
	entry = function()
		local file = hovered_url()
		if not file then
			return notify("Nothing hovered")
		end

		local script = os.getenv("HOME") .. "/.config/yazi/plugins/open-with.yazi/list-openers.sh"
		local list_out, err = Command("bash"):arg(script):arg(file)
			:stdout(Command.PIPED):stderr(Command.PIPED):output()
		if not list_out then
			return notify("Failed to run list-openers.sh: " .. tostring(err), "error")
		end

		local ids = {}
		local desktop_files = {}
		for line in list_out.stdout:gmatch("[^\r\n]+") do
			local id, path = line:match("^([^\t]+)\t(.+)$")
			if id and path then
				ids[#ids + 1] = id
				desktop_files[#desktop_files + 1] = path
			end
		end
		if #ids == 0 then
			return notify("No registered apps found for this file type")
		end

		-- display names = desktop id with ".desktop" stripped, for the fzf list
		local display = {}
		for _, id in ipairs(ids) do
			display[#display + 1] = id:gsub("%.desktop$", "")
		end
		local input_text = table.concat(display, "\n")

		local permit = ya.hide()
		local fzf_out, fzf_err = Command("sh")
			:args({
				"-c",
				'printf "%s" "$1" | fzf --prompt="Open with> " --reverse',
				"_",
				input_text,
			})
			:output()
		permit:drop()

		if not fzf_out then
			return notify("Failed to run fzf: " .. tostring(fzf_err), "error")
		end

		local choice = fzf_out.stdout:gsub("%s+$", "")
		if choice == "" then
			return -- Esc / cancelled
		end

		local idx
		for i, name in ipairs(display) do
			if name == choice then
				idx = i
				break
			end
		end
		if not idx then
			return notify("Couldn't match selection", "error")
		end

		-- Wait for gio to hand the file off. Dropping a spawned Child immediately
		-- can terminate it before the desktop application gets launched.
		local result, launch_err = Command("gio")
			:args({ "launch", desktop_files[idx], file })
			:output()
		if not result then
			notify('Failed to launch "' .. ids[idx] .. '": ' .. tostring(launch_err), "error")
		elseif not result.status.success then
			notify('Failed to launch "' .. ids[idx] .. '": ' .. result.stderr:gsub("%s+$", ""), "error")
		end
	end,
}
