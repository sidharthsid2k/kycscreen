import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/route_names.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import 'pan_error_banner.dart';
import 'pan_preview_card.dart';
import 'pan_upload_dropzone.dart';
import 'pan_upload_picker_sheet.dart';

class PanUploadCardArea extends StatelessWidget {
  const PanUploadCardArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.document != current.document ||
          previous.documentStatus != current.documentStatus,
      builder: (context, state) {
        return Column(
          children: [
            if (state.hasDocument && !state.isBwError)
              PanPreviewCard(
                document: state.document!,
                onRemovePressed: () => context.read<KycCubit>().removeDocument(),
                onChangePressed: () => PanUploadPickerSheet.show(context),
              )
            else
              PanUploadDropzone(
                onBrowsePressed: () => PanUploadPickerSheet.show(context),
                onTakePhotoPressed: () => context.push(RouteNames.takePhoto),
              ),
            if (state.isBwError) ...[
              SizedBox(height: AppDimensions.h16),
              const PanErrorBanner(),
            ],
          ],
        );
      },
    );
  }
}
