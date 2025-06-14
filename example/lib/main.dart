import 'package:feedbacknest_core/feedbacknest.dart';
import 'package:flutter/material.dart';
import 'feedback_dialog_demo.dart';

/// The main entry point for the Flutter application.
void main() {
  runApp(const MyApp());
  Feedbacknest.init(
    "Q1UJxjPOWwj4K9hlxK69CFXT38phJt8a",
    userIdentifier: "abc@gmail.com",
  );
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Dialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FeedbackDialogDemo(),
      debugShowCheckedModeBanner: false, // Optional: remove debug banner
    );
  }
}
