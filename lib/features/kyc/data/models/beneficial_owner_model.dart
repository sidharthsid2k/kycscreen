import 'package:equatable/equatable.dart';

class BeneficialOwnerModel extends Equatable {
  const BeneficialOwnerModel({
    required this.id,
    required this.name,
    this.nationality,
    this.isRemovable = false,
  });

  final String id;
  final String name;
  final String? nationality;
  final bool isRemovable;

  BeneficialOwnerModel copyWith({
    String? id,
    String? name,
    String? nationality,
    bool? isRemovable,
  }) {
    return BeneficialOwnerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nationality: nationality ?? this.nationality,
      isRemovable: isRemovable ?? this.isRemovable,
    );
  }

  @override
  List<Object?> get props => [id, name, nationality, isRemovable];
}
