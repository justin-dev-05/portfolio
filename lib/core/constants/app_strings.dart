class AppStrings {
  // App Info
  static const String appName = "PDI Dost";
  static const String appDescription = "Car Inspection App";
  static const String welcome = "Welcome 🎉";
  static const String welcomeBack = "Welcome Back";
  static const String loginSubTitle =
      "Log in to your account and manage your day.";
  static const String emailAddress = "Email Address";
  static const String emailHint = "Enter your email";
  static const String password = "Password";
  static const String passwordHint = "Enter your password";
  static const String forgotPassword = "Forgot Password?";
  static const String login = "Login";
  static const String joinAsCJ = "Join as CJ request";

  // Home Screen
  static const String home = "Home";
  static const String inquiries = "Inquiries";
  static const String history = "History";
  static const String profile = "Profile";
  static const String recentInspections = "Recent Inspections";
  static const String searchInspections = "Search inspections...";
  static const String pending = "Pending";
  static const String upcoming = "Upcoming";
  static const String total = "Total";

  // Notifications
  static const String notifications = "Notifications";

  // General
  static const String logout = "Logout";
  static const String cancel = "Cancel";
  static const String ok = "OK";
  static const String editProfile = "Edit Profile";
  static const String notificationSettings = "Notification Settings";
  static const String aboutApp = "About App";
  static const String confirmLogoutMsg = "Are you sure you want to log out?";

  // Auth/Register Screen
  static const String createAccount = "Create Account";
  static const String joinUsSubtitle =
      "Join us and start organizing your life like a pro.";
  static const String fullName = "Full Name";
  static const String fullNameHint = "Enter your full name";
  static const String emailUpdates =
      "We'll send important updates to this email";
  static const String passwordHintCreate = "Create a strong password";
  static const String passwordRequirement =
      "Minimum 6 characters, letters and numbers";
  static const String alreadyHaveAccount = "Already have an account?";

  // Forgot/Reset Password
  static const String createNewPassword = "Create New Password";
  static const String createNewPasswordSubtitle =
      "Your new password must be different from previous used passwords.";
  static const String passwordResetSuccessful = "Password Reset Successful!";
  static const String passwordResetMsg =
      "Your password has been successfully reset. You can now login with your new password.";
  static const String goToLogin = "Go to Login";
  static const String backToLogin = "Back to Login";
  static const String resetPassword = "Reset Password";
  static const String newPassword = "New Password";
  static const String newPasswordHint = "Enter your new password";
  static const String confirmNewPassword = "Confirm New Password";
  static const String confirmNewPasswordHint = "Confirm your new password";
  static const String min6Chars = "Minimum 6 characters";
  static const String mustMatchPassword = "Must match the new password";

  // Forgot Password Screen
  static const String forgotPasswordSubtitle =
      "Don't worry! It happens. Enter your email address and we'll send you a verification code to reset your password.";
  static const String emailHintRegistered = "Enter your registered email";
  static const String sendOTPHelper = "We'll send OTP to this email address";
  static const String sendOTP = "Send OTP";
  static const String rememberPassword = "Remember your password?";

  // OTP Verification Screen
  static const String otpSentSuccess = "OTP sent successfully";
  static const String verifyEmail = "Verify Your Email";
  static const String otpVerificationSubtitle =
      "We've sent a 4-digit verification code to";
  static const String didntReceiveCode = "Didn't receive the code?";
  static const String resendCodeIn = "Resend code in";
  static const String resendOTPString = "Resend OTP";
  static const String verifyOTP = "Verify OTP";

  // Edit Profile Screen
  static const String profileUpdatedSuccess =
      "Your profile has been updated successfully.";
  static const String personalInformation = "Personal Information";
  static const String updatePersonalDetails =
      "Update your personal details below";
  static const String nameHelperProfile =
      "This name will be displayed on your profile";
  static const String saveChanges = "Save Changes";

  // Dialogs & General
  static const String pleaseWait = "Please wait...";
  static const String exitApp = "Exit App";
  static const String exitAppMsg = "Are you sure you want to quit the app?";
  static const String confirm = "Confirm";
  static const String viewLicenses = "Licenses";
  static const String close = "Close";
  static const String error = "Error";
  static const String success = "Success";
  static const String okay = "Okay";
  static const String submit = "Submit";
  static const String operationCompletedSuccess =
      "Operation completed successfully";
  static const String appVersion = "Version 1.0.0";
  static const String aboutAppDescription =
      "PDIDost is a Flutter-based car inspection booking app built with BLoC, "
      "allowing users to manage inspections, track status, and view inspection history.";
  static const String comingSoon = "Coming soon...";

  // Onboarding
  static const String onboarding1Title = "Manage Your Tasks";
  static const String onboarding1Desc =
      "Easily organize your daily tasks and stay productive.";
  static const String onboarding2Title = "Set Priorities";
  static const String onboarding2Desc =
      "Highlight important tasks and never miss a deadline.";
  static const String onboarding3Title = "Track Progress";
  static const String onboarding3Desc =
      "View your statistics and see how much you have achieved.";
  static const String skip = "Skip";

  // Profile Widgets
  static const String camera = "Camera";
  static const String gallery = "Gallery";
  static const String darkMode = "Dark Mode";
  static const String preparing = "PREPARING...";

  // No Internet Widget
  static const String oops = "Ooops!";
  static const String noInternetTitle = "No Internet Connection found";
  static const String checkConnection = "Check your connection";
  static const String tryAgain = "Try Again";
}

class ValidationStrings {
  static const selectionRequired = 'Selection required';
  static const requiredField = 'Required field';
  static const nameRequired = 'Name is required';
  static const removeSpaceAtBeginning =
      'Please remove the space at the beginning.';
  static const invalidOtp = 'Invalid OTP';
  static const invalidEmail = 'Invalid email';
  static const invalidPincode = 'Invalid pincode';
  static const invalidNumber = 'Invalid number';
  static const amountExceedsTotal = 'Amount exceeds total';
  static const noSpacesAllowed = 'No spaces allowed';
  static const min8Chars = 'Min 8 characters';
  static const passwordTooLong = 'Password cannot exceed 16 characters';
  static const lettersAndNumbers = 'Must include letters & numbers';
  static const passwordsDoNotMatch = 'Passwords do not match';
  static const passwordRequired = 'Password is required';
}
