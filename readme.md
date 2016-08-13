# Req-cli

Req is a commandline HTTP client which stores its configuration in a file called Reqfile.

## Reqfile configuration format

The Reqfile is a YAML file that contains configuration for
- endpoints
- contexts
- routes

example: 

```
---
- endpoints: 
    - prod: https://example.com/
    - staging: http://staging.example.com/
    - dev: http: //localhost:3000/
- contexts:
  - name: steven
    vars: 
      - session_token: 123456
      - user_id: 12
      - name: steven
- routes:
  - name: fetchTervas
    path: 
```

## Commands

### context

`req context` : lists all contexts
`req context steven` : switch to context steven

### status

`req status` : show current context

# example usage

```
req environment production
req context steven
req fetchTervas
```

# nice to have features

- export request in curl format
- use environment variables in config
- multiple configured payloads per route/request?
- commandline variable overrides
  `req fetchTervas battery_percentage=100`
- `req init` command to generate a Reqfile stub
