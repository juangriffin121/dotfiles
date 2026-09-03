#!/usr/bin/env bash
# Prints one .desktop id and its path per line, registered for $1's mimetype.
set -uo pipefail

file="$1"
mime=$(xdg-mime query filetype "$file" 2>/dev/null)
[ -z "$mime" ] && mime=$(file --mime-type -b "$file" 2>/dev/null)

desktop_file() {
	local id="$1" dir
	local data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
	local data_dirs="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

	IFS=: read -ra dirs <<< "$data_home:$data_dirs"
	for dir in "${dirs[@]}"; do
		if [ -f "$dir/applications/$id" ]; then
			printf '%s\n' "$dir/applications/$id"
			return 0
		fi
	done
	return 1
}

gio mime "$mime" 2>/dev/null | awk '
  /^Registered applications:/ { grab=1; next }
  /^Recommended applications:/ { grab=0 }
  grab && NF { print $1 }
' | while IFS= read -r id; do
	path=$(desktop_file "$id") || continue
	printf '%s\t%s\n' "$id" "$path"
done
