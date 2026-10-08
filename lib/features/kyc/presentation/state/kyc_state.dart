import 'package:equatable/equatable.dart';
import '../../data/mock_data/kyc_mock_data.dart';
import '../../data/models/bank_details_model.dart';
import '../../data/models/beneficial_owner_model.dart';
import '../../data/models/business_details_model.dart';
import '../../data/models/document_upload_model.dart';
import '../../data/models/pan_verification_model.dart';

class KycState extends Equatable {
  const KycState({
    this.termsAccepted = false,
    this.document,
    this.documentStatus = DocumentStatus.empty,
    this.flashEnabled = false,
    this.isFrontCamera = false,
    this.isCapturing = false,
    this.errorMessage,
    this.panVerification = KycMockData.defaultPanVerification,
    this.aadhaarError,
    this.preferredNameError,
    this.isVerifyingAadhaar = false,
    this.otpValue = '',
    this.otpError,
    this.isVerifyingOtp = false,
    this.otpCountdown = 29,
    this.businessDetails = KycMockData.defaultBusinessDetails,
    this.enteredGstin = '',
    this.gstinError,
    this.activitySearchQuery = '',
    this.isGstinVerified = false,
    this.beneficialOwners = KycMockData.defaultBeneficialOwners,
    this.nationalitySearchQuery = '',
    this.selectedOwnerIdForNationality,
    this.undertakingAccepted = false,
    this.alternateOwnerName,
    this.alternateOwnerPan = 'BA34V',
    this.alternateOwnerPanError,
    this.showAlternateOwnerSection = false,
    this.bankDetails = KycMockData.defaultBankDetails,
  });

  final bool termsAccepted;
  final DocumentUploadModel? document;
  final DocumentStatus documentStatus;
  final bool flashEnabled;
  final bool isFrontCamera;
  final bool isCapturing;
  final String? errorMessage;
  final PanVerificationModel panVerification;
  final String? aadhaarError;
  final String? preferredNameError;
  final bool isVerifyingAadhaar;
  final String otpValue;
  final String? otpError;
  final bool isVerifyingOtp;
  final int otpCountdown;
  final BusinessDetailsModel businessDetails;
  final String enteredGstin;
  final String? gstinError;
  final String activitySearchQuery;
  final bool isGstinVerified;
  final List<BeneficialOwnerModel> beneficialOwners;
  final String nationalitySearchQuery;
  final String? selectedOwnerIdForNationality;
  final bool undertakingAccepted;
  final String? alternateOwnerName;
  final String alternateOwnerPan;
  final String? alternateOwnerPanError;
  final bool showAlternateOwnerSection;
  final BankDetailsModel bankDetails;

  bool get hasDocument =>
      document != null && documentStatus != DocumentStatus.empty;
  bool get isBwError => documentStatus == DocumentStatus.errorBw;
  bool get canResendOtp => otpCountdown == 0;
  bool get isOtpComplete => otpValue.length == 6;

  List<String> get filteredActivities {
    if (activitySearchQuery.isEmpty) {
      return KycMockData.businessActivities;
    }
    return KycMockData.businessActivities
        .where((a) =>
            a.toLowerCase().contains(activitySearchQuery.toLowerCase()))
        .toList();
  }

  List<String> get filteredNationalities {
    if (nationalitySearchQuery.isEmpty) {
      return KycMockData.nationalities;
    }
    return KycMockData.nationalities
        .where((n) =>
            n.toLowerCase().contains(nationalitySearchQuery.toLowerCase()))
        .toList();
  }

  KycState copyWith({
    bool? termsAccepted,
    DocumentUploadModel? document,
    bool clearDocument = false,
    DocumentStatus? documentStatus,
    bool? flashEnabled,
    bool? isFrontCamera,
    bool? isCapturing,
    String? errorMessage,
    bool clearError = false,
    PanVerificationModel? panVerification,
    String? aadhaarError,
    bool clearAadhaarError = false,
    String? preferredNameError,
    bool clearPreferredNameError = false,
    bool? isVerifyingAadhaar,
    String? otpValue,
    String? otpError,
    bool clearOtpError = false,
    bool? isVerifyingOtp,
    int? otpCountdown,
    BusinessDetailsModel? businessDetails,
    String? enteredGstin,
    String? gstinError,
    bool clearGstinError = false,
    String? activitySearchQuery,
    bool? isGstinVerified,
    List<BeneficialOwnerModel>? beneficialOwners,
    String? nationalitySearchQuery,
    String? selectedOwnerIdForNationality,
    bool? undertakingAccepted,
    String? alternateOwnerName,
    String? alternateOwnerPan,
    String? alternateOwnerPanError,
    bool clearAlternateOwnerPanError = false,
    bool? showAlternateOwnerSection,
    BankDetailsModel? bankDetails,
  }) {
    return KycState(
      termsAccepted: termsAccepted ?? this.termsAccepted,
      document: clearDocument ? null : (document ?? this.document),
      documentStatus: documentStatus ?? this.documentStatus,
      flashEnabled: flashEnabled ?? this.flashEnabled,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      isCapturing: isCapturing ?? this.isCapturing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      panVerification: panVerification ?? this.panVerification,
      aadhaarError:
          clearAadhaarError ? null : (aadhaarError ?? this.aadhaarError),
      preferredNameError: clearPreferredNameError
          ? null
          : (preferredNameError ?? this.preferredNameError),
      isVerifyingAadhaar: isVerifyingAadhaar ?? this.isVerifyingAadhaar,
      otpValue: otpValue ?? this.otpValue,
      otpError: clearOtpError ? null : (otpError ?? this.otpError),
      isVerifyingOtp: isVerifyingOtp ?? this.isVerifyingOtp,
      otpCountdown: otpCountdown ?? this.otpCountdown,
      businessDetails: businessDetails ?? this.businessDetails,
      enteredGstin: enteredGstin ?? this.enteredGstin,
      gstinError: clearGstinError ? null : (gstinError ?? this.gstinError),
      activitySearchQuery: activitySearchQuery ?? this.activitySearchQuery,
      isGstinVerified: isGstinVerified ?? this.isGstinVerified,
      beneficialOwners: beneficialOwners ?? this.beneficialOwners,
      nationalitySearchQuery:
          nationalitySearchQuery ?? this.nationalitySearchQuery,
      selectedOwnerIdForNationality: selectedOwnerIdForNationality ??
          this.selectedOwnerIdForNationality,
      undertakingAccepted: undertakingAccepted ?? this.undertakingAccepted,
      alternateOwnerName: alternateOwnerName ?? this.alternateOwnerName,
      alternateOwnerPan: alternateOwnerPan ?? this.alternateOwnerPan,
      alternateOwnerPanError: clearAlternateOwnerPanError
          ? null
          : (alternateOwnerPanError ?? this.alternateOwnerPanError),
      showAlternateOwnerSection:
          showAlternateOwnerSection ?? this.showAlternateOwnerSection,
      bankDetails: bankDetails ?? this.bankDetails,
    );
  }

  @override
  List<Object?> get props => [
        termsAccepted,
        document,
        documentStatus,
        flashEnabled,
        isFrontCamera,
        isCapturing,
        errorMessage,
        panVerification,
        aadhaarError,
        preferredNameError,
        isVerifyingAadhaar,
        otpValue,
        otpError,
        isVerifyingOtp,
        otpCountdown,
        businessDetails,
        enteredGstin,
        gstinError,
        activitySearchQuery,
        isGstinVerified,
        beneficialOwners,
        nationalitySearchQuery,
        selectedOwnerIdForNationality,
        undertakingAccepted,
        alternateOwnerName,
        alternateOwnerPan,
        alternateOwnerPanError,
        showAlternateOwnerSection,
        bankDetails,
      ];
}
