# Briskpe KYC & ID Upload Flutter Application

A pixel-perfect Flutter UI implementation of the Briskpe KYC and Director's Document Verification flow based on Adobe XD design specifications.

## Architecture

- Feature-first clean-architecture-lite structure.
- State management: `flutter_bloc` / `Kubit`.
- Navigation: `go_router` with centralized route names.
- Responsiveness: `flutter_screenutil` based on standard 375x812 frame.
- Strict design tokens: `AppColors`, `AppDimensions`, `AppTextStyles`, `AppAssets`, `AppStrings`, `Validators`.
- Zero analyzer warnings and strict null safety.

## Screens Implemented

1. **KYC Intro & Consent Screen** (`/`)
   - Header with styled highlights
   - Requirement checklist cards ("What to keep handy?", "Why do we need KYC?")
   - Interactive Terms of Use & Privacy Policy consent checkbox
   - Primary "Agree and Continue" action

2. **Director's PAN Details (Upload State)** (`/pan-upload`)
   - 4-step progress header with percentage indicator
   - Dashed document dropzone container
   - "Browse" action with bottom sheet selector (allows testing coloured PAN and black & white document validation error)
   - "Take Photo" action triggering the camera viewfinder
   - Document upload status checklist (Uploading, Extracting, Verifying)
   - RBI & Data security compliance footer badges

3. **Director's PAN Details (Validation / Error State)**
   - In-context error card: "Black and white document detected - Kindly make sure the document uploaded is a coloured soft copy of the director's PAN card."

4. **Camera Viewfinder / Take Photo Screen** (`/take-photo`)
   - Dark modal preview with sample PAN card alignment viewfinder guide
   - Guidance copy
   - Controls: Flash toggle, Shutter capture with interactive animation, Camera flip toggle

5. **Director's PAN Details (Preview State)**
   - Document preview card displaying captured / selected PAN card
   - "Remove" and "Change" actions
   - Bottom primary "Upload" button triggering simulated verification progression

## Common Reusable Widgets

- `AppTextField`: Fully configurable text field with validation, password toggle, focus and error states.
- `AppBottomSheet`: Modal bottom sheet with drag handle, header, and customizable action footer.
- `AppRadioButton`: Custom animated radio button with title and subtitle support.
- `AppButton`: Multi-variant button supporting primary, secondary, outline, text, loading, and disabled states.
- `AppAppBar`: Standard header with back navigation.
- `AppCard`: Standard container with customizable background tint, border, and shadows.
- `AppCheckbox`: Styled checkbox matching XD specs.
- `AppDashedBox`: Custom painter dashed border container for dropzones.
- `AppStepIndicator`: 4-stage circular stepper.

## Setup & Run Instructions

### Prerequisites
- Flutter SDK (3.10.7+ or compatible)
- Dart SDK (3.10+)

### Setup
```bash
flutter pub get
```

### Run
```bash
flutter run
```

### Analyze
```bash
dart analyze
```

### Run Tests
```bash
flutter test
```

### Build Android Debug APK
```bash
flutter build apk --debug
```
