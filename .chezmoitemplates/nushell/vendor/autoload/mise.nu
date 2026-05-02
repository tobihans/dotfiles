# vim: ft=template

{{- if (and (lookPath "nu") (lookPath "mise")) }}
  {{ output "nu" "-c" "^mise activate nu" | trim }}
{{- end }}
