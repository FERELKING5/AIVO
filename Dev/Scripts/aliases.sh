#!/bin/bash

# Clean and rebuild
alias aivo-clean="flutter clean && flutter pub get"

# Format code
alias aivo-format="flutter format lib/ && flutter format test/"

# Analyze code
alias aivo-analyze="flutter analyze"

# Run tests
alias aivo-test="flutter test"

# Run with coverage
alias aivo-test-coverage="flutter test --coverage"

# Profile the app
alias aivo-profile="flutter run --profile"

# Debug mode
alias aivo-debug="flutter run -v"

# Release build Android
alias aivo-release-android="flutter build apk --release && flutter build appbundle --release"

# Release build iOS
alias aivo-release-ios="flutter build ios --release"

# Generate localizations
alias aivo-gen-l10n="flutter gen-l10n"

# Check for outdated packages
alias aivo-outdated="flutter pub outdated"

# Update packages
alias aivo-update="flutter pub upgrade"

# Run DevTools
alias aivo-devtools="flutter pub global activate devtools && devtools"

echo "AIVO aliases loaded!"
echo "Available commands:"
echo "  aivo-clean          - Clean and get dependencies"
echo "  aivo-format         - Format code"
echo "  aivo-analyze        - Analyze code"
echo "  aivo-test           - Run tests"
echo "  aivo-test-coverage  - Run tests with coverage report"
echo "  aivo-profile        - Run app in profile mode"
echo "  aivo-debug          - Run app in verbose debug mode"
echo "  aivo-release-android - Build release Android"
echo "  aivo-release-ios    - Build release iOS"
echo "  aivo-gen-l10n       - Generate localizations"
echo "  aivo-outdated       - Check outdated packages"
echo "  aivo-update         - Update packages"
echo "  aivo-devtools       - Launch DevTools"
