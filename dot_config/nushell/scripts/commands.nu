alias core-pet = pet
def pet-search [] {
    let query = (commandline)
    let result = (core-pet search "-q" $query "--color")

    if $result != "" {
        commandline edit --replace $result
    }
}
# pet [with credentials]
def pet --wrapped --env [...args: string] {
    $env.PET_GITHUB_ACCESS_TOKEN = if $env.PET_GITHUB_ACCESS_TOKEN? != null {
        $env.PET_GITHUB_ACCESS_TOKEN
    } else {
        (get_develop_secret PET_SNIPPET_SYNC)
    }
    (core-pet ...$args)
}

alias core-elia = elia
# elia [with credentials]
def elia --wrapped --env [...args: string] {
    $env.GROQ_API_KEY = if $env.GROQ_API_KEY? != null {
        $env.GROQ_API_KEY
    } else {
        (get_develop_secret GROQ_API_KEY)
    }
    (core-elia ...$args)
}

def television [] {
    let query = (commandline)
    let channel = (tv list-channels | grep -v ':' | xargs | split row (char space) | input list --fuzzy 'tv channel')

    let result = (tv -i $"($query)" $channel)

    if $result != "" {
        commandline edit --replace $result
    }
}
