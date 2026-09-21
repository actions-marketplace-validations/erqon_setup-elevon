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
		curl -fsS https://api.github.com/repos/erqon/elevon/releases |
			jq -r '[.[] | select(.tag_name | startswith("elevon-cli-v"))][0].tag_name' |
			sed 's/elevon-cli-v//'
	)"
fi

if [[ -z "$VERSION" ]]; then
	die "Cli release not found"
fi

ARCHIVE="elevon-cli-v${VERSION}-linux-x86_64.tar.gz"
URL="https://github.com/erqon/elevon/releases/download/elevon-cli-v${VERSION}/${ARCHIVE}"
DESTINTATION="/tmp/elevon-cli.tar.gz"

curl -fSL "$URL" -o $DESTINTATION
tar -xzf $DESTINTATION -C /tmp
install -m 0755 /tmp/elevon-cli-v"${VERSION}"-linux-x86_64 \
	"$RUNNER_TEMP/elevon"

echo "$RUNNER_TEMP" >>"$GITHUB_PATH"
