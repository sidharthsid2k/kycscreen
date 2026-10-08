import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_step_indicator.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class EnterGstinCard extends StatefulWidget {
  const EnterGstinCard({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<EnterGstinCard> createState() => _EnterGstinCardState();
}

class _EnterGstinCardState extends State<EnterGstinCard> {
  late final TextEditingController _gstinController;

  @override
  void initState() {
    super.initState();
    _gstinController = TextEditingController(
      text: context.read<KycCubit>().state.enteredGstin,
    );
  }

  @override
  void dispose() {
    _gstinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.backgroundWhite,
      borderRadius: AppDimensions.r16,
      borderColor: AppColors.cardBorder,
      borderWidth: 1.0,
      padding: EdgeInsets.fromLTRB(
        AppDimensions.w16,
        AppDimensions.h18,
        AppDimensions.w16,
        AppDimensions.h24,
      ),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadowColor,
          offset: Offset(0, 8),
          blurRadius: 24,
        ),
      ],
      child: BlocBuilder<KycCubit, KycState>(
        builder: (context, state) {
          final cubit = context.read<KycCubit>();

          return Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppStepIndicator(
                  currentStep: 1,
                  completionPercentage: AppStrings.step2Progress,
                ),
                SizedBox(height: AppDimensions.h24),
                Text(
                  AppStrings.gstinTitle,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.h6),
                Text(
                  AppStrings.gstinSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppDimensions.h24),
                AppUnderlineTextField(
                  label: AppStrings.gstinLabel,
                  controller: _gstinController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  errorText: state.gstinError,
                  onChanged: (val) {
                    cubit.updateEnteredGstin(val);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
