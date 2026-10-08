import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class BankAccountForm extends StatefulWidget {
  const BankAccountForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<BankAccountForm> createState() => _BankAccountFormState();
}

class _BankAccountFormState extends State<BankAccountForm> {
  late final TextEditingController _accountNumberController;
  late final TextEditingController _ifscController;
  late final TextEditingController _holderNameController;
  late final TextEditingController _branchController;

  @override
  void initState() {
    super.initState();
    final bank = context.read<KycCubit>().state.bankDetails;
    _accountNumberController =
        TextEditingController(text: bank.accountNumber);
    _ifscController = TextEditingController(text: bank.ifscCode);
    _holderNameController =
        TextEditingController(text: bank.accountHolderName);
    _branchController = TextEditingController(text: bank.bankBranch);
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ifscController.dispose();
    _holderNameController.dispose();
    _branchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      builder: (context, state) {
        final cubit = context.read<KycCubit>();
        final isVerified = state.bankDetails.isVerified;

        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUnderlineTextField(
                label: AppStrings.bankAccountNumberLabel,
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(18),
                ],
                onChanged: cubit.updateBankAccountNumber,
                validator: Validators.validateBankAccount,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.ifscCodeLabel,
                controller: _ifscController,
                textCapitalization: TextCapitalization.characters,
                maxLength: 11,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  LengthLimitingTextInputFormatter(11),
                ],
                onChanged: cubit.updateIfscCode,
                validator: Validators.validateIfsc,
              ),
              if (isVerified) ...[
                SizedBox(height: AppDimensions.h16),
                AppUnderlineTextField(
                  label: AppStrings.accountHolderNameLabel,
                  controller: _holderNameController,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 60,
                  onChanged: cubit.updateAccountHolderName,
                  validator: Validators.validateFullName,
                  suffixIcon: Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                    size: AppDimensions.iconMd,
                  ),
                  helperWidget: Text(
                    AppStrings.nameMatchesCompanyPan,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.h16),
                AppUnderlineTextField(
                  label: AppStrings.bankBranchLabel,
                  controller: _branchController,
                  hintText: AppStrings.enterBankBranchHint,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  onChanged: cubit.updateBankBranch,
                  validator: Validators.validateBankBranch,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
