# Cinema App

A Flutter cinema ticket booking app with Firebase Auth, Firestore, and localization support.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (SDK ^3.10.7)
- Firebase project configured for Android and iOS
- (Optional) [Firebase CLI](https://firebase.google.com/docs/cli) for hosting and Firestore rules

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/<your-username>/cinema_app.git
   cd cinema_app
   ```

2. Copy environment and Firebase config:

   ```bash
   cp .env.example .env
   cp android/app/google-services.json.example android/app/google-services.json
   cp ios/GoogleService-Info.plist.example ios/GoogleService-Info.plist
   ```

   Replace the placeholder values with files downloaded from [Firebase Console](https://console.firebase.google.com/) → Project Settings → Your apps.

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Firebase

This app uses Firebase Auth, Firestore, Crashlytics, and Analytics.

**Do not commit** `google-services.json` or `GoogleService-Info.plist` — they are gitignored. Use the `.example` files as templates and download real configs from Firebase Console.

Restrict API keys in [Google Cloud Console](https://console.cloud.google.com/) to your app bundle IDs and signing certificate fingerprints.

Deploy Firestore rules when ready:

```bash
firebase deploy --only firestore:rules
```

## Project structure

```
lib/
  core/          # Auth, navigation, config, localization
  features/      # Feature modules (auth, movies, booking, etc.)
  shared/        # Reusable widgets
```

## License

Private project — add a license if you plan to open-source it.
