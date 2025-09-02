# Loads secrets from the environment for apps that need them.
def _setcreds --env [...args: string] {
  mut secrets = {}

  for arg in $args {
    let _env = ($env | get -o $arg)
    if $_env == null {
      $secrets = ($secrets | insert $arg { get_develop_secret $arg })
    }
  }

  load-env $secrets
}

alias core-pet = pet
def pet-search [] {
  let query = (commandline)
  let result: string = (core-pet search "-q" $query "--color")

  if $result != "" {
      commandline edit --replace $result
  }
}
# pet [with credentials]
def pet --wrapped --env [...args: string] {
  _setcreds PET_GITHUB_ACCESS_TOKEN; core-pet ...$args
}

def television [] {
  let query = (commandline)
  let channel: string = (tv list-channels | split row (char newline) | input list --fuzzy 'Select tv channel')
  let result: string = (tv -i $"($query)" $channel)

  if $result != "" {
      commandline edit --replace $result
  }
}
