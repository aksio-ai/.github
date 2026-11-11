# Working in this repository

This repository is **public**. `profile/README.md` is what renders on the
organisation's page.

## Rules that always apply

- The profile states the vision only: calm, short, no hype. It does not name or
  link any other repository, and it does not describe unreleased work in
  detail.
- No authorship attribution of any tool or vendor anywhere: commits, tags,
  comments, documents. Three guards enforce it: `.claude/settings.json`,
  `.githooks/commit-msg`, and the CI job `attribution`
  (`sh .github/checks/attribution.sh` runs it locally). Run
  `git config core.hooksPath .githooks` in a fresh clone.
- Never change `user.name` or `user.email`. Never force-push `main`. Never
  commit secrets, tokens or credentials.
- Never disable or weaken a check to get green.

## Git

Conventional Commits, small commits.
