import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_underline_text_field.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class PanVerifiedForm extends StatefulWidget {
  const PanVerifiedForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<PanVerifiedForm> createState() => _PanVerifiedFormState();
}

class _PanVerifiedFormState extends State<PanVerifiedForm> {
  late final TextEditingController _panController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _preferredNameController;
  late final TextEditingController _aadhaarController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<KycCubit>();
    _panController = TextEditingController(
      text: cubit.state.panVerification.panNumber,
    );
    _fullNameController = TextEditingController(
      text: cubit.state.panVerification.fullName,
    );
    _preferredNameController = TextEditingController(
      text: cubit.state.panVerification.preferredName,
    );
    _aadhaarController = TextEditingController(
      text: cubit.state.panVerification.aadhaarNumber,
    );
  }

  @override
  void dispose() {
    _panController.dispose();
    _fullNameController.dispose();
    _preferredNameController.dispose();
    _aadhaarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (prev, curr) => false,
      builder: (context, state) {
        final cubit = context.read<KycCubit>();

        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppUnderlineTextField(
                label: AppStrings.panFieldLabel,
                controller: _panController,
                readOnly: false,
                maxLength: 10,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: Validators.validatePan,
                onChanged: cubit.updatePan,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.fullNameFieldLabel,
                controller: _fullNameController,
                readOnly: false,
                maxLength: 60,
                textCapitalization: TextCapitalization.words,
                validator: Validators.validateFullName,
                onChanged: cubit.updateFullName,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.preferredNameFieldLabel,
                controller: _preferredNameController,
                readOnly: false,
                maxLength: 30,
                textCapitalization: TextCapitalization.words,
                validator: Validators.validatePreferredName,
                onChanged: cubit.updatePreferredName,
              ),
              SizedBox(height: AppDimensions.h16),
              AppUnderlineTextField(
                label: AppStrings.aadhaarFieldLabel,
                controller: _aadhaarController,
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [AadhaarInputFormatter()],
                maxLength: 14,
                validator: Validators.validateAadhaar,
                onChanged: cubit.updateAadhaar,
              ),
            ],
          ),
        );
      },
    );
  }
}
