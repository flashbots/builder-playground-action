# Builder Playground Action

GitHub Action to deploy blockchain environments using [builder-playground](https://github.com/flashbots/builder-playground).

## Usage

```yaml
- name: Start Builder Playground
  uses: flashbots/builder-playground-action@v1
  with:
    recipe: l1 # Required: recipe name or path to recipe.yaml
```

## Inputs

| Input     | Description                             | Required | Default  |
| --------- | --------------------------------------- | -------- | -------- |
| `version` | Version of builder-playground to use    | No       | `latest` |
| `recipe`  | Recipe name or path to recipe.yaml file | Yes      | -        |

## Example Workflows

### Using a built-in recipe

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
          version: v1.0.0
          recipe: ./configs/my-recipe.yaml

      - name: Run tests
        run: |
          # Your tests here
```

## How it works

This action uses [flashbots-toolchain](https://github.com/flashbots/flashbots-toolchain) to install builder-playground and then runs it in the background with your specified recipe.

## License

MIT
