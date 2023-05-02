# Contributor Guide

Thanks so much for wanting to help out! :tada:

Most of what you'll see in this document is our attempt at documenting the lightweight development process that works for our team. We're always open to feedback and suggestions for improvement. The intention is not to force people to follow this process step by step, rather to document it as a norm and provide a baseline for discussion.

## Developer Experience

Continuous Delivery is core to our development philosophy. Check out [https://minimumcd.org](https://minimumcd.org/) for a good baseline agreement on what that means.

Specifically:

- We do trunk-based development (`main`) with short-lived feature branches that originate from the trunk, get merged to the trunk, and are deleted after the merge.
- We don't merge work into `main` that isn't releasable.
- We perform automated testing on all pushes to `main`. Fixing failing pipelines in `main` are prioritized over all other work.
- We create immutable release artifacts.

### Developer Workflow

:key: == Required by automation

1. Look at the "Todo" column in [the project board](https://github.com/orgs/defenseunicorns/projects/24/views/1) and pick an issue that is towards the top of the list that you want to work on. Please only work items from the "Todo" column. Items in the columns to the left of "Todo" have not yet been refined and prioritized.
2. Assign yourself to the issue and drop a comment in the issue to let everyone know you're working on it.
3. Move the issue to "In Progress" in the project board.
4. Create a Draft Pull Request targeting the `main` branch as soon as you are able to, even if it is just 5 minutes after you started working on it. We lean towards working in the open as much as we can. If you're not sure what to put in the PR description, just put a link to the issue you're working on. If you're not sure what to put in the PR title, just put "WIP" (Work In Progress) and we'll help you out with the rest.
5. :key: Automated tests will run on your PR when you create it and for each commit you push to it. Most repos will also have manually triggered workflows that you can run (if you have write access to the repo) by commenting on the PR with `/test all`
6. If your PR is still set as a Draft transition it to "Ready for Review"
7. Move the issue in the project board from "In Progress" to "Review Needed"
7. Get it reviewed by a [CODEOWNER](./CODEOWNERS)
8. Merge the PR and delete the branch
9. If the issue is fully resolved, close it. _Hint: You can add "Closes #XXX" to the PR description to automatically close the issue when the PR is merged._

### Testing

#### Minimum Testing Requirement for a Terraform Module
- The module is tested using [Terratest](https://terratest.gruntwork.io/)
- At least one example exists and is tested such that the test passes if the `apply` and `destroy` are both completed successfully. The norm is to have an example called "complete" that tests the module with as many of its features enabled as possible.
- Developers are able to run the tests as part of a PR review
- Developers are able to run the tests locally
- The tests are always run on each push to `main`

### Documentation

#### Minimum Documentation Requirement for a Terraform Module
- The module has a README.md that includes:
  - A description of the module
  - A Getting Started section
  - A list of required providers and their version constraint
  - A list of each module that this module consumes, with source and version
  - A list of the resources that the module creates
  - A list of the inputs with name, description, type, and default value
  - A list of the outputs with name and description
- The module has at least one example

> The [terraform-docs](https://github.com/terraform-docs/terraform-docs/) tool is used to generate the lists specified above

### Backlog Management

- We use a [GitHub Project](https://github.com/orgs/defenseunicorns/projects/24/views/1) to manage our backlog.
- New issues automatically get added to the Project and start in "No Status". They are moved to "Todo" after they have been refined and meet the Definition of Ready (see below).

#### Definition of Ready for a Backlog Item

To meet the Definition of Ready the issue needs to answer the following questions:
- What is being requested?
- Who is requesting it?
- Why is it needed?
- How do we know that we are done?

This can take various forms, and we don't care which form the issue takes as long as it answers the questions above.
