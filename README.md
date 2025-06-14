# FlutterFeedbackDialog

A customizable and easy-to-use Flutter package for collecting user feedback through beautiful dialog popups. Supports text input, image attachments, and integrates seamlessly with the **free** [FeedbackNest](https://feedbacknest.app) backend.

<div align="center">

[![pub version](https://img.shields.io/pub/v/flutter_feedback_dialog.svg)](https://pub.dev/packages/flutter_feedback_dialog)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Quick Start](#-quick-start)
- [Step-by-Step Setup](#-step-by-step-setup)
- [Usage Examples](#-usage-examples)
- [FeedbackNest Integration](#-feedbacknest-integration)
- [Customization](#-customization)
- [Example App](#-example-app)
- [Contributing](#-contributing)

## ✨ Features

- **🎯 Multiple Feedback Types**: Feedback, bug reports, feature requests, and contact forms
- **🎨 Dual Themes**: Beautiful light and dark theme support
- **📸 Image Attachments**: Users can attach screenshots or images
- **🔧 Fully Customizable**: Titles, subtitles, buttons, icons, colors, and more
- **⚡ Simple Integration**: Show dialogs with a single function call
- **✅ Built-in Validation**: Form validation for required fields
- **🔄 Success Messages**: Custom success notifications
- **☁️ Free Backend**: Optional integration with FeedbackNest (completely free!)

## 📸 Screenshots

### Light Theme Dialogs
| Feedback | Bug Report | Feature Request | Contact |
|----------|------------|-----------------|---------|
| ![Feedback Light 1](screenshots/feedback_1_light.png)<br/>![Feedback Light 2](screenshots/feedback_2_light.png) | ![Bug Light 1](screenshots/bug_1_light.png)<br/>![Bug Light 2](screenshots/bug_2_light.png) | ![Feature Light 1](screenshots/feature_1_light.png)<br/>![Feature Light 2](screenshots/feature_2_light.png) | ![Contact Light 1](screenshots/contact_1_light.png)<br/>![Contact Light 2](screenshots/contact_2_light.png) |

### Dark Theme Dialogs
| Feedback | Bug Report | Feature Request | Contact |
|----------|------------|-----------------|---------|
| ![Feedback Dark](screenshots/feedback_dark.png) | ![Bug Dark](screenshots/bug_dark.png) | ![Feature Dark](screenshots/feature_dark.png) | ![Contact Dark](screenshots/contact_dark.png) |

## 🚀 Quick Start

### 1. Add Dependencies

```yaml
dependencies:
  flutter_feedback_dialog: ^0.0.1
  feedbacknest_core: ^0.0.2  # Optional: for free backend integration
```

### 2. Import Package

```dart
import 'package:flutter_feedback_dialog/flutter_feedback_dialog.dart';
```

### 3. Show Dialog

```dart
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.feedback,
  theme: CommunicationTheme.light,
  onSubmit: (response) {
    print('Feedback: ${response.message}');
  },
);
```

## 📖 Step-by-Step Setup

### Step 1: Installation

Run this command in your Flutter project:

```bash
flutter pub add flutter_feedback_dialog
```

### Step 2: Import the Package

Add the import statement to your Dart file:

```dart
import 'package:flutter_feedback_dialog/flutter_feedback_dialog.dart';
```

### Step 3: Basic Implementation

Add a button to trigger the feedback dialog:

```dart
ElevatedButton(
  onPressed: () {
    FlutterFeedbackDialog.show(
      context,
      type: CommunicationViewType.feedback,
      theme: CommunicationTheme.light,
      onSubmit: (CommunicationResponse response) {
        // Handle the response
        print('Message: ${response.message}');
        print('Email: ${response.email}');
        print('Screenshots: ${response.screenshots?.length ?? 0}');
      },
    );
  },
  child: Text('Give Feedback'),
)
```

### Step 4: Handle Different Feedback Types

```dart
// Feedback Dialog
FlutterFeedbackDialog.show(context, type: CommunicationViewType.feedback);

// Bug Report Dialog
FlutterFeedbackDialog.show(context, type: CommunicationViewType.bug);

// Feature Request Dialog
FlutterFeedbackDialog.show(context, type: CommunicationViewType.featureRequest);

// Contact Dialog
FlutterFeedbackDialog.show(context, type: CommunicationViewType.contact);
```

## 💻 Usage Examples

### Basic Usage

```dart
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.feedback,
  theme: CommunicationTheme.light,
  onSubmit: (CommunicationResponse response) {
    // Process the feedback
    print('User feedback: ${response.message}');
    print('User email: ${response.email}');
    
    // Handle image attachments
    if (response.screenshots != null && response.screenshots!.isNotEmpty) {
      print('User attached ${response.screenshots!.length} images');
    }
  },
);
```

### Advanced Customization

```dart
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.bug,
  theme: CommunicationTheme.dark,
  title: "🐛 Report a Bug",
  subtitle: "Help us squash bugs and improve the app!",
  buttonText: "Submit Bug Report",
  placeholder: "Please describe the bug you encountered...",
  icon: Icons.bug_report,
  successMessage: "Thanks! We'll investigate this bug soon.",
  onSubmit: (CommunicationResponse response) {
    // Handle bug report
    _processBugReport(response);
  },
);
```

## ☁️ FeedbackNest Integration

**FeedbackNest is completely FREE** and provides a simple backend solution for collecting and managing feedback without any setup complexity.

### Why Use FeedbackNest?

- ✅ **100% Free** - No cost, no limits
- ✅ **Zero Backend Setup** - No server configuration needed  
- ✅ **Instant Dashboard** - View all feedback in one place
- ✅ **Analytics & Insights** - Track feedback trends
- ✅ **Team Collaboration** - Share feedback with your team
- ✅ **Easy Integration** - Just add your API key

### Step-by-Step FeedbackNest Setup

#### Step 1: Sign Up (Free)

1. Visit [FeedbackNest.app](https://feedbacknest.app)
2. Create your free account
3. No credit card required!

#### Step 2: Create a Project

1. Click "Create New Project" in your dashboard
2. Enter your app/project name
3. Get your unique API key

<!-- Space for FeedbackNest dashboard screenshots -->
### FeedbackNest Dashboard Screenshots

*Screenshots of the FeedbackNest dashboard will be added here to show:*
- *Project creation process*
- *API key location*
- *Feedback management interface*
- *Analytics and insights view*

#### Step 3: Add FeedbackNest to Your App

Add the dependency:

```yaml
dependencies:
  flutter_feedback_dialog: ^0.0.1
  feedbacknest_core: ^0.0.2
```

#### Step 4: Initialize FeedbackNest

```dart
import 'package:feedbacknest_core/feedbacknest.dart';

void main() {
  runApp(MyApp());
  
  // Initialize FeedbackNest with your free API key
  Feedbacknest.init(
    "your-api-key-from-dashboard",
    userIdentifier: "user@example.com", // Optional: identify users
  );
}
```

#### Step 5: Send Feedback to FeedbackNest

```dart
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.feedback,
  onSubmit: (CommunicationResponse response) async {
    try {
      // Automatically send to FeedbackNest (FREE!)
      await Feedbacknest.sendFeedback(
        message: response.message,
        email: response.email,
        screenshots: response.screenshots,
        type: 'feedback', // 'bug', 'feature', 'contact'
      );
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Feedback sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Failed to send feedback: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
);
```

#### Step 6: View Feedback in Dashboard

1. Log into your FeedbackNest dashboard
2. View all feedback, bug reports, and feature requests
3. Analyze trends with built-in analytics
4. Export data if needed

## 🎨 Customization

### Available Customization Options

| Parameter | Type | Description |
|-----------|------|-------------|
| `type` | `CommunicationViewType` | Dialog type: feedback, bug, featureRequest, contact |
| `theme` | `CommunicationTheme` | Theme: light or dark |
| `title` | `String?` | Custom dialog title |
| `subtitle` | `String?` | Custom dialog subtitle |
| `buttonText` | `String?` | Custom submit button text |
| `icon` | `IconData?` | Custom dialog icon |
| `placeholder` | `String?` | Custom textarea placeholder |
| `successMessage` | `String?` | Custom success message |

### Customization Examples

```dart
// Feature Request with Custom Styling
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.featureRequest,
  theme: CommunicationTheme.light,
  title: "💡 Got an Idea?",
  subtitle: "Share your feature ideas to help us improve!",
  buttonText: "Submit Idea",
  icon: Icons.lightbulb_outline,
  placeholder: "Describe your feature idea in detail...",
  successMessage: "🎉 Thanks! We love hearing new ideas from our users.",
  onSubmit: (response) => _handleFeatureRequest(response),
);

// Contact Form with Professional Look
FlutterFeedbackDialog.show(
  context,
  type: CommunicationViewType.contact,
  theme: CommunicationTheme.dark,
  title: "📞 Get in Touch",
  subtitle: "We'd love to hear from you!",
  buttonText: "Send Message",
  icon: Icons.contact_support,
  placeholder: "How can we help you today?",
  successMessage: "✅ Message sent! We'll get back to you soon.",
  onSubmit: (response) => _handleContactForm(response),
);
```

## 📱 Example App

Explore the complete example app in the [`example/`](example/) directory:

### What's Included:
- ✅ All dialog types (feedback, bug, feature, contact)
- ✅ Theme switching (light/dark)
- ✅ FeedbackNest integration
- ✅ Custom styling examples
- ✅ Error handling
- ✅ Success notifications

### Running the Example:

```bash
cd example
flutter pub get
flutter run
```

### Example App Features:
- **Interactive Demo**: Try all dialog types and themes
- **FeedbackNest Integration**: See real backend integration
- **Custom Styling**: Examples of dialog customization
- **Best Practices**: Proper error handling and user feedback

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute:
- 🐛 **Report bugs** - Found an issue? Let us know!
- 💡 **Suggest features** - Have ideas for improvements?
- 📖 **Improve docs** - Help make our documentation better
- 🔧 **Submit PRs** - Fix bugs or add new features
- ⭐ **Star the repo** - Show your support!

### Development Setup:
```bash
git clone <repository-url>
cd flutter_feedback_dialog
flutter pub get
cd example
flutter pub get
flutter run
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: Check our [API documentation](link-to-docs)
- **Issues**: Report bugs on [GitHub Issues](link-to-issues)
- **Discussions**: Join our [GitHub Discussions](link-to-discussions)
- **FeedbackNest Support**: Visit [FeedbackNest Help](https://feedbacknest.app/help)

---

<div align="center">

**Build better feedback experiences with FlutterFeedbackDialog! 🚀**

Made with ❤️ by the FeedbackNest team

</div>