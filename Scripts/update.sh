#!/bin/sh

LATEST_VERSION=$(gh api repos/SteamRE/DepotDownloader/releases/latest | jq -r ".name" | sed 's/DepotDownloader[_ ]//')
CURRENT_VERSION=$(grep 'version "' Casks/depotdownloader.rb | cut -d '"' -f 2)

if [ "${LATEST_VERSION}" = "${CURRENT_VERSION}" ]
then
  echo "DepotDownloader Cask is up to date."
  exit 0
fi

if [ "$(uname)" = "Darwin" ]
then
  SED_INLINE="sed -i .tmp"
else
  SED_INLINE="sed -i"
fi

update_for_arch() {
  BREW_ARCH=$1
  FILE_ARCH=$2

  FILE_SHA_256=$(curl -fSsL -o - "https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_${LATEST_VERSION}/DepotDownloader-macos-${FILE_ARCH}.zip" | shasum -a 256 | awk '{print $1}')
  ${SED_INLINE} "s/${BREW_ARCH}:\([ \t]*\)\"[0-9a-f]*\"/${BREW_ARCH}:\1\"${FILE_SHA_256}\"/g" Casks/depotdownloader.rb
}

${SED_INLINE} "s/version \"${CURRENT_VERSION}\"/version \"${LATEST_VERSION}\"/" Casks/depotdownloader.rb
update_for_arch arm arm64
update_for_arch intel x64

if [ "$(uname)" = "Darwin" ]
then
  rm Casks/*.tmp
fi
