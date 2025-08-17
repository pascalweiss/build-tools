# Build Tools Container - Claude Instructions

## Project Overview
This is a build image used in GitLab CI pipelines. The image itself is built and pushed automatically via GitLab CI when changes are committed.

## Version Management
**IMPORTANT**: When extending this build image with new tools or capabilities, ALWAYS increase the version number in `.gitlab-ci.yml` (TAG variable on line 7).

Use semantic versioning:
- Patch version (0.1.0 → 0.1.1): Bug fixes, minor updates
- Minor version (0.1.1 → 0.2.0): New tools or significant functionality 
- Major version (0.2.0 → 1.0.0): Breaking changes

## Build Process
The image is automatically built and pushed when changes are committed:
1. GitLab CI runs the `build-image` stage
2. Executes `./run/build_and_push.sh` script
3. Builds with Podman and pushes to the configured registry
4. Version is determined by the `TAG` variable in `.gitlab-ci.yml`