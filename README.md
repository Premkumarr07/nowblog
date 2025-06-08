# nowblog

A Flutter application demonstrating user management using the BLoC pattern, API integration, and clean architecture principles.

![App Screenshot](lib/image/Screenshot%202025-06-08%20131526.png)

## 🚀 Features

### 1. API Integration
- Integrated with [DummyJSON Users API](https://dummyjson.com/users)
- Pagination using `limit` and `skip`
- Real-time search by user name
- Infinite scrolling for user list
- Nested fetch: user posts and todos
  - [Posts API](https://dummyjson.com/posts/user/{userId})
  - [Todos API](https://dummyjson.com/todos/user/{userId})

### 2. BLoC State Management
- State management using [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)
- Separate events and states for:
  - Fetching users
  - Searching users
  - Pagination
  - Loading posts and todos
- Handles loading, success, and error states
- Clean business logic separation

### 3. UI Features
- **User List Screen**: Avatar, name, and email
- **Search Bar**: Real-time filtering
- **User Detail Screen**: Info + posts + todos
- **Create Post Screen**: Add posts locally (title & body)
- **Loading Indicators**
- **Error Messages**

### 4. Code Quality
- Clean, modular folder structure
- Follows Dart and Flutter best practices
- Error handling and edge cases managed gracefully

### ⭐ Bonus Features
- Pull-to-refresh
- (Optional) Offline caching using local storage
- (Optional) Light/Dark mode toggle

---

## 🔧 Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Internet access for API calls

### Setup Instructions

```bash
git clone https://github.com/Premkumarr07/nowblog.git
cd nowblog
flutter pub get
flutter run
