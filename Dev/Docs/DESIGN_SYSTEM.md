# AIVO - Design System

## Color Palette

### Primary Colors
- **Primary Color**: #FF6B6B (Vibrant Red)
- **Primary Variant**: #FF5252 (Darker Red)

### Neutral Colors
- **Background**: #FFFFFF (White)
- **Surface**: #F5F5F5 (Light Gray)
- **Text**: #222222 (Dark Gray)
- **Text Secondary**: #767676 (Medium Gray)
- **Divider**: #ECECEC (Light Gray Border)

### Status Colors
- **Success**: #4CAF50 (Green)
- **Warning**: #FF9800 (Orange)
- **Error**: #F44336 (Red)
- **Info**: #2196F3 (Blue)

## Typography

### Font Family
- **Primary Font**: Muli (Custom)
- **Fallback**: System Default

### Font Sizes
- **Display Large**: 32sp (Bold)
- **Display Medium**: 28sp (Bold)
- **Headline 1**: 24sp (Bold)
- **Headline 2**: 20sp (Bold)
- **Title**: 18sp (Medium)
- **Body Large**: 16sp (Regular)
- **Body Medium**: 14sp (Regular)
- **Body Small**: 12sp (Regular)
- **Caption**: 11sp (Regular)

### Font Weights
- **Light**: 300
- **Regular**: 400
- **Medium**: 500
- **Bold**: 700
- **Extra Bold**: 800

## Spacing

### Scale (in dp/pt)
- **xs**: 4
- **sm**: 8
- **md**: 16
- **lg**: 24
- **xl**: 32
- **xxl**: 48

## Border Radius

### Standard Radius Values
- **Small**: 8px (Small buttons, chips)
- **Medium**: 12px (Cards, dialogs)
- **Large**: 16px (Large buttons, input fields)
- **Extra Large**: 20px (Bottom sheets)
- **Circular**: 50%

## Shadows

### Elevation Levels
- **Level 1 (Card)**: 2dp elevation
- **Level 2 (Dialog)**: 4dp elevation
- **Level 3 (FAB)**: 6dp elevation
- **Level 4 (Nav Drawer)**: 8dp elevation

## Component Design

### Buttons

#### Primary Button
- Background: Primary Color (#FF6B6B)
- Text: White
- Padding: 12dp vertical, 24dp horizontal
- Radius: 16px
- Height: 48dp

#### Secondary Button
- Background: Surface (#F5F5F5)
- Text: Primary Color (#FF6B6B)
- Padding: 12dp vertical, 24dp horizontal
- Radius: 16px
- Height: 48dp

### Input Fields

#### Text Input
- Border: Primary Color (#FF6B6B)
- Radius: 28px
- Padding: 20dp vertical, 42dp horizontal
- Height: 56dp
- Clear icon available

### Cards

- Background: White
- Elevation: 2dp
- Radius: 12px
- Padding: 16dp

### AppBar

- Background: White
- Height: 56dp (Material Standard)
- Elevation: 0 (Flat)
- Title Color: Dark (#222222)
- Icon Color: Dark (#222222)

## Icons

### Icon Sizes
- **Small**: 16dp
- **Medium**: 24dp (Standard)
- **Large**: 32dp
- **Extra Large**: 48dp

### Icon Style
- SVG format (vector based)
- Consistent stroke width
- Color: Inherit from text color

## Responsive Design

### Breakpoints
- **Mobile**: < 600dp
- **Tablet**: 600dp - 1200dp
- **Desktop**: >= 1200dp

### Padding Rules
- **Mobile**: 16dp horizontal padding
- **Tablet**: 24dp horizontal padding
- **Desktop**: 32dp horizontal padding

## Dark Mode (Future)

### Dark Colors (Placeholder)
- **Background**: #1e1e1e
- **Surface**: #2a2a2a
- **Text**: #ffffff
- **Text Secondary**: #b0b0b0

## Animations

### Duration Standards
- **Short**: 150ms (Micro-interactions)
- **Medium**: 300ms (Transitions)
- **Long**: 500ms (Complex animations)

### Easing Curves
- **In**: EaseIn (Start animations)
- **Out**: EaseOut (End animations)
- **InOut**: EaseInOut (Smooth transitions)

## Accessibility

### WCAG Compliance
- Minimum text size: 12dp (body text)
- Contrast ratio: 4.5:1 for text
- Touch targets: Minimum 48x48dp
- Focus indicators: Clear and visible

### Color Contrast
- Text on Primary: 7:1 (AAA)
- Text on Surface: 5:1 (AA)

## Motion

### Transitions
- Page transitions: 300ms
- Widget animations: 200ms
- Color transitions: 300ms

## Spacing Grid

All spacing follows an 8dp base grid for consistency:
```
4dp (1x)
8dp (2x)
16dp (4x)
24dp (6x)
32dp (8x)
48dp (12x)
```
