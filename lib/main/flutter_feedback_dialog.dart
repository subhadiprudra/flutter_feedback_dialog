import 'package:flutter_feedback_dialog/models/communication_type.dart';
import 'package:flutter_feedback_dialog/models/feedback_models.dart';
import 'package:flutter_feedback_dialog/widgets/feedback_dialog.dart';
import 'package:flutter/material.dart';

class FlutterFeedbackDialog {
  static show(
    BuildContext context, {
    type = CommunicationViewType.feedback,
    theme = CommunicationTheme.light,
    title,
    subtitle,
    buttonText,
    icon,
    placeholder,
    submitText,
    successTitle,
    successMessage,
    lightGradientColors,
    darkGradientColors,
    required Function(CommunicationResponse) onSubmit,
  }) async {
    CommunicationResponse? response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackDialog(
          type: type,
          theme: theme,
          title: title,
          subtitle: subtitle,
          buttonText: buttonText,
          icon: icon,
          placeholder: placeholder,
          submitText: submitText,
          successTitle: successTitle,
          successMessage: successMessage,
          lightGradientColors: lightGradientColors,
          darkGradientColors: darkGradientColors,
        );
      },
    );
    if (response != null) {
      onSubmit.call(response);
    }
  }
}
