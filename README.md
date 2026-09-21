# setup-elevon

Set up the Elevon CLI in your GitHub Actions workflow.

## Usage

```yaml
name: Deploy

on:
  push:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Elevon
        uses: erqon/elevon-deploy@v1

      - name: Deploy application
        run: elevon deploy
```

## Specify a version

By default, the action installs the latest version of Elevon. To install a specific version:

```yaml
- name: Set up Elevon
  uses: erqon/elevon-deploy@v1
  with:
    version: 1.2.3
```

You can then run any Elevon CLI command in subsequent workflow steps:

```yaml
- run: elevon build --push
- run: elevon deploy
- run: elevon rollback
```

## Requirements

- Ubuntu GitHub Actions runner
- Elevon configuration available in the repository
- Any required Elevon secrets configured as GitHub Actions secrets
