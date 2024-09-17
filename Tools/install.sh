#!/bin/sh

# https://stackoverflow.com/a/5947802
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function __verbose {
    echo $*
}
function __success {
    echo $GREEN$*$NC
}
function __fail {
    echo $RED$*$NC
}

# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$SCRIPT_DIR/..
cd $ROOT_DIR

if ! [ -f "./swift-format" ] ; then
    SWIFT_FORMAT_VERSION=600.0.0
    __verbose "Downloading swift-format..."
    arch=$(uname -m)
    if [ "$arch" = "arm64" ]; then
        curl -LO https://github.com/DevYeom/swift-format-executable/releases/download/$SWIFT_FORMAT_VERSION/swift-format.zip
        __verbose "Unzipping swift-format..."
        unzip ./swift-format.zip
        rm -rf ./swift-format.zip
        if [ -d "./__MACOSX" ]; then
            rm -rf __MACOSX
        fi
    else
        curl -LO https://github.com/DevYeom/swift-format-executable/releases/download/$SWIFT_FORMAT_VERSION/swift-format-x86_64.zip
        __verbose "Unzipping swift-format..."
        unzip ./swift-format-x86_64.zip
        rm -rf ./swift-format-x86_64.zip
        if [ -d "./__MACOSX" ]; then
            rm -rf __MACOSX
        fi
    fi
    chmod +x ./swift-format
    version=$(./swift-format --version)
    __success "swift-format $version is installed."
else
    __verbose "swift-format is already installed."
fi

__success "✅ All installations are complete."
