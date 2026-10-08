import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_status_bar_divider.dart';
import '../state/kyc_cubit.dart';
import '../widgets/bank_account_main_card.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context) {
    final cubit = context.read<KycCubit>();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (!cubit.state.bankDetails.isVerified) {
      cubit.verifyBankDetails();
    } else {
      context.push(RouteNames.kycSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBasePink,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.1, -1.0),
            radius: 1.3,
            colors: [
              AppColors.bgGradientPink,
              AppColors.bgGradientPinkMid,
              AppColors.bgBasePink,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const AppStatusBarDivider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.w16,
                  vertical: AppDimensions.h8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.w16,
                    0,
                    AppDimensions.w16,
                    AppDimensions.h24,
                  ),
                  child: BankAccountMainCard(formKey: _formKey),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.w16,
                  AppDimensions.h12,
                  AppDimensions.w16,
                  AppDimensions.h20,
                ),
                child: AppButton(
                  text: AppStrings.submitAndContinue,
                  onPressed: () => _onSubmit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
