# Flutter Portfolio

A modern, responsive portfolio website built with Flutter. Designed with a mobile-first approach, it automatically adapts to look great on phones, tablets, and desktop screens.

## Features

- 📱 **Mobile-First Design** - Optimized for mobile, scales beautifully to desktop
- 🎨 **Responsive Layout** - 4 breakpoints: Mobile, Tablet, Desktop, Large Desktop
- 🌙 **Dark/Light Theme** - Automatic theme switching with system preference
- ✨ **Smooth Animations** - Entry animations, scroll effects, and hover interactions
- 🧭 **Smart Navigation** - Sidebar (desktop), Navbar (tablet), Drawer (mobile)
- 📄 **5 Sections**: Hero, About, Projects, Skills, Contact

## Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 600px | Single column, bottom nav |
| Tablet | 600px - 1023px | 2 columns, top nav bar |
| Desktop | 1024px - 1439px | Multi-column, sidebar |
| Large Desktop | ≥ 1440px | Max-width container, expanded sidebar |

## Screenshots

### Mobile Layout
- Collapsible app bar with menu
- Single column content
- Bottom navigation

### Tablet Layout
- Top navigation bar
- 2-column grids
- Compact sidebar

### Desktop Layout
- Fixed sidebar navigation
- Multi-column layouts
- Hover effects on project cards

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd flutter_portfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── responsive/
│   │   └── responsive_utils.dart    # Breakpoints & responsive helpers
│   ├── theme/
│   │   └── app_theme.dart           # Light & dark themes
│   └── constants/
│       └── portfolio_data.dart      # Personal info, projects, skills
├── presentation/
│   ├── blocs/
│   │   └── navigation/              # Navigation state management
│   ├── screens/
│   │   └── portfolio_screen.dart    # Main portfolio screen
│   ├── sections/
│   │   ├── hero_section.dart        # Hero/landing section
│   │   ├── about_section.dart       # About & experience
│   │   ├── projects_section.dart    # Projects grid
│   │   ├── skills_section.dart      # Skills & services
│   │   └── contact_section.dart     # Contact form
│   └── widgets/
│       └── navigation/              # Nav bar, sidebar, drawer
└── main.dart
```

## Customization

### Personal Information

Edit `lib/core/constants/portfolio_data.dart`:

```dart
static const String name = 'Your Name';
static const String title = 'Your Title';
static const String email = 'your@email.com';
// ... more
```

### Colors & Theme

Edit `lib/core/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6366F1);
static const Color accentColor = Color(0xFF06B6D4);
// ... more
```

### Breakpoints

Edit `lib/core/responsive/responsive_utils.dart`:

```dart
static const double mobile = 600;
static const double tablet = 1024;
static const double desktop = 1440;
```

## Responsive Widgets

### ResponsiveBuilder

```dart
ResponsiveBuilder(
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
  largeDesktop: LargeDesktopWidget(),
)
```

### Responsive.value

```dart
final padding = Responsive.value<EdgeInsets>(
  context: context,
  mobile: EdgeInsets.all(16),
  tablet: EdgeInsets.all(24),
  desktop: EdgeInsets.all(32),
);
```

### ResponsiveContainer

```dart
ResponsiveContainer(
  child: YourWidget(), // Centers with max-width of 1440px
)
```

## Tech Stack

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management |
| `google_fonts` | Typography |
| `animated_text_kit` | Typewriter animation |
| `flutter_animate` | Entry animations |
| `font_awesome_flutter` | Icons |
| `scrollable_positioned_list` | Smooth scroll to sections |

## Building for Production

### Web
```bash
flutter build web --release
```

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Deployment

### GitHub Pages

1. Build for web:
```bash
flutter build web --release --base-href /your-repo-name/
```

2. Deploy `build/web` folder to GitHub Pages

### Firebase Hosting

```bash
firebase deploy
```

### Netlify/Vercel

Drag and drop the `build/web` folder.

## License

MIT License - feel free to use this template for your own portfolio!

## Credits

- Design inspired by modern portfolio trends
- Icons by Font Awesome
- Fonts by Google Fonts
