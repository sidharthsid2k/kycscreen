import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class BusinessActivityBottomSheet extends StatefulWidget {
  const BusinessActivityBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    context.read<KycCubit>().setActivitySearchQuery('');
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
          child: const BusinessActivityBottomSheet(),
        ),
      ),
    );
  }

  @override
  State<BusinessActivityBottomSheet> createState() =>
      _BusinessActivityBottomSheetState();
}

class _BusinessActivityBottomSheetState
    extends State<BusinessActivityBottomSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
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
        AppDimensions.h12,
      ),
      child: BlocBuilder<KycCubit, KycState>(
        builder: (context, state) {
          final cubit = context.read<KycCubit>();
          final activities = state.filteredActivities;
          final selected =
              state.businessDetails.primaryBusinessActivity;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.selectPrimaryBusinessActivityTitle,
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
              AppSearchField(
                controller: _searchController,
                onChanged: cubit.setActivitySearchQuery,
              ),
              SizedBox(height: AppDimensions.h12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: activities.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.0,
                    thickness: 0.8,
                    color: AppColors.borderLight,
                  ),
                  itemBuilder: (context, index) {
                    final item = activities[index];
                    final isSelected = item == selected;

                    return InkWell(
                      onTap: () {
                        cubit.selectPrimaryBusinessActivity(item);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.h12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(width: AppDimensions.w8),
                            Container(
                              width: AppDimensions.w18,
                              height: AppDimensions.h18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.accentMagenta
                                      : AppColors.stepInactive,
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: AppDimensions.w8,
                                        height: AppDimensions.h8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.accentMagenta,
                                        ),
                                      ),
                                    )
                                  : null,
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
