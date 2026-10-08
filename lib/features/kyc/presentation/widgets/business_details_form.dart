import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_checkbox.dart';
import '../../../../core/widgets/app_dropdown_field.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import 'business_activity_bottom_sheet.dart';
import 'gstin_selector_bottom_sheet.dart';

class BusinessDetailsForm extends StatefulWidget {
  const BusinessDetailsForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<BusinessDetailsForm> createState() => _BusinessDetailsFormState();
}

class _BusinessDetailsFormState extends State<BusinessDetailsForm> {
  late final TextEditingController _panController;
  late final TextEditingController _companyNameController;
  late final TextEditingController _cinController;
  late final TextEditingController _nicknameController;
  late final TextEditingController _billingAddressController;
  late final TextEditingController _websiteController;

  @override
  void initState() {
    super.initState();
    final details = context.read<KycCubit>().state.businessDetails;
    _panController = TextEditingController(text: details.pan);
    _companyNameController = TextEditingController(text: details.companyName);
    _cinController = TextEditingController(text: details.cin);
    _nicknameController = TextEditingController(text: details.companyNickname);
    _billingAddressController =
        TextEditingController(text: details.billingAddress);
    _websiteController = TextEditingController(text: details.websiteUrl);
  }

  @override
  void dispose() {
    _panController.dispose();
    _companyNameController.dispose();
    _cinController.dispose();
    _nicknameController.dispose();
    _billingAddressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KycCubit, KycState>(
      listenWhen: (prev, curr) =>
          prev.businessDetails.noWebsite != curr.businessDetails.noWebsite,
      listener: (context, state) {
        if (state.businessDetails.noWebsite) {
          _websiteController.clear();
        }
      },
      builder: (context, state) {
        final cubit = context.read<KycCubit>();
        final details = state.businessDetails;

        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUnderlineTextField(
                label: AppStrings.panLabel,
                controller: _panController,
                readOnly: false,
                onChanged: cubit.updateBusinessPan,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.companyNameLabel,
                controller: _companyNameController,
                readOnly: false,
                onChanged: cubit.updateCompanyName,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.cinLabel,
                controller: _cinController,
                readOnly: false,
                onChanged: cubit.updateCin,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.companyNicknameLabel,
                hintText: AppStrings.enterCompanyNicknameHint,
                controller: _nicknameController,
                readOnly: false,
                onChanged: cubit.updateCompanyNickname,
                validator: Validators.validateCompanyNickname,
                showErrorIcon: true,
              ),
              SizedBox(height: AppDimensions.h16),
              AppDropdownField(
                label: AppStrings.primaryBusinessActivityLabel,
                hintText: AppStrings.selectOne,
                value: details.primaryBusinessActivity,
                onTap: () => BusinessActivityBottomSheet.show(context),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please select primary business activity';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.h16),
              AppDropdownField(
                label: AppStrings.gstinLabel,
                hintText: AppStrings.select,
                value: details.gstin,
                onTap: () => GstinSelectorBottomSheet.show(context),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please select GSTIN';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.billingAddressLabel,
                controller: _billingAddressController,
                readOnly: false,
                maxLines: 4,
                onChanged: cubit.updateBillingAddress,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.websiteUrlLabel,
                hintText: AppStrings.enterWebsiteHint,
                controller: _websiteController,
                readOnly: false,
                enabled: !details.noWebsite,
                onChanged: cubit.updateWebsiteUrl,
                validator: (val) => Validators.validateWebsiteUrl(
                  val,
                  details.noWebsite,
                ),
              ),
              SizedBox(height: AppDimensions.h12),
              AppCheckbox(
                value: details.noWebsite,
                onChanged: (checked) => cubit.toggleNoWebsite(checked),
                label: Text(
                  AppStrings.noWebsiteCheckbox,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
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
