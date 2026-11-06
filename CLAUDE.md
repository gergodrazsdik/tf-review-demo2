# tf-review-demo2

An OpenTofu project reviewed by `tf-review`, made from the `tf-review-demo` template to prove onboarding takes one bootstrap map entry (M4's gate). The plan is in `../tf-review/docs/plan.md`.

## Commands

- `just lint`: the checks that work in the Claude sandbox
- `just validate`: `tofu validate` and `tflint`. Their plugins can't start in the sandbox, so run this with the sandbox disabled for that one command
- `just hooks`: install the git hooks

## Conventions

- Plans run on every PR through the plan identity, which only reads state. On merge, `apply.yml` plans `main`, and the `prod` approval applies exactly that plan; a weekly run of the same plan fails on drift. Agents never apply.
- Resources follow ADR-001 (names) and ADR-002 (tags) in `tf-standards`, except on seeded branches that break them on purpose.
- Bootstrap in `tf-review` creates this repo's state container, identities, Actions secrets and variables, and environments.
- Plans stay in the job log, not PR comments, and the Azure IDs are Actions secrets so logs mask them: secrets aren't masked in anything a workflow posts to a PR, so never post raw plan output.
- PRs merge by fast-forward (`just merge <pr>` in `tf-review`, which the user runs), so each commit lands as written: keep commits focused and signed. Third-party actions are pinned to full SHAs with `pinact`.
