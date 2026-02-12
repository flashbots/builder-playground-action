# Builder Playground Action

GitHub Action to deploy blockchain environments using [builder-playground](https://github.com/flashbots/builder-playground).

## Usage

```yaml
- name: Start Builder Playground
  uses: flashbots/builder-playground-action@v1
  with:
    recipe: l1 # Optional: Recipe name or path to playground.yaml (just installs if not provided)
    version: v0.3.1
    detached: true
    args: --log-level=trace
```

## Inputs

| Input      | Description                                              | Required | Default  |
| ---------- | -------------------------------------------------------- | -------- | -------- |
| `version`  | Version of builder-playground to use                     | No       | `latest` |
| `recipe`   | Recipe name or path to playground.yaml file              | No       | -        |
| `detached` | Run playground in detached mode                          | No       | `true`   |
| `args`     | Additional arguments to pass to builder-playground start | No       | -        |

## Example Workflows

### Install only

```yaml
name: Deploy Devnet
on: [push]

jobs:
  install:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install builder-playground
        uses: flashbots/builder-playground-action@v1

      - name: Run tests
        run: |
          builder-playground start <your-args>
          # Your tests here
```

### Auto-start with a built-in recipe

```yaml
name: Deploy Devnet
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Start playground
        uses: flashbots/builder-playground-action@v1
        with:
          recipe: l1
          args: --use-native-reth --timeout 5s

      - name: Run tests
        run: |
          # Your tests here
```

### Using a custom recipe file

```yaml
name: Deploy Custom Environment
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Start playground
        uses: flashbots/builder-playground-action@v1
        with:
          version: v0.3.1
          recipe: ./configs/playground.yaml

      - name: Run tests
        run: |
          # Your tests here
```

## How it works

This action uses [flashbots-toolchain](https://github.com/flashbots/flashbots-toolchain) to install builder-playground and then runs it in the background with your specified recipe.

## Testing locally

- Install `act` (nektos/act).
- Change `action.yml` or the action test workflow in `.github/workflows/test.yml`.
- `make test`

## License

MIT
