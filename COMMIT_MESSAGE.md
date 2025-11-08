feat: Complete Host Mate onboarding app with multi-modal input support

🎉 Initial implementation of Host Mate - A Flutter application for experience hosting
with comprehensive onboarding flow supporting text, audio, and video inputs.

## Core Features

### Experience Selection Screen
- Card-based experience selection with horizontal scrollable list
- Multi-select functionality with visual feedback
- Description field with 250 character limit and real-time validation
- Dynamic card animation on selection (slides to first index)
- Wavy progress indicator (Step 01/02)
- API integration for fetching experiences
- Responsive layout with keyboard handling

### Question Screen (Onboarding)
- Multi-line text input with 600-word limit
- Real-time word count validation with auto-truncation
- Audio recording:
  * Waveform visualization with real-time amplitude data
  * Recording duration timer
  * Cancel recording functionality
  * Delete recorded audio
  * Audio playback with play/pause controls
- Video recording:
  * Camera integration with front camera preference
  * Video thumbnail generation
  * Recording duration timer
  * Cancel recording functionality
  * Delete recorded video
  * Video playback with play/pause controls
- Dynamic UI layout:
  * Audio/Video buttons disappear when media is recorded
  * Next button expands to full width when both are recorded
  * Smooth animations for state transitions
- Keyboard-aware UI adjustments
- Wavy progress indicator (Step 02/02)

### Thank You Screen
- Advanced animations:
  * Staggered emoji entrance animations
  * Pulsing background effects
  * Floating particle system
  * Shimmer text effect
  * Typewriter text animation
  * Gradient animations
  * Scale and fade transitions
- Fully responsive design

## Brownie Points Implemented

### UI/UX Enhancements
✅ Pixel Perfect Design
- Spacings, fonts, and colors match Figma specifications
- Centralized design system (AppColors, AppTextStyle, AppAssets)
- Custom wavy progress indicator
- Custom waveform visualization

✅ Responsive Design
- Comprehensive Responsive utility class
- Handles mobile, tablet, and desktop screen sizes
- Keyboard-aware layouts
- Dynamic spacing and font sizing

### State Management
✅ BLoC Pattern
- ExperienceBloc for experience selection and management
- QuestionBloc for question text and media recording
- Clean separation of business logic from UI
- Event-driven architecture

✅ Dio for API Calls
- ApiService using Dio for HTTP requests
- Generic ApiResponse<T> model for type-safe responses
- Proper error handling and response parsing

### Animations
✅ Experience Screen
- Card selection animation with slide to first index
- Smooth transitions with scale effects
- Auto-scroll to first position

✅ Question Screen
- Next button width animation on media recording
- Animated visibility transitions
- Smooth state changes

## Additional Enhancements

### Architecture
- Repository pattern implementation (ExperienceRepository)
- Freezed models for immutability (Experience, ApiResponse)
- Centralized asset management (AppAssets)
- Centralized string management (AppStrings)
- Centralized validation utilities (AppValidations)
- Modular widget architecture

### Code Organization
- Extracted reusable components:
  * AudioRecordingWidget
  * VideoRecordingWidget
  * WaveformWidget
  * CommonAppBar
  * CommonNextButton
  * WavyBackground
  * WavyProgressPainter
- Clean import structure with app_imports.dart

### User Experience
- Mock data handling for simulator compatibility
- Comprehensive error handling
- Loading states management
- Real-time validation feedback
- Visual indicators for limits

### Technical Features
- Audio recording with amplitude visualization
- Video recording with thumbnail generation
- File management with proper cleanup
- Camera lifecycle management
- Input validation with auto-truncation
- Cursor position preservation

## Dependencies Added
- flutter_bloc: ^8.1.6 (State management)
- dio: ^5.7.0 (HTTP client)
- record: ^5.1.2 (Audio recording)
- just_audio: ^0.9.40 (Audio playback)
- camera: ^0.11.0+2 (Video recording)
- video_player: ^2.9.2 (Video playback)
- video_thumbnail: ^0.5.3 (Thumbnail generation)
- freezed: ^2.5.2 (Immutable models)
- google_fonts: ^6.2.1 (Space Grotesk font)
- cached_network_image: ^3.4.1 (Image loading)
- flutter_svg: ^2.0.10+1 (SVG support)

## Permissions
- Camera permission (Android & iOS)
- Microphone permission (Android & iOS)
- Storage permission (Android)

## Project Structure
- Clean architecture with separation of concerns
- BLoC pattern for state management
- Repository pattern for data layer
- Modular widget components
- Centralized resources


