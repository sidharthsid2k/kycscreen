import 'package:equatable/equatable.dart';

enum DocumentStatus {
  empty,
  selected,
  uploading,
  extracting,
  verifying,
  verified,
  errorBw,
}

class DocumentUploadModel extends Equatable {
  const DocumentUploadModel({
    required this.fileName,
    required this.fileSizeBytes,
    required this.assetPath,
    this.isBlackAndWhite = false,
    this.status = DocumentStatus.empty,
    this.directorName = "DIRECTOR'S NAME",
    this.panNumber = 'ABCDE1234F',
    this.errorMessage,
  });

  final String fileName;
  final int fileSizeBytes;
  final String assetPath;
  final bool isBlackAndWhite;
  final DocumentStatus status;
  final String directorName;
  final String panNumber;
  final String? errorMessage;

  DocumentUploadModel copyWith({
    String? fileName,
    int? fileSizeBytes,
    String? assetPath,
    bool? isBlackAndWhite,
    DocumentStatus? status,
    String? directorName,
    String? panNumber,
    String? errorMessage,
  }) {
    return DocumentUploadModel(
      fileName: fileName ?? this.fileName,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      assetPath: assetPath ?? this.assetPath,
      isBlackAndWhite: isBlackAndWhite ?? this.isBlackAndWhite,
      status: status ?? this.status,
      directorName: directorName ?? this.directorName,
      panNumber: panNumber ?? this.panNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fileName,
        fileSizeBytes,
        assetPath,
        isBlackAndWhite,
        status,
        directorName,
        panNumber,
        errorMessage,
      ];
}
