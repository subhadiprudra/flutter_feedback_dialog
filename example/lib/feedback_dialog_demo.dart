import 'package:example/utils/sliver_grid_delegate.dart';
import 'package:flutter_feedback_dialog/models/communication_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feedback_dialog/models/feedback_models.dart';
import 'package:flutter_feedback_dialog/main/flutter_feedback_dialog.dart';
import 'package:feedbacknest_core/feedbacknest.dart';

/// Demo screen to showcase the FeedbackDialog with various configurations
class FeedbackDialogDemo extends StatefulWidget {
  const FeedbackDialogDemo({super.key});

  @override
  State<FeedbackDialogDemo> createState() => _FeedbackDialogDemoState();
}

class _FeedbackDialogDemoState extends State<FeedbackDialogDemo> {
  CommunicationViewType _selectedType = CommunicationViewType.feedback;
  CommunicationTheme _selectedTheme = CommunicationTheme.light;

  final List<Map<String, dynamic>> types = [
    {
      'value': CommunicationViewType.feedback,
      'label': 'Feedback',
      'icon': Icons.star,
    },
    {
      'value': CommunicationViewType.bug,
      'label': 'Bug Report',
      'icon': Icons.bug_report,
    },
    {
      'value': CommunicationViewType.featureRequest,
      'label': 'Feature Request',
      'icon': Icons.lightbulb,
    },
    {
      'value': CommunicationViewType.contact,
      'label': 'Contact',
      'icon': Icons.phone,
    },
  ];

  final List<Map<String, dynamic>> themes = [
    {'value': CommunicationTheme.light, 'label': 'Light Theme'},
    {'value': CommunicationTheme.dark, 'label': 'Dark Theme'},
  ];

  // Function to show the dialog
  void _showFeedbackDialog() {
    FLutterFeedbackDialog.show(
      context,
      type: _selectedType,
      theme: _selectedTheme,
      onSubmit: (CommunicationResponse response) {
        Feedbacknest.submitCommunication(
          message: response.message,
          type: _selectedType.name,
          email: response.email,
          files: response.screenshots,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = _selectedTheme == CommunicationTheme.dark;
    final Color mainBgColor = isDarkMode
        ? const Color(0xFF111827)
        : const Color(0xFFF3F4F6); // gray-900 / gray-100
    final Color cardBgColor = isDarkMode
        ? const Color(0xFF1F2937)
        : Colors.white; // gray-800 / white
    final Color textColor = isDarkMode
        ? Colors.white
        : const Color(0xFF1F2937); // text-white / text-gray-800
    final Color labelColor = isDarkMode
        ? const Color(0xFFE5E7EB)
        : const Color(0xFF374151); // gray-200 / gray-700
    final Color currentSelectionBg = isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFF3F4F6); // gray-700 / gray-100
    final Color currentSelectionTextColor = isDarkMode
        ? const Color(0xFFD1D5DB)
        : const Color(0xFF4B5563); // gray-300 / gray-600
    final Color codeBgColor = isDarkMode
        ? const Color(0xFF111827)
        : const Color(0xFFF3F4F6); // gray-900 / gray-100
    final Color codeTextColor = isDarkMode
        ? const Color(0xFF4ADE80)
        : const Color(0xFF059669); // green-400 / green-600

    return Scaffold(
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32.0, 70, 32.0, 32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Interactive Feedback Dialog',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 32),
                // Controls
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type Selection
                      Text(
                        'Dialog Type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3.5, // Adjust as needed
                            ),
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          final type = types[index];
                          final bool isSelected =
                              _selectedType == type['value'];
                          return ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _selectedType = type['value'];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? Theme.of(context).primaryColor
                                  : isDarkMode
                                  ? const Color(0xFF374151) // gray-700
                                  : const Color(0xFFF9FAFB), // gray-50
                              foregroundColor: isSelected
                                  ? Colors.white
                                  : isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF374151), // gray-700
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: Icon(type['icon'], size: 16),
                            label: Text(
                              type['label'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // Theme Selection
                      Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverColDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3.5,
                            ),
                        itemCount: themes.length,
                        itemBuilder: (context, index) {
                          final theme = themes[index];
                          final bool isSelected =
                              _selectedTheme == theme['value'];
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedTheme = theme['value'];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? Theme.of(context).primaryColor
                                  : isDarkMode
                                  ? const Color(0xFF374151) // gray-700
                                  : const Color(0xFFF9FAFB), // gray-50
                              foregroundColor: isSelected
                                  ? Colors.white
                                  : isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF374151), // gray-700
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              theme['label'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // Current Selection Display
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: currentSelectionBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Current Selection: ${types.firstWhere((t) => t['value'] == _selectedType)['label']} with ${_selectedTheme == CommunicationTheme.dark ? 'Dark' : 'Light'} Theme',
                          style: TextStyle(
                            fontSize: 14,
                            color: currentSelectionTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Button to open the dialog
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999), // rounded-full
                      gradient: LinearGradient(
                        colors: _selectedTheme == CommunicationTheme.light
                            ? _typeConfigs[_selectedType]!.lightGradientColors
                            : _typeConfigs[_selectedType]!.darkGradientColors,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent, // Make Material transparent
                      child: InkWell(
                        onTap: _showFeedbackDialog,
                        borderRadius: BorderRadius.circular(999),
                        highlightColor: Colors.white.withAlpha(10),
                        splashColor: Colors.white.withAlpha(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min, // Keep content centered
                            children: [
                              Icon(
                                _typeConfigs[_selectedType]!.icon,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _typeConfigs[_selectedType]!.buttonText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Usage Code
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usage Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: codeBgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SelectableText(
                          'showDialog(\n  context: context,\n  builder: (BuildContext context) {\n    return FeedbackDialog(\n      type: CommunicationViewType.${_selectedType.name},\n      theme: CommunicationTheme.${_selectedTheme.name},\n    );\n  },\n);',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                            color: codeTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Initialize _typeConfigs here as well, since it's used in _showFeedbackDialog
  late final Map<CommunicationViewType, TypeConfig> _typeConfigs = {
    CommunicationViewType.feedback: TypeConfig(
      title: 'Share Your Feedback',
      subtitle: 'Help us improve by sharing your thoughts',
      buttonText: 'Give Feedback',
      icon: Icons.star,
      placeholder: 'Tell us what you think about our product...',
      submitText: 'Send Feedback',
      successTitle: 'Thank You!',
      successMessage:
          'Your feedback has been submitted successfully. We appreciate your input!',
      lightGradientColors: [const Color(0xFF4F46E5), const Color(0xFFA855F7)],
      darkGradientColors: [const Color(0xFF6366F1), const Color(0xFFC084FC)],
    ),
    CommunicationViewType.bug: TypeConfig(
      title: 'Report a Bug',
      subtitle: 'Help us fix issues by reporting bugs',
      buttonText: 'Report Bug',
      icon: Icons.bug_report,
      placeholder:
          'Describe the bug you encountered, including steps to reproduce...',
      submitText: 'Submit Bug Report',
      successTitle: 'Bug Reported!',
      successMessage:
          'Your bug report has been submitted. Our team will investigate this issue.',
      lightGradientColors: [const Color(0xFFDC2626), const Color(0xFFEC4899)],
      darkGradientColors: [const Color(0xFFEF4444), const Color(0xFFF472B6)],
    ),
    CommunicationViewType.featureRequest: TypeConfig(
      title: 'Request a Feature',
      subtitle: 'Share your ideas for new features',
      buttonText: 'Request Feature',
      icon: Icons.lightbulb,
      placeholder:
          'Describe the feature you\'d like to see and how it would help you...',
      submitText: 'Submit Request',
      successTitle: 'Feature Requested!',
      successMessage:
          'Your feature request has been submitted. We\'ll consider it for future updates.',
      lightGradientColors: [const Color(0xFF16A34A), const Color(0xFF059669)],
      darkGradientColors: [const Color(0xFF22C55E), const Color(0xFF10B981)],
    ),
    CommunicationViewType.contact: TypeConfig(
      title: 'Contact Us',
      subtitle: 'Get in touch with our team',
      buttonText: 'Contact Us',
      icon: Icons.phone,
      placeholder: 'How can we help you today?',
      submitText: 'Send Message',
      successTitle: 'Message Sent!',
      successMessage:
          'Your message has been sent successfully. We\'ll get back to you soon.',
      lightGradientColors: [const Color(0xFF2563EB), const Color(0xFF06B6D4)],
      darkGradientColors: [const Color(0xFF3B82F6), const Color(0xFF22D3EE)],
    ),
  };
}
