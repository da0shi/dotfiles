#!/bin/sh

[ $# -le 0 ] && (echo "Usage: $0 REPOSITORY..." ; exit 1)

DEFAULT_ACCOUNT=givery-technology

for r in $@
do
	git clone git@github.com:${GITHUB_ACCOUNT:-${DEFAULT_ACCOUNT}}/${r}.git
done
