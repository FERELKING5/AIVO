# AIVO - Architecture & Design Documentation

## Overview
AIVO is a modern Flutter e-commerce application with multi-language support, responsive design, and robust state management.

## Tech Stack
- **Framework**: Flutter 3.41.0
- **Language**: Dart 3.11.0
- **State Management**: Provider
- **Internationalization**: intl + flutter_localizations
- **UI Framework**: Material Design 3
- **Icons**: Flutter SVG

## Project Structure

```
aivo/
├── lib/
│   ├── screens/              # UI Screens
│   ├── components/           # Reusable UI Components
│   ├── models/              # Data Models
│   ├── providers/           # State Management (Provider)
│   ├── services/            # Business Logic & API
│   ├── config/              # App Configuration
│   ├── constants.dart       # App Constants
│   ├── theme.dart          # Theme Configuration
│   └── main.dart           # App Entry Point
├── assets/
│   ├── images/             # Image Assets
│   ├── icons/              # Icon Assets
│   ├── fonts/              # Custom Fonts
│   └── i18n/              # Translation Files (ARB)
├── android/                # Android Native Code
├── ios/                    # iOS Native Code
├── Dev/
│   ├── Docs/              # Documentation
│   └── Scripts/           # Helper Scripts
└── pubspec.yaml           # Dependencies
```

## Architecture

### 1. **UI Layer** (screens/ + components/)
- Screen-level widgets
- Component-level reusable widgets
- Follows Material Design 3

### 2. **State Management** (providers/)
- Provider pattern for state management
- Clean separation of concerns
- Easy testing and debugging

### 3. **Business Logic** (services/)
- API interactions
- Data processing
- Business rules

### 4. **Data Layer** (models/)
- Data models
- Serialization/Deserialization
- Type safety

## Key Features

### 1. Multi-Language Support
- Supports: English, French, Spanish
- Uses intl package
- ARB format for translations
- Language switching at runtime

### 2. Responsive Design
- Mobile-first approach
- Adapts to different screen sizes
- Consistent UI/UX across devices

### 3. Performance Optimization
- Lazy loading
- Image caching
- Efficient state management
- Code splitting

## Development Guidelines

### Code Style
- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused

### State Management
- Use Provider for global state
- Keep state as close as possible to where it's used
- Avoid prop drilling

### Naming Conventions
- Classes: PascalCase
- Methods/Variables: camelCase
- Constants: ALL_CAPS
- Files: snake_case

### Testing
- Unit tests for business logic
- Widget tests for components
- Integration tests for flows

## Configuration

See `lib/config/app_config.dart` for:
- API endpoints
- Feature flags
- Cache settings
- Performance tuning

## Localization

Translations are stored in `assets/i18n/`:
- `app_en.arb` - English
- `app_fr.arb` - French
- `app_es.arb` - Spanish

To add a new language:
1. Create `app_xx.arb` file
2. Add new `AppLocalizationsXx` class in `lib/generated/app_localizations.dart`
3. Update `_AppLocalizationsDelegate` to handle the new locale

## Build & Deployment

### Development Build
```bash
flutter run
```

### Release Build (Android)
```bash
flutter build apk --release
flutter build appbundle --release
```

### Release Build (iOS)
```bash
flutter build ios --release
```

## Debugging

### Enable Debug Mode
Set `debugMode: true` in `lib/config/app_config.dart`

### Performance Monitoring
Use DevTools:
```bash
flutter pub global activate devtools
devtools
```

## Known Issues & TODOs

- [ ] Replace deprecated withOpacity() calls
- [ ] Rename Cart.dart and Product.dart to snake_case
- [ ] Clean up private type warnings
- [ ] Update theme.dart deprecated methods
- [ ] Add offline support
- [ ] Implement caching strategy

## Future Enhancements

- [ ] Dark mode support
- [ ] Push notifications
- [ ] Social login (Google, Facebook)
- [ ] Payment integration
- [ ] Real-time updates (WebSocket)
- [ ] Advanced search and filters
- [ ] User reviews and ratings
