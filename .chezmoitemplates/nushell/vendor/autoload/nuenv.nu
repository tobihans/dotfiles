{{ output "curl" "-sL" .nu_scripts.manual.nuenv | trim }}

$env.config = ($env.config | upsert hooks.env_change.PWD {
    [(setup)]
})
