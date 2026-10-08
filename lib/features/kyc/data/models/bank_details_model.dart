import 'package:equatable/equatable.dart';

class BankDetailsModel extends Equatable {
  const BankDetailsModel({
    required this.accountNumber,
    required this.ifscCode,
    this.accountHolderName = '',
    this.bankBranch = '',
    this.isVerified = false,
  });

  final String accountNumber;
  final String ifscCode;
  final String accountHolderName;
  final String bankBranch;
  final bool isVerified;

  BankDetailsModel copyWith({
    String? accountNumber,
    String? ifscCode,
    String? accountHolderName,
    String? bankBranch,
    bool? isVerified,
  }) {
    return BankDetailsModel(
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankBranch: bankBranch ?? this.bankBranch,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        accountNumber,
        ifscCode,
        accountHolderName,
        bankBranch,
        isVerified,
      ];
}
