import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../models/bank_details_model.dart';
import '../models/beneficial_owner_model.dart';
import '../models/business_details_model.dart';
import '../models/document_upload_model.dart';
import '../models/pan_verification_model.dart';

class KycMockData {
  KycMockData._();

  static const DocumentUploadModel colorPanDocument = DocumentUploadModel(
    fileName: 'director_pan_card.jpg',
    fileSizeBytes: 1250000,
    assetPath: AppAssets.panCard,
    isBlackAndWhite: false,
    status: DocumentStatus.selected,
    directorName: 'RAJESH KUMAR SHARMA',
    panNumber: 'ABCDE1234F',
  );

  static const DocumentUploadModel bwPanDocument = DocumentUploadModel(
    fileName: 'director_pan_scanned_bw.jpg',
    fileSizeBytes: 950000,
    assetPath: AppAssets.panCardBw,
    isBlackAndWhite: true,
    status: DocumentStatus.selected,
    directorName: 'RAJESH KUMAR SHARMA',
    panNumber: 'ABCDE1234F',
  );

  static const PanVerificationModel defaultPanVerification =
      PanVerificationModel(
    panNumber: 'BA34V F7K90',
    fullName: 'HEMANT KUMAR GHIYA',
    preferredName: 'Hemant Kumar',
    aadhaarNumber: '1234 5678 9012',
  );

  static const BusinessDetailsModel defaultBusinessDetails =
      BusinessDetailsModel(
    pan: AppStrings.mockPanNumber,
    companyName: AppStrings.mockCompanyName,
    cin: AppStrings.mockCin,
    companyNickname: '',
    billingAddress: AppStrings.mockBillingAddress,
  );

  static const List<String> businessActivities = [
    'Accounting',
    'Administrative Services (Payroll, HR, virtual assistants, back office, etc)',
    'Architecture & Civil Planning',
    'Education services',
    'Financial services',
    'Leisure, Travel & Tourism',
    'Manufacturing/ Goods exports',
    'Public Relations and Communications',
    'Research & analytics services',
    'Staffing & Recruiting',
    'Other',
  ];

  static const List<String> gstinList = [
    '21AAHCT7448PIZR',
    '71CAHCT7448PIZR',
    '52ACFCT7448PIZR',
    '90AAHAT7448PIZR',
  ];

  static const List<BeneficialOwnerModel> defaultBeneficialOwners = [
    BeneficialOwnerModel(
      id: '1',
      name: 'ATUL LAHOTI',
      nationality: null,
    ),
    BeneficialOwnerModel(
      id: '2',
      name: 'HEMANT KUMAR GHIYA',
      nationality: null,
    ),
  ];

  static const List<String> nationalities = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Bangladesh',
    'Belgium',
    'Bhutan',
    'Brazil',
    'Canada',
    'China',
    'Denmark',
    'Egypt',
    'France',
    'Germany',
    'India',
    'Indonesia',
    'Italy',
    'Japan',
    'Malaysia',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Norway',
    'Russia',
    'Saudi Arabia',
    'Singapore',
    'South Africa',
    'Spain',
    'Sri Lanka',
    'Sweden',
    'Switzerland',
    'Thailand',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
  ];

  static const BankDetailsModel defaultBankDetails = BankDetailsModel(
    accountNumber: AppStrings.mockBankAccountNumber,
    ifscCode: AppStrings.mockIfscCode,
    accountHolderName: AppStrings.mockCompanyName,
    bankBranch: AppStrings.mockBankBranch,
    isVerified: false,
  );
}
