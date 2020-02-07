# Change Directory Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to change to a given directory before running commands.

Particularly useful for setting the working directory before invoking another Buildkite plugin, like [docker-compose-buildkite-plugin](https://github.com/buildkite-plugins/docker-compose-buildkite-plugin).

## Example

```yml
steps:
  - command: make
    plugins:
      - thedyrt/change-directory#v0.1.1:
          cd: /mnt/data
      - docker-compose#v2.1.0:
          run: app
```

## Tests

To run the tests of this plugin, run

```sh
docker-compose run --rm tests
```

## License

MIT (see [LICENSE](LICENSE))
