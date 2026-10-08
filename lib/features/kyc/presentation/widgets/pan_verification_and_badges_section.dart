import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import 'pan_verification_steps.dart';

class PanVerificationAndBadgesSection extends StatelessWidget {
  const PanVerificationAndBadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.documentStatus != current.documentStatus,
      builder: (context, state) {
        if (state.isBwError || (state.hasDocument && !state.isBwError)) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(top: AppDimensions.h16),
          child: PanVerificationSteps(status: state.documentStatus),
        );
      },
    );
  }
}
