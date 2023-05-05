# 2. Use Slash Command Dispatch to trigger automated tests

Date: 2023-04-26

## Status

Accepted

## Context

We are presented with the decision of how to trigger automated tests when someone pushes a commit to a Pull Request. We have a few options:

1. Trigger the tests automatically on every commit
2. Trigger the tests manually by commenting on the PR with `/test all`

Both have pros and cons.

- Triggering the tests automatically will
  - Force developers to batch their commits rather than push them as they are ready to be pushed, to avoid triggering the tests too often.
  - Force maintainers to take ownership of 3rd party PRs, since PRs from forks do not get access to GitHub Actions secrets.
- Using Slash Command Dispatch will
  - Force maintainers to manually trigger the tests, which is inconvenient.

## Decision

We will use Slash Command Dispatch to trigger the tests manually by commenting on the PR with `/test all`

## Consequences

Pros:
- Developers are free to push commits to their PR as often as they want, rather than being forced to batch them to avoid triggering the tests too often.
- Maintainers are able to inspect the changes that are being made to ensure that they are safe to test before triggering the tests. This is important since the tests create real AWS infrastructure that costs money. Mistakes that cause infinite loops or bad people who submit malicious PRs could cause us to incur significant costs if we don't have a chance to inspect the changes before triggering the tests.
- 3rd party contributors may fully participate in the development process, rather than being forced to have a maintainer copy their branch to the repo and create a PR on their behalf.

Cons:
- Maintainers are forced to manually trigger the tests, which is inconvenient and is contrary to the spirit of continuous integration.

Mitigations:
- We can configure the GitHub repo to require that the tests are run before the PR is allowed to be merged. This will ensure that the tests are run before the PR is merged, even if the maintainer initially forgets to run them.
- We can also configure the GitHub repo to require that PRs are up to date with the `main` branch before they are allowed to be merged ("fast-forward-only mode"). This will ensure that the tests are run on the latest code before the PR is merged, even if the maintainer initially forgets to run them.
- Alternatively, we can configure the `main` branch to always run the tests on every commit pushed, to ensure that everything that is merged to `main` has been or will be tested.
