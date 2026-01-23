#!/usr/bin/env bash
# Optional installer: attempt to download a prebuilt mcp-jira binary from a GitHub release.
# WARNING: This script is a convenience helper and may need adjustment for your OS/arch.
# Inspect before running.

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$SCRIPT_DIR/mcp-jira"

# Example placeholders — replace OWNER/REPO/TAG/ASSET with real values if known.
OWNER="anomalyco"
REPO="opencode"
TAG="latest"
ASSET_NAME="mcp-jira-linux-amd64"

echo "This script attempts to fetch a prebuilt MCP JIRA binary from GitHub."
echo "You must replace OWNER/REPO/TAG/ASSET with the correct values for the release if needed."
read -r -p "Proceed with a best-effort download from GitHub (may fail)? [y/N] " ans || ans=N
ans=${ans:-N}
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
  echo "Aborting. Edit this script to point to the real release asset." >&2
  exit 1
fi

# Resolve release asset URL (best-effort)
API_URL="https://api.github.com/repos/$OWNER/$REPO/releases/$TAG"

echo "Fetching release metadata: $API_URL"

if ! curl -sSfL "$API_URL" -o /tmp/release.json; then
  echo "Failed to fetch release metadata; please download the binary manually." >&2
  exit 2
fi

ASSET_URL=$(jq -r ".assets[] | select(.name == \"$ASSET_NAME\") | .browser_download_url" /tmp/release.json || true)
if [ -z "$ASSET_URL" ] || [ "$ASSET_URL" == "null" ]; then
  echo "Could not find asset named $ASSET_NAME in release. Inspect /tmp/release.json for available assets." >&2
  exit 3
fi

echo "Downloading $ASSET_URL -> $DEST"
curl -sSfL "$ASSET_URL" -o "$DEST"
chmod +x "$DEST"

echo "Downloaded to $DEST"

echo "Done. Edit .env and run ./run.sh to start the MCP server in stdio mode."