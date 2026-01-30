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
def pet --wrapped [...args: string] {
  _setcreds PET_GITHUB_ACCESS_TOKEN; core-pet ...$args
}

alias core-crush = crush
def crush --wrapped [...args: string] {
  $env.CRUSH_DISABLE_METRICS = 1
  core-crush ...$args
}


def television [] {
  let query = (commandline)
  let channel: string = (tv list-channels | split row (char newline) | input list --fuzzy 'Select tv channel')

  if $channel == "" { return }

  let result: string = (tv -i $"($query)" $channel)

  if $result != "" {
      commandline edit --replace $result
  }
}

def stirlingpdf [] {
  let container_name = "stirlingpdf"

  try {
    ^docker run -d --rm -p 8080:8080 --name $container_name --health-cmd "nc -z localhost 8080" --health-interval 5s --health-timeout 3s --health-retries 3 docker.stirlingpdf.com/stirlingtools/stirling-pdf
  }

  docker stop $container_name | ignore
}
