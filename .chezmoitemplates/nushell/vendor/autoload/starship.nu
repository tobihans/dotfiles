# vim: ft=template

{{- if (lookPath "starship") }}
  {{ output "starship" "init" "nu" | trim }}
{{- end }}
