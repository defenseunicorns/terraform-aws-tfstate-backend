# 4. CI Configuration

Date: 2023-05-04

## Status

Accepted

## Context

In ADR (0002-use-slash-command-dispatch-to-trigger-automated-tests)(doc/adr/0002-use-slash-command-dispatch-to-trigger-automated-tests.md) we decided to only trigger CI tests manually. The reasons for this were:

1. Developers are free to push commits to their PR as often as they want, rather than being forced to batch them to avoid triggering the tests that create actual cloud resources too often.
2. Maintainers can inspect the changes that are being made to ensure that they are safe to test before triggering the tests. This is important since the tests create real AWS infrastructure that costs money. Mistakes that cause infinite loops or bad people who submit malicious PRs could cause us to incur significant costs if we don't have a chance to inspect the changes before triggering the tests.
3. 3rd party contributors may fully participate in the development process, rather than being forced to have a maintainer copy their branch to the repo and create a PR on their behalf.

After using this workflow, the impact of this is long feedback loops and a poor developer experience. It adds complexity to the developer, the maintainer, and the pipeline configurations and duplicates native functionality in GitHub.
  
## Decision

To mitigate the problems above with a better developer experience, we ran some experiments and have decided the following:

- Implement action protections in GitHub to prevent forks from automatically triggering actions.
`Settings --> Actions --> General --> Fork Pull Request Workflows --> Run workflows from fork pull requests --> Require approval for fork pull request workflows.`
- Enforce branch protections to ensure the required test actions are executed before allowing a merge
- Add exclusions to the pipeline to ignore `draft` PRs.
- Add exclusions to the pipeline to not run infrastructure tests unless infrastructure files are changed.
- Suggest good practices for developer workflow when developing infrastructure.
  - Open PRs either in `draft` status or when the PR is ready.
  - Run tests locally before pushing changes.

## Consequences

- Developers are free to push commits to their PR as often as they want and control when tests are run
Maintainers can inspect the changes that are being made to ensure that they are safe to test before triggering the tests. `This is important since the tests create real AWS infrastructure that costs money. Mistakes that cause infinite loops could cause us to incur significant costs if we don't have a chance to inspect the changes before triggering the tests.`
- 3rd party contributors may fully participate in the development process.
