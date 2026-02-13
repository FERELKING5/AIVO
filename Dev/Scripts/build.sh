#!/bin/bash

# Build script for AIVO application
# Usage: ./build.sh [debug|release|profile]

set -e

BUILD_TYPE=${1:-"debug"}
TARGET_PLATFORM=${2:-"all"}

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}==================================="
echo "AIVO Build Script"
echo "===================================${NC}"
echo "Build Type: $BUILD_TYPE"
echo "Platform: $TARGET_PLATFORM"

# Validate build type
if [[ ! "$BUILD_TYPE" =~ ^(debug|release|profile)$ ]]; then
    echo -e "${RED}Invalid build type. Use: debug, release, or profile${NC}"
    exit 1
fi

# Clean build directory
echo -e "${YELLOW}Cleaning build artifacts...${NC}"
flutter clean
flutter pub get

# Build APK
if [[ "$TARGET_PLATFORM" == "android" || "$TARGET_PLATFORM" == "all" ]]; then
    echo -e "${YELLOW}Building Android APK ($BUILD_TYPE)...${NC}"
    flutter build apk --$BUILD_TYPE
    echo -e "${GREEN}✓ Android APK built${NC}"

    echo -e "${YELLOW}Building Android App Bundle ($BUILD_TYPE)...${NC}"
    flutter build appbundle --$BUILD_TYPE
    echo -e "${GREEN}✓ Android App Bundle built${NC}"
fi

# Build iOS
if [[ "$TARGET_PLATFORM" == "ios" || "$TARGET_PLATFORM" == "all" ]]; then
    echo -e "${YELLOW}Building iOS ($BUILD_TYPE)...${NC}"
    flutter build ios --$BUILD_TYPE
    echo -e "${GREEN}✓ iOS built${NC}"
fi

echo -e "${GREEN}==================================="
echo "Build Completed Successfully!"
echo "===================================${NC}"
