# Amazon Clone

An Amazon clone application with an admin dashboard, developed using Flutter. This project implements key features of an e-commerce platform and is structured using MVC, with state management handled by Provider and BLoC.
## Features 
- **User Interface** :
- 📜 Browse products by categories.
- 📝 Product details with images and descriptions.
- 🛒 Shopping cart and checkout process.
- 👤 User account management. 
- **Admin Dashboard** :
- ➕ Add, edit, and delete products.
- 🗂️ Manage product categories.
- 📦 View order details and status. 
- **State Management** :
- 🔧 Utilized Provider for dependency injection and state management.
- 🧩 Used BLoC pattern for business logic and state management, ensuring a clear separation of concerns. 
- **Responsive Design** :
- 📱 Optimized for both mobile and tablet devices.
- 📐 Ensured a consistent and seamless user experience across different screen sizes. 
- **Backend Integration** :
- 🔗 Connected to Firebase for backend services.
- 🔒 Implemented authentication and authorization for both users and admin.
## Installation 
1. **Clone the repository** :

```bash
git clone https://github.com/yourusername/amazon-clone.git
``` 
2. **Navigate to the project directory** :

```bash
cd amazon-clone
``` 
3. **Install dependencies** :

```bash
flutter pub get
``` 
4. **Configure Firebase** : 
- Follow the Firebase setup instructions for both Android and iOS: 
- [Firebase setup for Android]() 
- [Firebase setup for iOS]() 
5. **Run the app** :

```bash
flutter run
```
## Screenshots
![Screenshot1](/screenshots/photo_2024-05-29_22-22-33.jpg)
![Screenshot2](/screenshots/photo_2024-05-29_22-22-37.jpg)
![Screenshot3](/screenshots/photo_2024-05-29_22-22-40.jpg)
![Screenshot4](/screenshots/photo_2024-05-29_22-22-44.jpg)
![Screenshot5](/screenshots/photo_2024-05-29_22-22-58.jpg)
![Screenshot6](/screenshots/photo_2024-05-29_22-23-06.jpg)
![Screenshot7](/screenshots/photo_2024-05-29_22-26-36.jpg)
![Screenshot8](/screenshots/photo_2024-05-29_22-26-40.jpg)



## Project Structure

```plaintext
amazon-clone/
├── lib/
│   ├── models/
│   ├── views/
│   ├── controllers/
│   │   ├── blocs/
│   │   ├── providers/
│   │   ├── services/
│   └── main.dart
├── assets/
├── test/
└── pubspec.yaml
```

 
- **models** : Data models used in the application. 
- **views** : UI components and screens. 
- **controllers** : Controllers for managing the flow between UI and business logic, including state management and services. 
- **blocs** : State management using BLoC pattern. 
- **providers** : State management using Provider. 
- **services** : API services and other utilities. 
- **main.dart** : Entry point of the application.
## Contributions

🤝 Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.
## License

📜 This project is licensed under the MIT License. See the [LICENSE]()  file for more details.
## Acknowledgements 
- Flutter: [https://flutter.dev](https://flutter.dev/) 
- Provider: [https://pub.dev/packages/provider]() 
- BLoC: [https://bloclibrary.dev](https://bloclibrary.dev/) 
- Firebase: [https://firebase.google.com](https://firebase.google.com/)
