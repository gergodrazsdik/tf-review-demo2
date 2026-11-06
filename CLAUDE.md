# tf-review-demo

GitHub template for an OpenTofu project reviewed by `tf-review`. Its seeded bad-PR branches double as the reviewer's eval suite. The plan is in `../tf-review/docs/plan.md`.

## Commands

- `just lint`: the checks that work in the Claude sandbox
- `just validate`: `tofu validate` and `tflint`. Their plugins can't start in the sandbox, so run this with the sandbox disabled for that one command
- `just hooks`: install the git hooks

## Conventions

- Plans run on every PR through the plan identity. Applies run on merge, in CI, behind the `prod` environment approval: agents never apply.
- Resources follow ADR-001 (names) and ADR-002 (tags) in `tf-standards`, except on seeded branches that break them on purpose.
- Bootstrap in `tf-review` creates this repo's state container, identities, Actions secrets and variables, and environments.
- Plans stay in the job log, not PR comments, and the Azure IDs are Actions secrets so logs mask them: secrets aren't masked in anything a workflow posts to a PR, so never post raw plan output.
- `main` takes squash-merged PRs only, and third-party actions are pinned to full SHAs with `pinact`.
