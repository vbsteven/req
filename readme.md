# Req-cli

Req-cli is a CLI tool for templating HTTP requests from a config file and execute them with curl.

Req-cli takes its configuration from a Reqfile. This file is typically in the root of your project and describes your environments, contexts and requests.

# Installation

Req can be installed through RubyGems

```gem install req-cli```

# Example Reqfile

```yaml
---
environments:
  - name: production
    endpoint: "https://example.com"
    vars:
      env: production
    headers:
      X-App-Id: xeiHahK4feeH2oiZ

  - name: development
    endpoint: "http://localhost:3000"
    vars:
      env: development
    headers:
      X-App-Id: bienaeGaishe0EeC

contexts:
  - name: steven
    vars: 
      sessiontoken: naivahquooQuoo5OhFue5Pii3aexoh
      user_id: "steven"

  - name: dirk
    vars: 
      sessiontoken: eitaeD6Oosh8va7iek8Ohch5ox1Oog
      user_id: "dirk"

requests:
  - name: getItems
    path: "/items"
    method: GET
    headers:
      X-Session-Token: "${sessiontoken}"

  - name: addItem
    path: "/items"
    method: POST
    headers: 
      Content-Type: "application/json"
      X-Parse-Session-Token: "${sessiontoken}"
    vars:
      title: "Default title"
    data: >
      {
        "title": "${title}",
        "author": "${user_id}"
      }
```

# Example Usage

Given the above Reqfile, req-cli can be used like this

```bash
# use production environment
$ req environment production

# use steven context
$ req context steven

# add a custom variable named title with value "My Title"
$ req variable title "My Title"

# show current status
$ req status

  context: steven
  environment: production
  variables:
      title: My Title

# execute the "examplePost" request
$ req exec examplePost
```

This will invoke Curl like this: 

```bash
$ curl -X POST -H 'X-App-Id: xeiHahK4feeH2oiZ' -H 'Content-Type: application/json' -H 'X-Parse-Session-Token: naivahquooQuoo5OhFue5Pii3aexoh' -d '{
    "title": "My Title",
    "author": "steven"
}
' https://example.com/items
```

# Command Reference

**req contexts** - List all available contexts
**req context NAME** - Switch to context NAME

**req environments** - List all available environments
**req environment NAME** - Switch to environment NAME

**req variables** - List all custom variables
**req variable NAME VALUE** - Add custom variable with name NAME and value VALUE

**req requests** - List all available requests

**req status** - List current environment, context and custom variables
**req clear** - Clear current environment, context and custom variables

**req exec NAME** - Execute request with name NAME



# TODO

This project is a little weekend hacking project, I still have some plans for improvement

- Support ${env.VAR_NAME} syntax for shell environment variables
- Support ${!...} syntax for shell command interpolation
- `req init` for generating an empty Reqfile
- Add a cli parameter for showing the curl command

