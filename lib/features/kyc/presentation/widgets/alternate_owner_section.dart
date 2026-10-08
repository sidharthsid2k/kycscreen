import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class AlternateOwnerSection extends StatefulWidget {
  const AlternateOwnerSection({super.key});

  @override
  State<AlternateOwnerSection> createState() => _AlternateOwnerSectionState();
}

class _AlternateOwnerSectionState extends State<AlternateOwnerSection> {
  late final TextEditingController _panController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<KycCubit>();
    _panController = TextEditingController(text: cubit.state.alternateOwnerPan);
  }

  @override
  void dispose() {
    _panController.dispose();
    super.dispose();
  }

  void _showOwnerPicker(BuildContext context, KycState state) {
    final cubit = context.read<KycCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.r24),
          ),
        ),
        padding: EdgeInsets.all(AppDimensions.w20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppStrings.beneficialOwnerDirectorNameLabel,
                    style: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Container(
                    width: AppDimensions.w28,
                    height: AppDimensions.h28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: AppColors.backgroundWhite,
                      size: AppDimensions.iconSm,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.h16),
            ...state.beneficialOwners.map((owner) {
              final isSelected = owner.name == state.alternateOwnerName;
              return ListTile(
                title: Text(
                  owner.name.isEmpty ? 'Unnamed Director' : owner.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: AppColors.accentMagenta)
                    : null,
                onTap: () {
                  cubit.selectAlternateOwner(owner.name);
                  Navigator.of(ctx).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      builder: (context, state) {
        final cubit = context.read<KycCubit>();
        final selectedName = state.alternateOwnerName ??
            (state.beneficialOwners.isNotEmpty
                ? state.beneficialOwners.first.name
                : 'Beneficial Owner');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.addAlternateOwnerTitle,
              style: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppDimensions.h6),
            Text(
              AppStrings.addAlternateOwnerSubtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.h16),
            AppDropdownField(
              label: AppStrings.beneficialOwnerDirectorNameLabel,
              hintText: AppStrings.pleaseSelectOneUser,
              value: state.alternateOwnerName,
              onTap: () => _showOwnerPicker(context, state),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return AppStrings.pleaseSelectOneUser;
                }
                return null;
              },
            ),
            SizedBox(height: AppDimensions.h4),
            Text(
              AppStrings.pleaseSelectOneUser,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.h16),
            AppUnderlineTextField(
              label: '$selectedName${AppStrings.personalPanLabelSuffix}',
              controller: _panController,
              textCapitalization: TextCapitalization.characters,
              maxLength: 10,
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: cubit.updateAlternateOwnerPan,
              validator: Validators.validatePan,
            ),
          ],
        );
      },
    );
  }
}
