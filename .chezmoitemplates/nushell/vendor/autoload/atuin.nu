{{- if ne .chezmoi.os "windows" }}
  {{ output "atuin" "init" "nu" | trim }}
{{- end }}
