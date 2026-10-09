# vim: ft=template

{{ if lookPath "curl" }}{{ output "curl" "-sL" .nu_scripts.manual.nuenv | trim }}{{ else }}# nuenv hook not fetched: curl was not on PATH when chezmoi rendered this file{{ end }}

$env.config = ($env.config | upsert hooks.env_change.PWD {
    [(setup)]
})
