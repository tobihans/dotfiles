# vim: ft=template

{{ if lookPath "curl" }}{{ output "curl" "-sL" .nu_scripts.manual.nuenv | trim }}

$env.config = ($env.config | upsert hooks.env_change.PWD {
    [(setup)]
})
{{ else }}# nuenv integration not fetched: curl was missing when chezmoi rendered this.{{ end -}}
