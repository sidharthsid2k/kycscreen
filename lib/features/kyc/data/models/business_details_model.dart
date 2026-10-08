import 'package:equatable/equatable.dart';

class BusinessDetailsModel extends Equatable {
  const BusinessDetailsModel({
    required this.pan,
    required this.companyName,
    required this.cin,
    this.companyNickname = '',
    this.primaryBusinessActivity,
    this.gstin,
    required this.billingAddress,
    this.websiteUrl = '',
    this.noWebsite = false,
  });

  final String pan;
  final String companyName;
  final String cin;
  final String companyNickname;
  final String? primaryBusinessActivity;
  final String? gstin;
  final String billingAddress;
  final String websiteUrl;
  final bool noWebsite;

  BusinessDetailsModel copyWith({
    String? pan,
    String? companyName,
    String? cin,
    String? companyNickname,
    String? primaryBusinessActivity,
    String? gstin,
    String? billingAddress,
    String? websiteUrl,
    bool? noWebsite,
  }) {
    return BusinessDetailsModel(
      pan: pan ?? this.pan,
      companyName: companyName ?? this.companyName,
      cin: cin ?? this.cin,
      companyNickname: companyNickname ?? this.companyNickname,
      primaryBusinessActivity:
          primaryBusinessActivity ?? this.primaryBusinessActivity,
      gstin: gstin ?? this.gstin,
      billingAddress: billingAddress ?? this.billingAddress,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      noWebsite: noWebsite ?? this.noWebsite,
    );
  }

  @override
  List<Object?> get props => [
        pan,
        companyName,
        cin,
        companyNickname,
        primaryBusinessActivity,
        gstin,
        billingAddress,
        websiteUrl,
        noWebsite,
      ];
}
