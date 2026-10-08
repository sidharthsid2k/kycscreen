import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_checkbox.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import 'alternate_owner_section.dart';
import 'beneficial_owner_card.dart';

class BeneficialOwnersForm extends StatelessWidget {
  const BeneficialOwnersForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      builder: (context, state) {
        final cubit = context.read<KycCubit>();

        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...state.beneficialOwners.asMap().entries.map((entry) {
                final index = entry.key;
                final owner = entry.value;

                return Column(
                  children: [
                    BeneficialOwnerCard(
                      key: ValueKey(owner.id),
                      owner: owner,
                      onNameChanged: (val) =>
                          cubit.updateOwnerName(owner.id, val),
                      onRemove: owner.isRemovable
                          ? () => cubit.removeBeneficialOwner(owner.id)
                          : null,
                    ),
                    if (index < state.beneficialOwners.length - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.h16,
                        ),
                        child: Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: AppColors.borderLight,
                        ),
                      ),
                  ],
                );
              }),
              SizedBox(height: AppDimensions.h20),
              AppButton(
                variant: AppButtonVariant.outline,
                text: AppStrings.addNewBeneficialOwner,
                textColor: AppColors.primary,
                backgroundColor: AppColors.primary,
                onPressed: () {
                  cubit.addNewBeneficialOwner();
                  if (!state.showAlternateOwnerSection) {
                    cubit.toggleAlternateOwnerSection();
                  }
                },
              ),
              if (state.showAlternateOwnerSection) ...[
                SizedBox(height: AppDimensions.h24),
                const AlternateOwnerSection(),
              ],
              SizedBox(height: AppDimensions.h20),
              AppCheckbox(
                value: state.undertakingAccepted,
                onChanged: (checked) => cubit.toggleUndertaking(checked),
                label: Text(
                  AppStrings.beneficialOwnerUndertaking,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
