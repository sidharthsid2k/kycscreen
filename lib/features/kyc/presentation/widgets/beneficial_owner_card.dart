import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../../data/models/beneficial_owner_model.dart';
import 'nationality_bottom_sheet.dart';

class BeneficialOwnerCard extends StatefulWidget {
  const BeneficialOwnerCard({
    super.key,
    required this.owner,
    required this.onNameChanged,
    this.onRemove,
  });

  final BeneficialOwnerModel owner;
  final ValueChanged<String> onNameChanged;
  final VoidCallback? onRemove;

  @override
  State<BeneficialOwnerCard> createState() => _BeneficialOwnerCardState();
}

class _BeneficialOwnerCardState extends State<BeneficialOwnerCard> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.owner.name);
  }

  @override
  void didUpdateWidget(BeneficialOwnerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.owner.name != widget.owner.name &&
        _nameController.text != widget.owner.name) {
      _nameController.text = widget.owner.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.onRemove != null)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onRemove,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.h8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.error,
                      size: AppDimensions.iconSm,
                    ),
                    SizedBox(width: AppDimensions.w4),
                    Text(
                      AppStrings.remove,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        AppUnderlineTextField(
          label: '',
          controller: _nameController,
          hintText: 'Enter Director Name',
          textCapitalization: TextCapitalization.words,
          onChanged: widget.onNameChanged,
          validator: Validators.validateFullName,
        ),
        SizedBox(height: AppDimensions.h12),
        AppDropdownField(
          label: '',
          hintText: AppStrings.selectNationality,
          value: widget.owner.nationality,
          onTap: () => NationalitySelectorBottomSheet.show(
            context,
            widget.owner.id,
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please select nationality';
            }
            return null;
          },
        ),
      ],
    );
  }
}
