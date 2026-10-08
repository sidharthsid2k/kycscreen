import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import '../widgets/camera_overlay_view.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cameraDark,
      body: BlocBuilder<KycCubit, KycState>(
        builder: (context, state) {
          return CameraOverlayView(
            flashEnabled: state.flashEnabled,
            isCapturing: state.isCapturing,
            onClosePressed: () => context.pop(),
            onFlashPressed: () => context.read<KycCubit>().toggleFlash(),
            onFlipPressed: () => context.read<KycCubit>().toggleCameraFacing(),
            onShutterPressed: () async {
              await context.read<KycCubit>().capturePhoto();
              if (context.mounted) {
                context.pop();
              }
            },
          );
        },
      ),
    );
  }
}
