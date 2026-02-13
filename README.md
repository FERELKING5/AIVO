# AIVO - Modern E-Commerce Flutter Application

<div align="center">

**A production-ready Flutter e-commerce application with multi-language support, responsive design, and professional CI/CD infrastructure.**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.41.0-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.11.0-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

</div>

---

## 📱 Overview

AIVO is a modern, feature-rich Flutter e-commerce application built with:
- 🌍 **Multi-language support** (English, French, Spanish)
- 📱 **Responsive design** (Mobile, Tablet, Desktop)
- 🎨 **Material Design 3** UI
- 🏗️ **Clean architecture** with Provider state management
- 🚀 **CI/CD automation** with GitHub Actions
- 📚 **Professional documentation**

---

## ✨ Key Features

### Current Features
- [x] Multi-language internationalization (i18n)
- [x] Responsive & adaptive UI
- [x] Clean code architecture
- [x] Centralized configuration system
- [x] Professional CI/CD pipelines
- [x] Comprehensive documentation

### Planned Features
- [ ] User authentication (Login/Signup)
- [ ] Product browsing & search
- [ ] Shopping cart management
- [ ] Order processing
- [ ] User profiles & wishlist
- [ ] Push notifications
- [ ] Dark mode support
- [ ] Offline mode

---

## 🚀 Quick Start

### Prerequisites
- Flutter 3.41.0+
- Dart 3.11.0+
- Android Studio / Xcode
- Git

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/aivo.git
cd aivo

# 2. Run setup script
bash Dev/Scripts/setup.sh

# 3. Run the app
flutter run
```

### Alternative Quick Commands

```bash
# Load development aliases
source Dev/Scripts/aliases.sh

# Clean and setup
aivo-clean

# Run in debug mode
flutter run

# Build release
aivo-release-android
```

---

## 📚 Documentation

Comprehensive documentation is available in the `Dev/Docs/` directory:

| Document | Purpose |
|----------|---------|
| **[ARCHITECTURE.md](Dev/Docs/ARCHITECTURE.md)** | Project structure, tech stack, and design patterns |
| **[DESIGN_SYSTEM.md](Dev/Docs/DESIGN_SYSTEM.md)** | UI/UX guidelines, colors, typography, components |
| **[GETTING_STARTED.md](Dev/Docs/GETTING_STARTED.md)** | Development setup, common commands, troubleshooting |

### Additional Resources
- **[DEVELOPMENT_REPORT.md](DEVELOPMENT_REPORT.md)** - Detailed project status and roadmap
- **[LICENSE](LICENSE)** - Project license

---

## 📂 Project Structure

```
aivo/
├── lib/
│   ├── screens/              # UI screens
│   ├── components/           # Reusable widgets
│   ├── models/              # Data models
│   ├── providers/           # State management
│   ├── services/            # Business logic
│   ├── config/              # App configuration
│   ├── constants.dart       # App constants
│   ├── theme.dart          # Theme configuration
│   └── main.dart           # App entry point
├── assets/
│   ├── images/             # Image assets
│   ├── icons/              # Icon assets
│   ├── fonts/              # Custom fonts
│   └── i18n/              # Translation files (ARB)
├── Dev/
│   ├── Docs/              # Documentation
│   └── Scripts/           # Development scripts
├── .github/
│   └── workflows/         # CI/CD workflows
├── android/               # Android native code
├── ios/                   # iOS native code
└── pubspec.yaml          # Dependencies
```

---

## 🌐 Supported Languages

- 🇺🇸 **English** (en)
- 🇫🇷 **Français** (fr)
- 🇪🇸 **Español** (es)

Language can be switched dynamically at runtime.

---

## 🛠️ Development Tools

### Scripts

Access quick commands via scripts in `Dev/Scripts/`:

```bash
# Setup development environment
bash Dev/Scripts/setup.sh

# Build the app (debug/release/profile)
bash Dev/Scripts/build.sh release

# Load helpful aliases
source Dev/Scripts/aliases.sh
```

### Common Aliases

```bash
aivo-clean              # Clean & get dependencies
aivo-format             # Format code
aivo-analyze            # Lint code
aivo-test               # Run tests
aivo-debug              # Debug build
aivo-profile            # Profile build
aivo-release-android    # Release APK & bundle
aivo-release-ios        # Release iOS build
aivo-gen-l10n           # Generate localizations
aivo-devtools           # Launch DevTools
```

---

## 🔨 Building & Deployment

### Development
```bash
flutter run
flutter run --debug
```

### Profile Mode (Performance Testing)
```bash
flutter run --profile
```

### Release Build (Android)
```bash
# APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release

# ARM64 specific (Recommended)
flutter build apk --release --target-platform android-arm64
```

### Release Build (iOS)
```bash
flutter build ios --release
```

### CI/CD Automation
Builds are automatically triggered on:
- ✅ Push to `main` or `develop` branches
- ✅ Pull requests
- ✅ Manual workflow dispatch

See `.github/workflows/` for details.

---

## 📊 Project Status

**Overall Progress: 45%** (Infrastructure & Setup Complete)

### Completed ✅
- [x] Code refactoring & branding
- [x] Internationalization (i18n) setup
- [x] CI/CD pipelines configured
- [x] Professional documentation
- [x] Development tools & scripts

### Planned 📋
- [ ] Feature development (Auth, Products, Cart, etc.)
- [ ] Code quality fixes
- [ ] Dark mode
- [ ] Push notifications
- [ ] Offline support

See [DEVELOPMENT_REPORT.md](DEVELOPMENT_REPORT.md) for detailed roadmap.

---

## 🧪 Testing

### Run Tests
```bash
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/unit/models_test.dart
```

### Code Analysis
```bash
flutter analyze

flutter format lib/

dart fix --apply
```

---

## 🔍 Debugging

### Debug Mode
```bash
flutter run -v        # Verbose logging
flutter run --debug   # Debug build
```

### DevTools
```bash
devtools
# Manually open: http://localhost:9100
```

See [GETTING_STARTED.md](Dev/Docs/GETTING_STARTED.md) for troubleshooting.

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | 3.41.0 | Framework |
| flutter_localizations | SDK | i18n support |
| intl | 0.20.2 | Internationalization |
| provider | 6.1.1 | State management |
| flutter_svg | 2.0.9 | SVG support |
| cupertino_icons | 1.0.2 | iOS icons |

See `pubspec.yaml` for complete list.

---

## 🔒 Security

- [x] Centralized configuration
- [x] No hardcoded secrets
- [ ] API key management (TBD)
- [ ] Data encryption (TBD)
- [ ] Biometric support (planned)

---

## 📞 Support

### Documentation
- 📖 [Architecture Guide](Dev/Docs/ARCHITECTURE.md)
- 🎨 [Design System](Dev/Docs/DESIGN_SYSTEM.md)
- 🚀 [Getting Started](Dev/Docs/GETTING_STARTED.md)
- 📊 [Development Report](DEVELOPMENT_REPORT.md)

### Resources
- [Flutter Documentation](https://flutter.dev)
- [Dart Documentation](https://dart.dev)
- [Material Design](https://material.io)
- [Pub.dev Packages](https://pub.dev)

---

## 📄 License

This project is licensed under the **MIT License** - see [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with ❤️ using Flutter**

[⬆ Back to top](#aivo---modern-e-commerce-flutter-application)

</div>
