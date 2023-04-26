# 3. Use Docker Containers in the Continuous Integration Workflow

Date: 2023-04-26

## Status

Accepted

## Context

We are presented with the decision of how to run the automated tests in the continuous integration workflow. We have a few options:
1. Run the tests directly on the GitHub-hosted runner
2. Run the tests in a Docker container on the GitHub-hosted runner

## Decision

We will run the tests in a Docker container. For ease of use, a Makefile will wrap the `docker run` command. Both local developers and the CI pipeline will run `make test` as the primary method of running the tests.

## Consequences

Because the tests run in a docker container:
- A developer is able to run them locally using the exact same steps that the CI workflow uses. This will make it easier for developers to debug issues that occur in the CI workflow, and largely elmininates "it works on my machine"-type problems.
- Developers do not need a large list of tools installed on their computer. All they need is Docker.
- The section of the CI workflow configuration pertaining to the actual test run is made very simple, with no additional logic in it. It simply runs `make test` and the Makefile handles the rest, which is the exact same thing that a local developer is able to do. This allows us to more easily "lift-and-shift" to a different CI engine if we want to do that in the future.
