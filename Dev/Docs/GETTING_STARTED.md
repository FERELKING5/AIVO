# AIVO - Getting Started Guide

## Prerequisites

- Flutter SDK 3.41.0+
- Dart 3.11.0+
- Android Studio / Xcode
- Git

## Installation

### 1. Install Flutter
```bash
# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter --version
```

### 2. Clone Repository
```bash
git clone <repository-url>
cd aivo
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the App
```bash
flutter run
```

## Development Workflow

### Starting Development
```bash
# Clean build
flutter clean
flutter pub get

# Run with verbose logging
flutter run -v

# Run on specific device
flutter run -d <device-id>
```

### Building

#### Debug Build
```bash
flutter build apk --debug       # Android
flutter build ios --debug       # iOS
```

#### Release Build
```bash
flutter build apk --release     # Android APK
flutter build appbundle --release  # Android App Bundle
flutter build ios --release     # iOS
flutter run --release           # Run release build
```

### Code Analysis
```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Check for issues
dart fix --dry-run
dart fix --apply
```

## Folder Structure

```
lib/
├── screens/
│   ├── splash/
│   ├── home/
│   ├── products/
│   ├── cart/
│   ├── favorite/
│   ├── profile/
│   └── ...
├── components/          # Reusable widgets
├── models/              # Data classes
├── providers/           # State management
├── services/            # API & business logic
├── config/              # Configuration files
├── constants.dart       # App constants (colors, sizes)
├── theme.dart          # Theme configuration
├── routes.dart         # Route definitions
└── main.dart           # App entry point
```

## Key Commands

### Add a New Package
```bash
flutter pub add package_name
```

### Remove a Package
```bash
flutter pub remove package_name
```

### Update Packages
```bash
flutter pub upgrade
flutter pub upgrade --major-versions
```

### Generate Localizations
```bash
flutter gen-l10n
```

### Run Tests
```bash
flutter test
flutter test test/unit/
flutter test test/widget/
```

### Profile Performance
```bash
flutter run --profile
```

### Debug Performance
```bash
flutter run --profile --track-widget-creation
devtools
```

## Environment Configuration

### Debug Environment
```bash
export FLUTTER_DEBUG=true
flutter run
```

### Release Environment
```bash
flutter run --release
```

## Debugging Tips

### Enable Logging
In `lib/config/app_config.dart`:
```dart
static const bool debugMode = true;
```

### Use DevTools
```bash
flutter pub global activate devtools
devtools
```

### Common Issues

**Issue**: Gradle build fails
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter run
```

**Issue**: Pod dependencies issue (iOS)
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
```

**Issue**: Hot reload not working
- Try hot restart: `r`
- Full app restart: `R`
- Rebuild: `flutter run`

## Git Workflow

### Create a Feature Branch
```bash
git checkout -b feature/your-feature-name
```

### Commit Changes
```bash
git add .
git commit -m "feat: description of changes"
```

### Push and Create PR
```bash
git push origin feature/your-feature-name
```

## Testing

### Unit Tests
```bash
flutter test test/unit/
```

### Widget Tests
```bash
flutter test test/widget/
```

### Integration Tests
```bash
flutter test integration_test/
```

### Test Coverage
```bash
flutter test --coverage
lcov --list coverage/lcov.info
```

## Documentation

- Architecture: See `Dev/Docs/ARCHITECTURE.md`
- Design System: See `Dev/Docs/DESIGN_SYSTEM.md`
- Contributing: See `CONTRIBUTING.md`

## Resources

- Flutter Docs: https://flutter.dev/docs
- Dart Docs: https://dart.dev/guides
- Material Design: https://material.io
- Provider Package: https://pub.dev/packages/provider
