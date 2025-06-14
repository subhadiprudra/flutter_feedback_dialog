import 'dart:io';

import 'package:flutter_feedback_dialog/models/communication_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/feedback_models.dart';
import '../widgets/dotted_border.dart';

/// FeedbackDialog Widget - A reusable dialog for collecting user feedback
class FeedbackDialog extends StatefulWidget {
  final CommunicationViewType type;
  final CommunicationTheme theme;

  /// Custom title for the dialog
  final String? title;

  /// Custom subtitle for the dialog
  final String? subtitle;

  /// Custom button text for the dialog
  final String? buttonText;

  /// Custom icon for the dialog
  final IconData? icon;

  /// Custom placeholder text for the input field
  final String? placeholder;

  /// Custom submit button text
  final String? submitText;

  /// Custom success message title
  final String? successTitle;

  /// Custom success message
  final String? successMessage;

  /// Custom gradient colors for light theme
  final List<Color>? lightGradientColors;

  /// Custom gradient colors for dark theme
  final List<Color>? darkGradientColors;

  const FeedbackDialog({
    super.key,
    this.type = CommunicationViewType.feedback,
    this.theme = CommunicationTheme.light,
    this.title,
    this.subtitle,
    this.buttonText,
    this.icon,
    this.placeholder,
    this.submitText,
    this.successTitle,
    this.successMessage,
    this.lightGradientColors,
    this.darkGradientColors,
  });

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  XFile? _screenshot;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  late Map<CommunicationViewType, TypeConfig> _typeConfigs;
  late Map<CommunicationTheme, ThemeStyles> _themeStyles;

  @override
  void initState() {
    super.initState();
    _initializeConfigs();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _initializeConfigs() {
    _typeConfigs = {
      CommunicationViewType.feedback: TypeConfig(
        title: widget.title ?? 'Share Your Feedback',
        subtitle: widget.subtitle ?? 'Help us improve by sharing your thoughts',
        buttonText: widget.buttonText ?? 'Give Feedback',
        icon: widget.icon ?? Icons.star,
        placeholder:
            widget.placeholder ?? 'Tell us what you think about our product...',
        submitText: widget.submitText ?? 'Send Feedback',
        successTitle: widget.successTitle ?? 'Thank You!',
        successMessage: widget.successMessage ??
            'Your feedback has been submitted successfully. We appreciate your input!',
        lightGradientColors: widget.lightGradientColors ??
            [
              const Color(0xFF4F46E5),
              const Color(0xFFA855F7),
            ], // from-indigo-600 to-purple-600
        darkGradientColors: widget.darkGradientColors ??
            [
              const Color(0xFF6366F1),
              const Color(0xFFC084FC),
            ], // from-indigo-500 to-purple-500
      ),
      CommunicationViewType.bug: TypeConfig(
        title: widget.title ?? 'Report a Bug',
        subtitle: widget.subtitle ?? 'Help us fix issues by reporting bugs',
        buttonText: widget.buttonText ?? 'Report Bug',
        icon: widget.icon ?? Icons.bug_report,
        placeholder: widget.placeholder ??
            'Describe the bug you encountered, including steps to reproduce...',
        submitText: widget.submitText ?? 'Submit Bug Report',
        successTitle: widget.successTitle ?? 'Bug Reported!',
        successMessage: widget.successMessage ??
            'Your bug report has been submitted. Our team will investigate this issue.',
        lightGradientColors: widget.lightGradientColors ??
            [
              const Color(0xFFDC2626),
              const Color(0xFFEC4899),
            ], // from-red-600 to-pink-600
        darkGradientColors: widget.darkGradientColors ??
            [
              const Color(0xFFEF4444),
              const Color(0xFFF472B6),
            ], // from-red-500 to-pink-500
      ),
      CommunicationViewType.featureRequest: TypeConfig(
        title: widget.title ?? 'Request a Feature',
        subtitle: widget.subtitle ?? 'Share your ideas for new features',
        buttonText: widget.buttonText ?? 'Request Feature',
        icon: widget.icon ?? Icons.lightbulb,
        placeholder: widget.placeholder ??
            'Describe the feature you\'d like to see and how it would help you...',
        submitText: widget.submitText ?? 'Submit Request',
        successTitle: widget.successTitle ?? 'Feature Requested!',
        successMessage: widget.successMessage ??
            'Your feature request has been submitted. We\'ll consider it for future updates.',
        lightGradientColors: widget.lightGradientColors ??
            [
              const Color(0xFF16A34A),
              const Color(0xFF059669),
            ], // from-green-600 to-emerald-600
        darkGradientColors: widget.darkGradientColors ??
            [
              const Color(0xFF22C55E),
              const Color(0xFF10B981),
            ], // from-green-500 to-emerald-500
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
        lightGradientColors: [
          const Color(0xFF2563EB),
          const Color(0xFF06B6D4),
        ], // from-blue-600 to-cyan-600
        darkGradientColors: [
          const Color(0xFF3B82F6),
          const Color(0xFF22D3EE),
        ], // from-blue-500 to-cyan-500
      ),
    };

    _themeStyles = {
      CommunicationTheme.light: ThemeStyles(
        backgroundStart: const Color(0xFFEEF2FF),
        backgroundMiddle: Colors.white,
        backgroundEnd: const Color(0xFFE0F7FA),
        dialogBg: Colors.white,
        textPrimary: const Color(0xFF1F2937),
        textSecondary: const Color(0xFF4B5563),
        textMuted: const Color(0xFF9CA3AF),
        inputBg: const Color(0xFFF9FAFB),
        inputBorder: const Color(0xFFE5E7EB),
        inputFocusRing: const Color(0xFF6366F1),
        uploadBorder: const Color(0xFFE5E7EB),
        uploadHoverBorder: const Color(0xFFBFDBFE), // indigo-300
        closeHoverBg: const Color(0xFFF3F4F6),
        overlayColor: Colors.black.withAlpha(50),
      ),
      CommunicationTheme.dark: ThemeStyles(
        backgroundStart: const Color(0xFF111827),
        backgroundMiddle: const Color(0xFF1F2937),
        backgroundEnd: const Color(0xFF111827),
        dialogBg: const Color(0xFF1F2937),
        textPrimary: Colors.white,
        textSecondary: const Color(0xFFD1D5DB),
        textMuted: const Color(0xFF6B7280),
        inputBg: const Color(0xFF374151),
        inputBorder: const Color(0xFF4B5563),
        inputFocusRing: const Color(0xFF818CF8), // indigo-400
        uploadBorder: const Color(0xFF4B5563),
        uploadHoverBorder: const Color(0xFF818CF8), // indigo-400
        closeHoverBg: const Color(0xFF374151),
        overlayColor: Colors.black.withAlpha(70),
      ),
    };
  }

  void _handleFileChange() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _screenshot = image;
    });
  }

  void _handleSubmit() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
    });

    // Close dialog after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        List<File> files = [];
        if (_screenshot != null) {
          files.add(File(_screenshot!.path));
        }
        Navigator.of(context).pop(
          CommunicationResponse(
            message: _messageController.text,
            email: _emailController.text,
            screenshots: files,
          ),
        ); // Close the dialog
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TypeConfig config = _typeConfigs[widget.type]!;
    final ThemeStyles styles = _themeStyles[widget.theme]!;

    return Dialog(
      backgroundColor: Colors.transparent, // Make dialog background transparent
      // Use media query to adjust insetPadding for keyboard
      insetPadding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            16.0, // Adjust for keyboard
        top: 16.0,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: styles.dialogBg,
          borderRadius: BorderRadius.circular(24.0), // rounded-3xl
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 16,
                top: 24,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    // Use Flexible to prevent overflow if title is too long
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: widget.theme == CommunicationTheme.light
                              ? config.lightGradientColors
                              : config.darkGradientColors,
                        ).createShader(bounds);
                      },
                      child: Text(
                        config.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, // Color will be overridden by ShaderMask
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20, color: styles.textMuted),
                    onPressed: () =>
                        Navigator.of(context).pop(), // Close dialog
                    splashRadius: 20,
                    highlightColor: styles.closeHoverBg,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 24,
                top: 8,
              ),
              child: Text(
                config.subtitle,
                style: TextStyle(color: styles.textSecondary, fontSize: 14),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _isSubmitted
                  ? _buildSuccessState(config, styles)
                  : _buildFormContent(config, styles),
            ),
            // Adding some bottom padding for the scrollable content, especially before the buttons
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(TypeConfig config, ThemeStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email Input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: widget.theme == CommunicationTheme.light
                            ? config.lightGradientColors
                            : config.darkGradientColors,
                      ).createShader(bounds);
                    },
                    child: Icon(Icons.mail, size: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Email ${widget.type == CommunicationViewType.contact ? '*' : '(Optional)'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: styles.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: styles.textPrimary),
              decoration: InputDecoration(
                hintText: 'your.email@example.com',
                hintStyle: TextStyle(color: styles.textMuted),
                filled: true,
                fillColor: styles.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: styles.inputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: styles.inputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: styles.inputFocusRing,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) => setState(() {}), // Trigger rebuild
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Message Input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: widget.theme == CommunicationTheme.light
                            ? config.lightGradientColors
                            : config.darkGradientColors,
                      ).createShader(bounds);
                    },
                    child: Icon(Icons.message, size: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your ${widget.type == CommunicationViewType.bug ? 'Bug Report' : widget.type == CommunicationViewType.featureRequest ? 'Feature Request' : widget.type == CommunicationViewType.contact ? 'Message' : 'Feedback'} *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: styles.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              style: TextStyle(color: styles.textPrimary),
              decoration: InputDecoration(
                hintText: config.placeholder,
                hintStyle: TextStyle(color: styles.textMuted),
                filled: true,
                fillColor: styles.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: styles.inputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: styles.inputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: styles.inputFocusRing,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) => setState(() {}), // Trigger rebuild
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Screenshot Upload
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: widget.theme == CommunicationTheme.light
                            ? config.lightGradientColors
                            : config.darkGradientColors,
                      ).createShader(bounds);
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Screenshot (Optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: styles.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _handleFileChange,
              borderRadius: BorderRadius.circular(12),
              child: DottedBorder(
                borderType: BorderType.rReact,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(16),
                color: styles.uploadBorder,
                strokeWidth: 2,
                dashPattern: const [6, 3],
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: _screenshot != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _screenshot!.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 24,
                              color: styles.textMuted,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Click to upload screenshot',
                              style: TextStyle(
                                fontSize: 14,
                                color: styles.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'PNG, JPG up to 10MB',
                              style: TextStyle(
                                fontSize: 12,
                                color: styles.textMuted,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Submit Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: (_isSubmitting ||
                    _messageController.text.trim().isEmpty ||
                    (widget.type == CommunicationViewType.contact &&
                        _emailController.text.trim().isEmpty))
                ? null // No gradient when disabled
                : LinearGradient(
                    colors: widget.theme == CommunicationTheme.light
                        ? config.lightGradientColors
                        : config.darkGradientColors,
                  ),
            color: (_isSubmitting ||
                    _messageController.text.trim().isEmpty ||
                    (widget.type == CommunicationViewType.contact &&
                        _emailController.text.trim().isEmpty))
                ? const Color(0xFFD1D5DB) // Disabled color (gray-300)
                : null, // Let gradient handle color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors
                .transparent, // Make Material transparent for gradient to show
            child: InkWell(
              onTap: (_isSubmitting ||
                      _messageController.text.trim().isEmpty ||
                      (widget.type == CommunicationViewType.contact &&
                          _emailController.text.trim().isEmpty))
                  ? null
                  : _handleSubmit,
              borderRadius: BorderRadius.circular(12),
              highlightColor: Colors.white.withAlpha(10), // Hover effect
              splashColor: Colors.white.withAlpha(20), // Splash effect
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.send, size: 18, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      config.submitText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(TypeConfig config, ThemeStyles styles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFD1FAE5), // green-100
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 32,
            color: Color(0xFF10B981),
          ), // green-500
        ),
        const SizedBox(height: 16),
        Text(
          config.successTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: styles.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          config.successMessage,
          textAlign: TextAlign.center,
          style: TextStyle(color: styles.textSecondary),
        ),
      ],
    );
  }
}
