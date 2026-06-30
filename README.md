# oci-terramate

A minimal OCI image that packages [terramate](https://github.com/terramate-io/terramate) for use in devcontainer builds and CI images.

## What it does

The `Containerfile` downloads a pinned release of terramate and produces a scratch-based image containing only the binary. This keeps the image as small as possible with no runtime dependencies.

The image is built for `linux/amd64` and `linux/arm64` via GitHub Actions and published to the GitHub Container Registry at:

```
ghcr.io/thredd-platform/oci-terramate:latest
```

## Usage

Copy the terramate binary into your devcontainer or CI image:

```dockerfile
COPY --from=ghcr.io/thredd-platform/oci-terramate:latest / /
```

## Version updates

[Renovate](https://docs.renovatebot.com/) is configured to automatically open pull requests when new releases of terramate are published, keeping `TERRAMATE_VERSION` in the `Containerfile` up to date.
