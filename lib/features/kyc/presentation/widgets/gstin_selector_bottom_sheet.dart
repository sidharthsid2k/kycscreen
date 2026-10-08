import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_checkbox.dart';
import '../../data/mock_data/kyc_mock_data.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class GstinSelectorBottomSheet extends StatelessWidget {
  const GstinSelectorBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<KycCubit>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
          ),
          child: const GstinSelectorBottomSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.r24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.w20,
        AppDimensions.h20,
        AppDimensions.w20,
        AppDimensions.h24,
      ),
      child: BlocBuilder<KycCubit, KycState>(
        builder: (context, state) {
          final cubit = context.read<KycCubit>();
          final selectedGstin = state.businessDetails.gstin;
          final gstinList = KycMockData.gstinList;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.selectGstinTitle,
                      style: AppTextStyles.subtitle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.w8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
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
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: gstinList.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.0,
                    thickness: 0.8,
                    color: AppColors.borderLight,
                  ),
                  itemBuilder: (context, index) {
                    final item = gstinList[index];
                    final isSelected = item == selectedGstin;

                    return InkWell(
                      onTap: () {
                        cubit.selectGstin(item);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.h14,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            AppCheckbox(
                              value: isSelected,
                              activeColor: AppColors.accentMagenta,
                              onChanged: (_) {
                                cubit.selectGstin(item);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
