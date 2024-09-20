def xo [arg?: string] {
    let arg: string = if $arg != null { $arg } else { "." }
    if $nu.os-info.name == "windows" {
        explorer $arg
        return
    }
    xdg-open $arg o+e>| ignore
}

alias core-pet = pet
def pet-search [] {
    let query = (commandline)
    let result = (core-pet search "-q" $query "--color")

    if $result != "" {
        commandline edit --replace $result
    }
}
# pet [with credentials]
def pet --wrapped [...args: string] {
    $env.PET_GITHUB_ACCESS_TOKEN = if $env.PET_GITHUB_ACCESS_TOKEN? != null {
        $env.PET_GITHUB_ACCESS_TOKEN
    } else {
        (get_develop_secret PET_SNIPPET_SYNC)
    }
    core-pet ...$args
}


alias core-elia = elia
# elia [with credentials]
def elia --wrapped [...args: string] {
    $env.GEMINI_API_KEY = if $env.GEMINI_API_KEY? != null {
        $env.GEMINI_API_KEY
    } else {
        (get_develop_secret GEMINI_API_KEY)
    }
    core-elia ...$args
}
