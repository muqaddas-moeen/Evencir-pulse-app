
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

[register](https://github.com/user-attachments/assets/c20c3f62-f012-4446-99eb-a9959534bc36)

[login](https://github.com/user-attachments/assets/c111fb34-6a1a-44dc-9989-00ac52e53c58)

[nutrition](https://github.com/user-attachments/assets/42249a8c-2ba9-4ee9-b5d0-0e8f22a975f8)

[plan](https://github.com/user-attachments/assets/8967766b-38b6-4e2a-b04d-5a31931f549a)

[mood](https://github.com/user-attachments/assets/7fdc4dc3-202b-4e39-bc46-13127ff1311d)

[profile](https://github.com/user-attachments/assets/aa684f5a-1128-406f-a138-424256063fd3)


---

## 4. App Video


[Watch App Demo Video](https://drive.google.com/file/d/1LzqBEq-YRdYI92drFgQB2L5NYr5QmVGg/view?usp=sharing)

---

## 5. App APK

[Download APK](https://github.com/muqaddas-moeen/Evencir-pulse-app/releases/tag/v1.0)

---

## Submission Details
- **Developer**: Muqaddas Moeen
- **GitHub**: [Your Profile](https://github.com/muqaddas-moeen)
- **Email**: moeenmuqaddas@gmail.com
