#!/usr/bin/env bash
set -euo pipefail

VERSION="${1}"

die() {
	echo "error: $*" >&2
	exit 1
}

case "$OSTYPE" in
linux*) ;;
*) die "unsupported operating system: $OSTYPE" ;;
esac

if [ "$VERSION" = "latest" ]; then
	VERSION="$(
		curl -fsS \
			https://api.github.com/repos/erqon/elevon/releases/latest |
			sed -n 's/.*"tag_name": *"elevon-deploy-v\([^"]*\)".*/\1/p'
	)"
fi

if [[ -z "$VERSION" ]]; then
	die "Deploy release not found"
fi

ARCHIVE="elevon-deploy-v${VERSION}-linux-x86_64.tar.gz"
URL="https://github.com/erqon/elevon/releases/download/elevon-deploy-v${VERSION}/${ARCHIVE}"
DESTINTATION="/tmp/elevon-deploy.tar.gz"

curl -fSL "$URL" -o $DESTINTATION
tar -xzf $DESTINTATION -C /tmp
install -m 0755 /tmp/elevon-deploy-v"${VERSION}"-linux-x86_64 \
	"$RUNNER_TEMP/elevon-deploy"

echo "$RUNNER_TEMP" >>"$GITHUB_PATH"
