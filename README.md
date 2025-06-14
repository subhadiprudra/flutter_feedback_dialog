# FlutterFeedbackDialog

FlutterFeedbackDialog is a customizable and easy-to-use Flutter package for collecting user feedback through dialog popups. It supports text input, image attachments, and integrates seamlessly into any Flutter app.

## Features

- **Multiple Feedback Types:**  
  Collect feedback, bug reports, feature requests, or contact messages with customizable dialog types.

- **Customizable Themes:**  
  Supports both light and dark themes for dialogs.

- **Image Attachments:**  
  Users can attach screenshots or images to their feedback.

- **Customizable UI:**  
  Change dialog titles, subtitles, button texts, icons, and gradients for each feedback type.

- **Easy Integration:**  
  Show the dialog with a single function call and handle submissions via a callback.

- **Success Messages:**  
  Show custom success messages after feedback is submitted.

- **Validation:**  
  Built-in validation for required fields.

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_feedback_dialog: ^0.0.1
```

Import in your Dart code:

```dart
import 'package:flutter_feedback_dialog/flutter_feedback_dialog.dart';
```

## Usage

```dart
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.feedback, // or .bug, .featureRequest, .contact
  theme: CommunicationTheme.light, // or .dark
  onSubmit: (CommunicationResponse response) {
    // Handle the feedback data
    print(response.message);
    print(response.email);
    print(response.screenshots);
  },
);
```

## Screenshots

Below are examples of the feedback dialog in different modes and types:

### Feedback
| Light | Dark |
|-------|------|
| ![Feedback Light 1](screenshots/feedback_1_light.png) ![Feedback Light 2](screenshots/feedback_2_light.png) | ![Feedback Dark](screenshots/feedback_dark.png) |

### Bug Report
| Light | Dark |
|-------|------|
| ![Bug Light 1](screenshots/bug_1_light.png) ![Bug Light 2](screenshots/bug_2_light.png) | ![Bug Dark](screenshots/bug_dark.png) |

### Feature Request
| Light | Dark |
|-------|------|
| ![Feature Light 1](screenshots/feature_1_light.png) ![Feature Light 2](screenshots/feature_2_light.png) | ![Feature Dark](screenshots/feature_dark.png) |

### Contact
| Light | Dark |
|-------|------|
| ![Contact Light 1](screenshots/contact_1_light.png) ![Contact Light 2](screenshots/contact_2_light.png) | ![Contact Dark](screenshots/contact_dark.png) |

You can also customize dialog content by passing additional parameters like `title`, `subtitle`, `buttonText`, `icon`, `placeholder`, etc.

## Example

See the [`example/`](example/) directory for a full demo with type and theme switching.

## Backend & API Options

You can collect feedback using your own backend by handling the dialog's submission callback. For a seamless experience, you can also use the [FeedbackNest API](https://feedbacknest.app) and dashboard:

- **Easy setup:** Obtain an API key from your FeedbackNest dashboard.
- **Centralized management:** View all feedback, bug reports, feature requests, and user metrics in one place.
- **No backend required:** Skip building your own feedback infrastructure.

See the [Dashboard & API Key](#dashboard--api-key) section below for details.

## Additional Information

- **Documentation:** See API docs for details.
- **Contributing:** Pull requests and issues are welcome!
- **License:** MIT

---

Build better feedback experiences with **FlutterFeedbackDialog**!