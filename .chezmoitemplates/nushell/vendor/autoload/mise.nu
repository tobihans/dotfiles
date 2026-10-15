# vim: ft=template

{{- if (and (lookPath "nu") (lookPath "mise")) }}
{{ $clean := list "/usr/local/bin" "/usr/bin" "/bin" (lookPath "nu" | dir) (lookPath "mise" | dir) | uniq | join ":" }}{{ output "env" "-i" (printf "HOME=%s" .chezmoi.homeDir) (printf "PATH=%s" $clean) "nu" "-c" "^mise activate nu" | trim }}
{{- end }}
