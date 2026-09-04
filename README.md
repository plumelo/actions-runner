# runner-images

Custom CI runner container images for Plumelo projects.

## Images

| Directory | Image | Base |
|---|---|---|
| `github/` | `ghcr.io/plumelo/runner-images-github` | [`ghcr.io/actions/actions-runner`](https://github.com/actions/runner) |
| `gitea/` | `ghcr.io/plumelo/runner-images-gitea` | [`gitea/runner-images`](https://github.com/gitea/runner-images) |

Both images add browser dependencies for Playwright (chromium) plus a common
toolset (`curl`, `git-lfs`, `ca-certificates`). The GitHub runner image adds
`gh`, `azure-cli`, node from NodeSource, `age`, `zip`, `azcopy` and `sops`.

## Publishing

Each image has its own workflow (`.github/workflows/build-*.yml`) that builds
and pushes to GHCR on every push to `main` touching its directory, and on
demand via `workflow_dispatch`. Tags: `main` and the commit SHA.

Version updates for base images and workflow actions are handled by
Dependabot (weekly).