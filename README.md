# Evencir Pulse - Fitness & Wellness App

Evencir Pulse is a modern Flutter application designed to track fitness goals, training plans, and emotional well-being. Built with a robust MVVM architecture and high-performance state management.

## 1. Dependencies Used & Why

| Dependency | Purpose |
|------------|---------|
| **get** | Used for state management (GetX), dependency injection, and advanced routing. |
| **firebase_core** | Essential for initializing Firebase services in the app. |
| **cloud_firestore** | Used as the primary database to store and sync user profile and workout data in real-time. |
| **firebase_auth** | Handles secure user authentication (Login and Registration). |
| **flutter_screenutil** | Ensures a responsive UI across different screen sizes and densities. |
| **table_calendar** | Powers the interactive weekly and monthly training calendar. |
| **geolocator** | Accesses device location to provide localized services. |
| **http** | Used to fetch real-time weather data from external APIs (Open-Meteo). |
| **intl** | Handles complex date formatting and internationalization. |
| **flutter_svg** | Renders high-quality vector icons used throughout the app. |
| **google_fonts** | Integrated to use the 'Mulish' font family for a professional look. |

---

## 2. Project Structure

The project follows a **Feature-Based MVVM** (Model-View-ViewModel) structure for maximum scalability and maintainability:

```text
lib/
 ├── core/              # Global utilities, theme definitions, and app constants.
 ├── features/          # Feature-specific logic separated into modules:
 │    ├── auth/         # Login, Registration, and Session management.
 │    ├── nutritions/   # Daily insights, calories, and hydration tracking.
 │    ├── plan/         # Training calendar and workout management.
 │    ├── mood/         # Interactive circular mood selector.
 │    └── profile/      # User profile management and settings.
 ├── models/            # Shared data models (User, Workout, etc.).
 ├── routes/            # Centralized route management and page definitions.
 ├── services/          # Abstracted services for Firebase, Firestore, and Weather API.
 └── theme/             # Global app styling and color schemes.
```

---

## 3. App Screenshots

[View Screenshots](https://github.com/YOUR_USERNAME/evencir_pulse_app/tree/main/screenshots)

---

## 4. App Video

[Watch App Demo Video](https://drive.google.com/file/d/YOUR_VIDEO_ID/view)

---

## 5. App APK

[Download APK](https://github.com/YOUR_USERNAME/evencir_pulse_app/releases/download/v1.0/app-release.apk)

---

## Submission Details
- **Developer**: Your Name
- **GitHub**: [Your Profile](https://github.com/YOUR_USERNAME)
- **Email**: evencirhr@gmail.com
