# Recipe Finder App 🍳

A modern Flutter application tailored for food enthusiasts to discover, search, and save their favorite recipes. Powered by [TheMealDB API](https://www.themealdb.com/), this app showcases best practices in Flutter development, including Clean Architecture, strict state management with Riverpod, and offline persistence.

## 📱 Features

-   **Deep Discovery**: Browse a vast collection of recipes with support for infinite scrolling (paginated via API).
-   **Smart Search & Filters**: Instantly find what you crave. Search by name with a debounced input or refine by Category (e.g., Seafood, Vegan) and Cuisine (e.g., Italian, Mexican).
-   **Detailed Insights**: View complete recipe details including ingredients, measurements, and step-by-step instructions.
-   **Interactive Experience**:
    -   **Hero Animations**: Smooth transitions when navigating to recipe details.
    -   **Video Integration**: Watch cooking tutorials directly within the app.
    -   **Zoomable Images**: Get a close-up look at the final dish.
-   **Personalized Favorites**: Save your go-to recipes. Favorites are persisted locally using Hive, ensuring they are available even when you're offline.
-   **Adaptive UI**: Toggle between Grid and List views to suit your browsing preference.

## 🛠️ Architecture & Tech Stack

This project is built with scalability and maintainability in mind, following **Clean Architecture** principles and **SOLID** design patterns.

-   **Flutter**: Framework for building the UI.
-   **State Management**: [Riverpod](https://riverpod.dev/) (w/ Code Generation) for robust, compile-time safe state management.
-   **Navigation**: [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
-   **Networking**: [Dio](https://pub.dev/packages/dio) for robust HTTP requests.
-   **Persistence**: [Hive](https://docs.hivedb.dev/) for fast, persistent key-value storage (Favorites & Caching).
-   **Dependency Injection**: Handled naturally via Riverpod providers.
-   **Testing**: Unit and Widget tests ensuring >70% code coverage.

### Project Structure
```
lib/
├── core/             # Global utilities (Theme, Router, API Client)
├── features/
│   ├── recipes/      # Main Recipe Logic (Search, List, Detail)
│   │   ├── data/     # Repositories, Data Sources, Models
│   │   ├── presentation/ # Widgets, Pages, Providers
│   └── favorites/    # Favorites Feature (Strict data separation from recipes)
└── main.dart         # App entry point
```

## 🚀 Getting Started

### Prerequisites
-   Flutter SDK (3.10.4 or higher)
-   Dart SDK

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/recipe-finder.git
    cd recipe_finder
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generators** (Required for Freezed/Riverpod/JsonSerializable):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**:
    ```bash
    flutter run
    ```

## 🧪 Testing

The project includes a comprehensive suite of Unit and Widget tests.

**Run All Tests**:
```bash
flutter test
```

**Generate Coverage Report**:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
# Open coverage/html/index.html to view the report
```

---
*Developed with ❤️ using Flutter.*
