class Validators {
  Validators._();

  static final RegExp _panRegex = RegExp(r'^[A-Z0-9]{10}$');
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _phoneRegex = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

  static String? validateRequired(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePan(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PAN number is required';
    }
    final formatted = value.replaceAll(' ', '').trim().toUpperCase();
    if (formatted.length != 10) {
      return 'PAN must be exactly 10 characters';
    }
    if (!_panRegex.hasMatch(formatted)) {
      return 'Enter a valid 10-character PAN';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (trimmed.length > 60) {
      return 'Name cannot exceed 60 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s\.\'-]+$").hasMatch(trimmed)) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? validateIfsc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'IFSC code is required';
    }
    if (!_ifscRegex.hasMatch(value.trim().toUpperCase())) {
      return 'Enter a valid 11-character IFSC code';
    }
    return null;
  }

  static String? validateAadhaar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Aadhaar number is required';
    }
    final digits = value.replaceAll(' ', '').trim();
    if (digits.length != 12) {
      return 'Aadhaar must be exactly 12 digits';
    }
    if (!RegExp(r'^[2-9]\d{11}$').hasMatch(digits)) {
      return 'Enter a valid 12-digit Aadhaar number';
    }
    return null;
  }

  static String? validatePreferredName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Preferred name is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (trimmed.length > 30) {
      return 'Name cannot exceed 30 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s\.\'-]+$").hasMatch(trimmed)) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP is required';
    }
    final trimmed = value.trim();
    if (trimmed.length != 6) {
      return 'Enter complete 6-digit OTP';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(trimmed)) {
      return 'OTP must be 6 numeric digits';
    }
    return null;
  }

  static String? validateGstin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'GSTIN is required';
    }
    final formatted = value.replaceAll(' ', '').trim().toUpperCase();
    if (formatted.length != 15) {
      return 'GSTIN must be exactly 15 characters';
    }
    if (!RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(formatted)) {
      return 'Enter a valid 15-character GSTIN';
    }
    return null;
  }

  static String? validateCompanyNickname(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter Company nickname';
    }
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Nickname must be at least 2 characters';
    }
    return null;
  }

  static String? validateWebsiteUrl(String? value, [bool isNoWebsite = false]) {
    if (isNoWebsite) return null;
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final trimmed = value.trim();
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/.*)?$',
      caseSensitive: false,
    );
    if (!urlRegex.hasMatch(trimmed)) {
      return 'Enter a valid website URL';
    }
    return null;
  }

  static String? validateBankAccount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bank account number is required';
    }
    final digits = value.replaceAll(' ', '').trim();
    if (digits.length < 9 || digits.length > 18) {
      return 'Account number must be between 9 and 18 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(digits)) {
      return 'Account number must contain only numbers';
    }
    return null;
  }

  static String? validateBankBranch(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bank branch is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Branch name must be at least 3 characters';
    }
    if (trimmed.length > 50) {
      return 'Branch name cannot exceed 50 characters';
    }
    if (RegExp(r'[0-9]').hasMatch(trimmed)) {
      return 'Branch name cannot contain numbers';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmed)) {
      return 'Enter a valid branch name';
    }
    return null;
  }

  static bool isFileSizeValid(int sizeInBytes, [int maxMb = 10]) {
    return sizeInBytes <= maxMb * 1024 * 1024;
  }

  static bool isFileTypeSupported(String extension) {
    final clean = extension.toLowerCase().replaceAll('.', '');
    return ['jpg', 'jpeg', 'png', 'pdf'].contains(clean);
  }
}
