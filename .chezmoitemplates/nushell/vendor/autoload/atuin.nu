# vim: ft=template

{{- if (and (ne .chezmoi.os "windows") (lookPath "atuin")) }}
  {{ output "atuin" "init" "nu" | trim }}
{{- end }}
