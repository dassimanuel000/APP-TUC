
# Internal Collaborator Listing & Job Alerts Mobile App

## Description

This mobile application is designed for internal collaborators of a company to stay informed about articles and job offers from partner companies. The app provides real-time alerts and a dynamic interface that enhances user interaction. It allows employees to view, search, and save job offers and articles from partners in a user-friendly environment.

The app is developed using **Flutter** and interacts with a **Laravel API** for managing content and user authentication. The application also implements a **Two-Factor Authentication (2FA)** system for enhanced security and uses **middleware** to handle API requests. 

The application features push notifications, powered by **Firebase**, and saves offline data with **SQLite**.

## Features

- **Real-time notifications**: Receive push notifications for new articles and job offers via Firebase and native notification systems.
- **Listing system**: Displays a list of articles and job offers from partner companies.
- **Job alerts**: Customizable alerts for specific types of job offers.
- **Dynamic user interface**: Responsive and interactive design for a smooth user experience.
- **Two-Factor Authentication (2FA)**: Secure login and access using 2FA.
- **Middleware for API handling**: Ensures secure and efficient communication between the mobile app and the backend API.
- **SQLite local storage**: Saves data locally on the device for offline access and quicker response times.
- **Laravel API**: The backend is built on Laravel with SQL database integration, providing secure and scalable data handling.

## Tech Stack

- **Frontend**: Flutter (Dart)
  - Main entry file: `lib/main.dart`
  - Dynamic UI for listing and job alerts
  - Firebase notifications
  - SQLite for offline data storage
- **Backend**: Laravel API
  - Runs on a SQL server at port 8000
  - Middleware for API request handling
  - 2FA integration for authentication
- **Database**: 
  - SQL server on port 8000 for API
  - SQLite for local storage on the mobile app
- **Notifications**:
  - Firebase Cloud Messaging (FCM) for real-time alerts
  - Native push notifications for Android and iOS

## Installation

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio/Xcode for emulator/simulator testing
- Laravel setup (for API)
- SQL Server running on port 8000
- Firebase account (for push notifications)

### Steps

1. **Clone the repository**:
   ```bash
   git clone [https://github.com/dassimanuel000/APP-TUC.git](https://github.com/dassimanuel000/APP-TUC.git)
   cd APP-TUC
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up Firebase for push notifications**:
   - Create a Firebase project and configure it for both Android and iOS.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the respective project directories.

4. **Set up the Laravel API**:
   - Clone the Laravel API repository and ensure it's running on a SQL server (port 8000).
   - Configure middleware and 2FA according to project requirements.

5. **Run the application**:
   - For Android:
     ```bash
     flutter run
     ```
   - For iOS:
     ```bash
     flutter run --release
     ```

## API Documentation

The Laravel API includes endpoints for:
- **Job Offers**: Listing, filtering, and retrieving job offers from partner companies.
- **Articles**: Listing, filtering, and retrieving articles from partners.
- **Authentication**: Secure login with 2FA.
- **Notifications**: Trigger notifications for new articles or job offers.

For more details, refer to the API documentation located at `/docs/api`.

## Firebase Notification Setup

To enable push notifications:
1. Set up Firebase Cloud Messaging (FCM).
2. Follow the Firebase setup guide to generate the required configuration files for Android and iOS.
3. Implement notification listeners in `lib/main.dart`.

## SQLite Local Storage

SQLite is used to store articles and job offers locally for offline viewing. When the app retrieves data from the API, it saves it to the local SQLite database to ensure content can be accessed even without an internet connection.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contribution

Feel free to open issues or submit pull requests if you want to contribute!

--- 

Let me know if you want to modify any part of this README!
