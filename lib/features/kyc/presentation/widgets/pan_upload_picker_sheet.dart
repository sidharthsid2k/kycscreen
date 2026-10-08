import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_radio_button.dart';
import '../state/kyc_cubit.dart';

class PanUploadPickerSheet {
  PanUploadPickerSheet._();

  static void show(BuildContext context) {
    String selectedOption = 'color';
    AppBottomSheet.show(
      context: context,
      title: AppStrings.selectUploadMethod,
      subtitle: AppStrings.fileTypesAndSize,
      bottomAction: StatefulBuilder(
        builder: (ctx, setSheetState) {
          return AppButton(
            text: AppStrings.done,
            onPressed: () {
              Navigator.of(context).pop();
              if (selectedOption == 'color') {
                context.read<KycCubit>().selectColorDocument();
              } else {
                context.read<KycCubit>().selectBwDocument();
              }
            },
          );
        },
      ),
      child: StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppRadioButton<String>(
                value: 'color',
                groupValue: selectedOption,
                title: AppStrings.uploadColorPan,
                subtitle: 'director_pan_card.jpg (1.2 MB)',
                onChanged: (val) {
                  setSheetState(() => selectedOption = val);
                },
              ),
              const Divider(color: AppColors.borderLight),
              AppRadioButton<String>(
                value: 'bw',
                groupValue: selectedOption,
                title: AppStrings.uploadBwPan,
                subtitle: 'director_pan_scanned_bw.jpg (950 KB)',
                onChanged: (val) {
                  setSheetState(() => selectedOption = val);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
