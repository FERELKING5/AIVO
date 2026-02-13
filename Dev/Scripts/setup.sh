#!/bin/bash

# AIVO Development Setup Script
# Initializes Flutter environment and installs all dependencies

set -e

echo "==================================="
echo "AIVO Development Setup"
echo "==================================="

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Flutter installation
echo -e "${YELLOW}[1/5] Checking Flutter installation...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Flutter not found. Please install Flutter first.${NC}"
    exit 1
fi

FLUTTER_VERSION=$(flutter --version | head -1)
echo -e "${GREEN}✓ Flutter found: $FLUTTER_VERSION${NC}"

# Install dependencies
echo -e "${YELLOW}[2/5] Installing pub dependencies...${NC}"
flutter pub get
echo -e "${GREEN}✓ Dependencies installed${NC}"

# Clean build
echo -e "${YELLOW}[3/5] Cleaning build artifacts...${NC}"
flutter clean
echo -e "${GREEN}✓ Build cleaned${NC}"

# Analyze code
echo -e "${YELLOW}[4/5] Running code analysis...${NC}"
flutter analyze || echo -e "${YELLOW}⚠ Code analysis completed with warnings${NC}"
echo -e "${GREEN}✓ Code analysis done${NC}"

# Format code
echo -e "${YELLOW}[5/5] Formatting code...${NC}"
flutter format lib/
flutter format test/
echo -e "${GREEN}✓ Code formatted${NC}"

echo ""
echo -e "${GREEN}==================================="
echo "Setup Complete!"
echo "====================================${NC}"
echo ""
echo "Next steps:"
echo "1. Connect a device or start an emulator"
echo "2. Run: flutter run"
echo ""
