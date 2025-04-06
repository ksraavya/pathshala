# 📱 Pathshala Mobile App – XR Learning Experience  

**Team:** Team Hubble

## 🌟 Vision  
Pathshala aims to revolutionize education by providing immersive and accessible XR (Extended Reality) learning experiences for students from all backgrounds. Our mission is to bridge educational gaps by using innovative technology to deliver quality education everywhere.

## 📘 Project Description  
This repository contains the **Flutter-based mobile application** for the Pathshala platform. It offers a modern, responsive interface for students to interact with virtual classrooms, assignments, tests, AR/VR learning content, and a smart AI-powered chatbot.

## 🚀 Key Features
- 🤖 **AI Study Assistant** – Chatbot powered by Gemini API  
- 🎓 **Virtual Classrooms** – Embedded video lessons for core subjects  
- 📈 **Progress Tracking** – Classes attended, hours studied, tests taken  
- 📅 **Calendar View** – Visual schedule of upcoming sessions  
- 🎮 **AR/VR Learning** – Integration with Unity/Blender-based XR modules  
- 🔐 **User Authentication** – Firebase Auth for secure sign-in  
- 🔔 **Smart Notifications** – Alerts for assignments, updates, and events  
- 🧑‍🏫 **Teacher Dashboard Access** – Tools for progress & content tracking  

## 🛠️ Tech Stack
| Component | Technology |
|----------|------------|
| UI Framework | Flutter |
| Language | Dart |
| Backend | Firebase (Auth, Firestore, Storage) |
| AR/VR | Unity + Blender (via Spatial SDK) |
| AI Chatbot | Gemini API |
| State Management | Provider / Riverpod (based on implementation) |
| Video Handling | `video_player` Flutter plugin |

## ⚙️ Getting Started
### 📦 Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (usually included with Flutter)
- Android Studio / VS Code with Flutter plugin
- Firebase project setup (with Android/iOS integration)
- Gemini API key

### 🔧 Installation Steps
1. **Clone the Repository**
   ```bash
   git clone <your-repository-url>
   cd pathshala_mobile
2. **Install Dependencies**
   ```bash
   flutter pub get
3. **Configure Firebase**
   * Follow Firebase setup instructions for Flutter: https://firebase.flutter.dev/docs/overview/
   * Add google-services.json (Android) and GoogleService-Info.plist (iOS) to the appropriate directories.
4. **Set Up Environment Variables**
   * Create a .env file in the root:
   ```bash
   GEMINI_API_KEY=your_gemini_api_key
   FIREBASE_PROJECT_ID=your_firebase_project_id
   * Use the flutter_dotenv package to read the .env values.
5. **Run the App**
   ```bash
   flutter run
   * Make sure the device/ emulator is connected.

## 👥 Contributing
We welcome contributions from the community!

To contribute:
1. Fork this repo
2. Create a new branch (feature/your-feature-name)
3. Commit your changes with clear messages
4. Push and open a Pull Request

Please follow Flutter best practices and keep the codebase clean and well-documented.

## 🪪 License
This project is licensed under the MIT License.

See the LICENSE.md file for details.

---

Designed with ❤️ by Team Hubble
