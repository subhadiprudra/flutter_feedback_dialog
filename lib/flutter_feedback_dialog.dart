export 'package:flutter_feedback_dialog/main/flutter_feedback_dialog.dart';
export 'package:flutter_feedback_dialog/models/feedback_models.dart';


if(userSessions>x){
  rating = showRating()
  if(rating > 3) {
    rated = askUserToRateOnAppStore/Playstore();
    if(rated){
      showThankYouMessage();
      sendFeedbackToFeedbackNest()
    } else {
      x = x+ frequency
    }
  } else {
    showFeedbackForm();
    sendFeedbackToFeedbackNest()
  }
}