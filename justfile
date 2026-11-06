# List the recipes
default:
    @just --list

# Start Claude Code with the reviewer and standards repos in reach
[group('dev')]
claude *args:
    CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude \
      --add-dir ../tf-review --add-dir ../tf-standards {{ args }}

# Install the git hooks
[group('dev')]
hooks:
    lefthook install

# Run the checks that need no plugins, so they also work in the Claude sandbox; CI runs this too
[group('dev')]
lint:
    tofu fmt -check -recursive .
    yamllint --strict .
    actionlint
    pinact run --check
    shellcheck scripts/*.sh
    gitleaks git --no-banner

# Run the checks that start provider or ruleset plugins, which can't run in the Claude sandbox; CI runs this too
[group('dev')]
validate:
    tofu -chdir=infra init -backend=false -lockfile=readonly -input=false
    tofu -chdir=infra validate
    tflint --init
    tflint --recursive --config "$PWD/.tflint.hcl"
