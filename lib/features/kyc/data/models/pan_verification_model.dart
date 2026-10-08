import 'package:equatable/equatable.dart';

class PanVerificationModel extends Equatable {
  const PanVerificationModel({
    required this.panNumber,
    required this.fullName,
    required this.preferredName,
    required this.aadhaarNumber,
    this.otp = '',
  });

  final String panNumber;
  final String fullName;
  final String preferredName;
  final String aadhaarNumber;
  final String otp;

  PanVerificationModel copyWith({
    String? panNumber,
    String? fullName,
    String? preferredName,
    String? aadhaarNumber,
    String? otp,
  }) {
    return PanVerificationModel(
      panNumber: panNumber ?? this.panNumber,
      fullName: fullName ?? this.fullName,
      preferredName: preferredName ?? this.preferredName,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [
        panNumber,
        fullName,
        preferredName,
        aadhaarNumber,
        otp,
      ];
}
