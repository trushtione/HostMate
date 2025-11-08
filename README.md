# Host Mate

A Flutter application for experience hosting that allows users to select experiences and provide multi-modal answers (text, audio, video) to onboarding questions.

## 📱 Features Implemented

### 1. Experience Selection Screen
- **Card-based Experience Selection**: Users can select multiple experience cards from a horizontal scrollable list
- **Dynamic Card Animation**: Selected cards animate and slide to the first index position
- **Description Field**: Multi-line text input with 250 character limit
- **Character Limit Validation**: Real-time validation with auto-truncation and error messages
- **Progress Indicator**: Wavy progress bar in the app bar showing step 01/02
- **Responsive Layout**: Adapts to different screen sizes and keyboard visibility
- **API Integration**: Fetches experiences from backend API

### 2. Question Screen (Onboarding)
- **Multi-line Text Input**: Text field with 600-word limit
- **Word Limit Validation**: Real-time word count validation with auto-truncation
- **Audio Recording**:
  - Record audio answers with waveform visualization
  - Real-time amplitude data display
  - Cancel recording functionality
  - Delete recorded audio
  - Audio playback (play/pause controls)
  - Recording duration timer
- **Video Recording**:
  - Record video answers using device camera
  - Video thumbnail generation
  - Cancel recording functionality
  - Delete recorded video
  - Video playback (play/pause controls)
  - Recording duration timer
- **Dynamic UI Layout**:
  - Audio/Video recording buttons disappear when corresponding media is recorded
  - Next button expands to full width when both audio and video are recorded
  - Smooth animations for button visibility changes
- **Keyboard Handling**: UI adjusts when keyboard is open/closed
- **Progress Indicator**: Wavy progress bar showing step 02/02

### 3. Thank You Screen
- **Advanced Animations**:
  - Staggered emoji animations (3 emojis with sequential entrance)
  - Pulsing background effects
  - Floating particle system
  - Shimmer text effect
  - Typewriter text animation
  - Gradient animations
  - Scale and fade transitions
- **Responsive Design**: Adapts to all screen sizes

## 🎯 Brownie Points Implemented

### UI/UX Enhancements
✅ **Pixel Perfect Design**
- Spacings, fonts, and colors match Figma design specifications
- Consistent design system with centralized assets, colors, strings, and text styles
- Custom wavy progress indicator
- Custom waveform visualization for audio

✅ **Responsive Design**
- Comprehensive responsive utility class (`Responsive`) for:
  - Padding (horizontal/vertical)
  - Spacing
  - Font sizes
  - Card sizes
- Handles different screen widths (mobile, tablet, desktop)
- Keyboard-aware layouts that adjust when keyboard opens/closes

### State Management
✅ **BLoC Pattern Implementation**
- `ExperienceBloc`: Manages experience selection, description, and reordering
- `QuestionBloc`: Handles question text, audio recording, video recording, and playback
- Clean separation of business logic from UI
- Event-driven architecture

✅ **Dio for API Calls**
- `ApiService` using Dio for HTTP requests
- Proper error handling and response parsing
- Generic `ApiResponse<T>` model for type-safe responses

### Animations
✅ **Experience Screen Animations**
- **Card Selection Animation**: When a card is selected, it smoothly animates and slides to the first index position
- Slide transition with scale effect
- Smooth scrolling to first position
- 500ms animation duration with easeInOut curve

✅ **Question Screen Animations**
- **Next Button Width Animation**: The Next button smoothly expands to full width when audio/video recording buttons disappear
- Animated visibility transitions for recording buttons
- Smooth state transitions

## 🚀 Additional Features & Enhancements

### Architecture Improvements
- **Repository Pattern**: Implemented `ExperienceRepository` interface with `ExperienceRepositoryImpl` for better testability and maintainability
- **Freezed Models**: Used Freezed for immutable data models with JSON serialization
  - `Experience` model with `@freezed` annotation
  - `ApiResponse<T>` generic model for API responses
- **Centralized Asset Management**: `AppAssets` class for all asset paths
- **Centralized Strings**: `AppStrings` class for all UI strings
- **Centralized Validations**: `AppValidations` utility class for input validations
- **Centralized Colors**: `AppColors` class for consistent color scheme
- **Centralized Text Styles**: `AppTextStyle` class for consistent typography

### Code Organization
- **Modular Widgets**: Extracted reusable components:
  - `AudioRecordingWidget`: Encapsulates audio recording UI and logic
  - `VideoRecordingWidget`: Encapsulates video recording UI and logic
  - `WaveformWidget`: Reusable waveform visualization
  - `CommonAppBar`: Reusable app bar with progress indicator
  - `CommonNextButton`: Reusable next button component
  - `WavyBackground`: Background widget with wavy image
  - `WavyProgressPainter`: Custom painter for progress indicator
- **Clean Imports**: Centralized `app_imports.dart` for common exports

### User Experience Enhancements
- **Mock Data Handling**: Support for mock data paths to enable testing on simulators where real camera/audio might not be available
- **Error Handling**: Comprehensive error handling for:
  - Camera initialization failures
  - Audio recording errors
  - Video recording errors
  - API call failures
- **Loading States**: Proper state management for loading, success, and error states
- **Real-time Feedback**: 
  - Word/character count indicators
  - Error messages for limit violations
  - Visual feedback for recording states

### Technical Features
- **Audio Recording**: 
  - Real-time amplitude data collection
  - Waveform visualization
  - Playback with `just_audio` package
  - File management with proper cleanup
- **Video Recording**:
  - Camera initialization with front camera preference
  - Video thumbnail generation using `video_thumbnail` package
  - Video playback with `video_player` package
  - Proper camera controller lifecycle management
- **Input Validation**:
  - Character limit validation (250 for description)
  - Word limit validation (600 words for question)
  - Auto-truncation with cursor position preservation
  - Visual indicators for approaching limits

## 📦 Dependencies

### Core
- `flutter_bloc: ^8.1.6` - State management
- `equatable: ^2.0.5` - Value equality
- `dio: ^5.7.0` - HTTP client

### UI/UX
- `google_fonts: ^6.2.1` - Custom fonts (Space Grotesk)
- `flutter_svg: ^2.0.10+1` - SVG support
- `cached_network_image: ^3.4.1` - Image loading

### Audio/Video
- `record: ^5.1.2` - Audio recording
- `just_audio: ^0.9.40` - Audio playback
- `camera: ^0.11.0+2` - Video recording
- `video_player: ^2.9.2` - Video playback
- `video_thumbnail: ^0.5.3` - Thumbnail generation
- `path_provider: ^2.1.4` - File system paths

### Code Generation
- `freezed: ^2.5.2` - Immutable models
- `json_serializable: ^6.8.0` - JSON serialization
- `build_runner: ^2.4.13` - Code generation

## 🏗️ Project Structure

```
lib/
├── bloc/
│   ├── experience/
│   │   ├── experience_bloc.dart
│   │   ├── experience_event.dart
│   │   └── experience_state.dart
│   └── question/
│       ├── question_bloc.dart
│       ├── question_event.dart
│       └── question_state.dart
├── models/
│   ├── experience.dart
│   └── api_response.dart
├── repositories/
│   ├── experience_repository.dart
│   └── experience_repository_impl.dart
├── res/
│   ├── commons/
│   │   ├── app_assets.dart
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── app_text_style.dart
│   │   ├── app_validations.dart
│   │   ├── common_appbar.dart
│   │   ├── common_next_button.dart
│   │   ├── responsive.dart
│   │   ├── wavy_background.dart
│   │   ├── wavy_progress_painter.dart
│   │   └── waveform_widget.dart
│   ├── audio_recording_widget.dart
│   ├── video_recording_widget.dart
│   └── app_imports.dart
├── screens/
│   ├── experience_selection_screen.dart
│   ├── question_screen.dart
│   └── thank_you_screen.dart
├── services/
│   └── api_service.dart
└── main.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Host_mate
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code (for Freezed models):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

### Permissions

#### Android
- Camera permission (for video recording)
- Microphone permission (for audio recording)
- Storage permission (for saving recordings)

#### iOS
- `NSCameraUsageDescription` in `Info.plist`
- `NSMicrophoneUsageDescription` in `Info.plist`

## 📝 Notes

- The app handles mock data paths for simulator compatibility
- All recordings are stored locally
- The app uses a dark theme with custom color scheme
- Space Grotesk font family is used throughout the app

## 🎨 Design System

- **Colors**: Defined in `AppColors` class
- **Typography**: Defined in `AppTextStyle` class with Space Grotesk font
- **Spacing**: Responsive spacing using `Responsive` utility
- **Assets**: Centralized in `AppAssets` class

## 📄 License

This project is a Flutter application for experience hosting.

---

**Built with ❤️ using Flutter**
