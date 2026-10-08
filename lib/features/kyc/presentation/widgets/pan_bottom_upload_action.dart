import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class PanBottomUploadAction extends StatelessWidget {
  const PanBottomUploadAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.document != current.document ||
          previous.documentStatus != current.documentStatus,
      builder: (context, state) {
        if (!state.hasDocument || state.isBwError) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.w20,
            AppDimensions.h12,
            AppDimensions.w20,
            AppDimensions.h20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.transparent,
          ),
          child: AppButton(
            text: AppStrings.upload,
            onPressed: () => context.read<KycCubit>().uploadDocument(),
          ),
        );
      },
    );
  }
}
