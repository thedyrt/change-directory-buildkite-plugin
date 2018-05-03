#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

tmp_dir=$(mktemp -d -t skip-checkout.XXXXXXXXXX)

function cleanup {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

pre_command_hook="$PWD/hooks/pre-command"

@test "Outputs a banner" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_CHANGE_DIRECTORY_CD="/var"
  cd "$BUILDKITE_BUILD_CHECKOUT_PATH"

  run "$pre_command_hook"

  assert_success
  assert_output --partial "--- Changing working directory to $BUILDKITE_PLUGIN_CHANGE_DIRECTORY_CD"
}

@test "Changes the working directory" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_CHANGE_DIRECTORY_CD="/var"
  cd "$BUILDKITE_BUILD_CHECKOUT_PATH"

  # The Buildkite agent sources hooks in a wrapper, then propagates their env
  # changes to the agent's shell. This attempts to replicate that behavior.
  load "$pre_command_hook"
  set +u

  assert [ $PWD = $BUILDKITE_PLUGIN_CHANGE_DIRECTORY_CD ]
}
