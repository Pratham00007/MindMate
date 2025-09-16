

# 🌿 GCGrid - A Flutter Mental Wellness App

**GCGrid** is a mental wellness app built with Flutter, designed specifically for Indian youth. It combines modern UI, empathetic AI, and community support to address everyday mental health challenges with culturally sensitive solutions.

---

## 🌟 Key Features

### 🏠 Homepage
- **Welcoming Interface** with daily mood tracking
- **Mood Check** via intuitive emoji buttons
- **Mental Wellness Tools Grid**:
  - Breathing Exercise
  - Meditation
  - Journal
  - Sleep Stories
- Smooth **animations** and calming **gradients**

### 💬 AI Chatbot (FAB)
- Gemini-like **psychiatrist chatbot**
- Supports **emoji picker**
- **Typing indicators** with animated dots
- **Empathetic, timestamped responses**
- Visually appealing **chat bubbles**

### 🌐 Community Page
- **Support Groups** for various needs:
  - Student Support Circle
  - Anxiety & Depression Support
  - Young Professionals
  - Mindfulness & Meditation
- **Member counts** and ability to **join/leave groups**

### 📅 Appointment Booking
- Dedicated **Emergency Support**
- Browse **available psychiatrists**
- **Doctor profiles** with:
  - Ratings
  - Fees
  - Availability
- Simple **appointment booking**

### 👤 Profile Page
- Personal **user stats** (Sessions, Mood, Streak)
- **Settings** and customization
- Access to **session history** and saved content

---

## 🎨 UI/UX Highlights

- **Modern Design**: Gradients, rounded corners, shadows
- **Smooth Animations**: Slide, fade, and scale via `flutter_animate`
- **Teal/Turquoise Color Theme** with complementary highlights
- **Interactive Elements**: FAB, animated bottom nav bar
- **Chat Features**: Emoji picker, typing indicators, chat bubbles
- **Cultural Sensitivity**: Tailored language and experience for Indian users

---

## 📱 Required Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  google_fonts: ^6.1.0
  animated_bottom_navigation_bar: ^1.3.3
  flutter_animate: ^4.2.0+1
  emoji_picker_flutter: ^1.6.3
  intl: ^0.18.1
````

---

## 🔧 Gemini API Integration

To enable real-time AI support, integrate the Gemini API by updating the `_generateResponse()` method in `ChatScreen.dart`.

```dart
// TODO: Replace this mock with actual Gemini API call
Future<String> _generateResponse(String userMessage) async {
  // Call Gemini API here
}
```

---

## 🇮🇳 Designed for Indian Youth

MindEase goes beyond basic wellness tools:

* **Private AI support** for confidential mental health concerns
* **Community-based connection** to reduce stigma
* **Access to professionals** for timely help
* **Culturally relevant language** and features
* **Appealing design** to promote consistent engagement

---

## 🚀 Get Started

1. Clone the repository:

   ```bash
   git clone https://github.com/Pratham00007/gcgrid.git
   cd gcgrid
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

---

## 📧 Feedback & Contributions

Contributions, suggestions, and feedback are welcome! Open an issue or submit a pull request to help improve GCGrid.

---



> *"Mental wellness is not a luxury — it's a necessity."* 💚

```

---

