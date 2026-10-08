import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../data/mock_data/kyc_mock_data.dart';
import '../../data/models/beneficial_owner_model.dart';
import '../../data/models/document_upload_model.dart';
import 'kyc_state.dart';

class KycCubit extends Cubit<KycState> {
  KycCubit() : super(const KycState());

  Timer? _otpTimer;

  void toggleTerms(bool value) {
    emit(state.copyWith(termsAccepted: value));
  }

  void selectColorDocument() {
    emit(state.copyWith(
      document: KycMockData.colorPanDocument,
      documentStatus: DocumentStatus.selected,
      clearError: true,
    ));
  }

  void selectBwDocument() {
    emit(state.copyWith(
      document: KycMockData.bwPanDocument,
      documentStatus: DocumentStatus.errorBw,
      errorMessage:
          'Kindly make sure the document uploaded is a coloured soft copy of the director’s PAN card.',
    ));
  }

  void removeDocument() {
    emit(state.copyWith(
      clearDocument: true,
      documentStatus: DocumentStatus.empty,
      clearError: true,
    ));
  }

  void toggleFlash() {
    emit(state.copyWith(flashEnabled: !state.flashEnabled));
  }

  void toggleCameraFacing() {
    emit(state.copyWith(isFrontCamera: !state.isFrontCamera));
  }

  Future<void> capturePhoto() async {
    emit(state.copyWith(isCapturing: true));
    await Future.delayed(const Duration(milliseconds: 250));
    emit(state.copyWith(
      isCapturing: false,
      document: KycMockData.colorPanDocument,
      documentStatus: DocumentStatus.selected,
      clearError: true,
    ));
  }

  void uploadDocument() {
    if (state.document == null) return;

    if (state.document!.isBlackAndWhite) {
      emit(state.copyWith(
        documentStatus: DocumentStatus.errorBw,
        errorMessage:
            'Kindly make sure the document uploaded is a coloured soft copy of the director’s PAN card.',
      ));
      return;
    }

    emit(state.copyWith(documentStatus: DocumentStatus.verified));
  }

  void updatePan(String value) {
    emit(state.copyWith(
      panVerification: state.panVerification.copyWith(panNumber: value),
    ));
  }

  void updateFullName(String value) {
    emit(state.copyWith(
      panVerification: state.panVerification.copyWith(fullName: value),
    ));
  }

  void updatePreferredName(String value) {
    emit(state.copyWith(
      panVerification: state.panVerification.copyWith(preferredName: value),
      clearPreferredNameError: true,
    ));
  }

  void updateAadhaar(String value) {
    emit(state.copyWith(
      panVerification: state.panVerification.copyWith(aadhaarNumber: value),
      clearAadhaarError: true,
    ));
  }

  void updateOtp(String value) {
    emit(state.copyWith(
      otpValue: value,
      clearOtpError: true,
    ));
  }

  bool validatePanVerificationForm() {
    final nameErr = Validators.validatePreferredName(state.panVerification.preferredName);
    final aadhaarErr = Validators.validateAadhaar(state.panVerification.aadhaarNumber);

    emit(state.copyWith(
      preferredNameError: nameErr,
      aadhaarError: aadhaarErr,
      clearPreferredNameError: nameErr == null,
      clearAadhaarError: aadhaarErr == null,
    ));

    return nameErr == null && aadhaarErr == null;
  }

  void startOtpTimer() {
    _otpTimer?.cancel();
    emit(state.copyWith(otpCountdown: 29, otpValue: '', clearOtpError: true));
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.otpCountdown > 1) {
        emit(state.copyWith(otpCountdown: state.otpCountdown - 1));
      } else {
        emit(state.copyWith(otpCountdown: 0));
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startOtpTimer();
  }

  bool validateAndConfirmOtp() {
    final err = Validators.validateOtp(state.otpValue);
    if (err != null) {
      emit(state.copyWith(otpError: err));
      return false;
    }
    emit(state.copyWith(clearOtpError: true));
    return true;
  }

  void updateEnteredGstin(String value) {
    emit(state.copyWith(
      enteredGstin: value,
      clearGstinError: true,
    ));
  }

  bool verifyEnteredGstin() {
    final err = Validators.validateGstin(state.enteredGstin);
    if (err != null) {
      emit(state.copyWith(gstinError: AppStrings.noGstinFound));
      return false;
    }
    emit(state.copyWith(
      clearGstinError: true,
      isGstinVerified: true,
      businessDetails: state.businessDetails.copyWith(
        gstin: state.enteredGstin.toUpperCase(),
      ),
    ));
    return true;
  }

  void updateBusinessPan(String value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(pan: value),
    ));
  }

  void updateCompanyName(String value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(companyName: value),
    ));
  }

  void updateCin(String value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(cin: value),
    ));
  }

  void updateBillingAddress(String value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(billingAddress: value),
    ));
  }

  void updateCompanyNickname(String value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(companyNickname: value),
    ));
  }

  void selectPrimaryBusinessActivity(String activity) {
    emit(state.copyWith(
      businessDetails:
          state.businessDetails.copyWith(primaryBusinessActivity: activity),
    ));
  }

  void selectGstin(String gstin) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(gstin: gstin),
    ));
  }

  void updateWebsiteUrl(String url) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(websiteUrl: url),
    ));
  }

  void toggleNoWebsite(bool value) {
    emit(state.copyWith(
      businessDetails: state.businessDetails.copyWith(
        noWebsite: value,
        websiteUrl: value ? '' : state.businessDetails.websiteUrl,
      ),
    ));
  }

  void setActivitySearchQuery(String query) {
    emit(state.copyWith(activitySearchQuery: query));
  }

  void updateOwnerName(String id, String name) {
    final updated = state.beneficialOwners.map((owner) {
      if (owner.id == id) {
        return owner.copyWith(name: name);
      }
      return owner;
    }).toList();
    emit(state.copyWith(beneficialOwners: updated));
  }

  void openNationalitySelector(String id) {
    emit(state.copyWith(
      selectedOwnerIdForNationality: id,
      nationalitySearchQuery: '',
    ));
  }

  void setNationalitySearchQuery(String query) {
    emit(state.copyWith(nationalitySearchQuery: query));
  }

  void selectOwnerNationality(String nationality) {
    final targetId = state.selectedOwnerIdForNationality;
    if (targetId == null) return;
    final updated = state.beneficialOwners.map((owner) {
      if (owner.id == targetId) {
        return owner.copyWith(nationality: nationality);
      }
      return owner;
    }).toList();
    emit(state.copyWith(
      beneficialOwners: updated,
      selectedOwnerIdForNationality: null,
    ));
  }

  void addNewBeneficialOwner() {
    final newOwner = BeneficialOwnerModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      nationality: null,
      isRemovable: true,
    );
    emit(state.copyWith(
      beneficialOwners: [...state.beneficialOwners, newOwner],
    ));
  }

  void removeBeneficialOwner(String id) {
    final target = state.beneficialOwners.firstWhere(
      (o) => o.id == id,
      orElse: () => const BeneficialOwnerModel(id: '', name: ''),
    );
    if (!target.isRemovable) return;
    final updated = state.beneficialOwners.where((o) => o.id != id).toList();
    final remainingNames = updated.map((o) => o.name).toSet();
    final newAlternateName = remainingNames.contains(state.alternateOwnerName)
        ? state.alternateOwnerName
        : null;

    emit(state.copyWith(
      beneficialOwners: updated,
      alternateOwnerName: newAlternateName,
    ));
  }

  void toggleUndertaking(bool value) {
    emit(state.copyWith(undertakingAccepted: value));
  }

  void toggleAlternateOwnerSection() {
    emit(state.copyWith(
      showAlternateOwnerSection: !state.showAlternateOwnerSection,
    ));
  }

  void selectAlternateOwner(String name) {
    emit(state.copyWith(alternateOwnerName: name));
  }

  void updateAlternateOwnerPan(String pan) {
    emit(state.copyWith(
      alternateOwnerPan: pan,
      clearAlternateOwnerPanError: true,
    ));
  }

  void updateBankAccountNumber(String number) {
    emit(state.copyWith(
      bankDetails: state.bankDetails.copyWith(accountNumber: number),
    ));
  }

  void updateIfscCode(String ifsc) {
    emit(state.copyWith(
      bankDetails: state.bankDetails.copyWith(ifscCode: ifsc),
    ));
  }

  void updateAccountHolderName(String name) {
    emit(state.copyWith(
      bankDetails: state.bankDetails.copyWith(accountHolderName: name),
    ));
  }

  void updateBankBranch(String branch) {
    emit(state.copyWith(
      bankDetails: state.bankDetails.copyWith(bankBranch: branch),
    ));
  }

  void verifyBankDetails() {
    emit(state.copyWith(
      bankDetails: state.bankDetails.copyWith(isVerified: true),
    ));
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }
}
