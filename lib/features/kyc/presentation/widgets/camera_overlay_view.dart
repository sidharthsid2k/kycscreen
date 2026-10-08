import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class CameraOverlayView extends StatelessWidget {
  const CameraOverlayView({
    super.key,
    required this.onClosePressed,
    required this.onFlashPressed,
    required this.onShutterPressed,
    required this.onFlipPressed,
    required this.flashEnabled,
    required this.isCapturing,
  });

  final VoidCallback onClosePressed;
  final VoidCallback onFlashPressed;
  final VoidCallback onShutterPressed;
  final VoidCallback onFlipPressed;
  final bool flashEnabled;
  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.cameraBg,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.cameraOverlayBg,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.w16,
                    AppDimensions.h8,
                    AppDimensions.w16,
                    AppDimensions.h12,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onClosePressed,
                    child: Icon(
                      Icons.close,
                      color: AppColors.backgroundWhite,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.w24),
                child: Container(
                  height: AppDimensions.h206,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.r16),
                    border: Border.all(
                      color: AppColors.backgroundWhite.withValues(alpha: 0.85),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.r14),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            AppAssets.cameraBg,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.w14,
                            vertical: AppDimensions.h8,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.r10),
                              border: Border.all(
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.35),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.r10),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      AppAssets.panCard,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (isCapturing)
                                    Positioned.fill(
                                      child: Container(
                                        color: AppColors.backgroundWhite
                                            .withValues(alpha: 0.85),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.h32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.w24),
                child: Text(
                  AppStrings.cameraTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.h12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.w24),
                child: Text(
                  AppStrings.cameraSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.backgroundWhite.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w300,
                    height: 1.3,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.w36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onFlashPressed,
                      child: SvgPicture.asset(
                        AppAssets.flashIcon,
                        width: AppDimensions.w60,
                        height: AppDimensions.h60,
                      ),
                    ),
                    _ShutterButton(
                      onPressed: onShutterPressed,
                      isCapturing: isCapturing,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onFlipPressed,
                      child: SvgPicture.asset(
                        AppAssets.cameraRotateIcon,
                        width: AppDimensions.w60,
                        height: AppDimensions.h60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.h40),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShutterButton extends StatelessWidget {
  const _ShutterButton({
    required this.onPressed,
    required this.isCapturing,
  });

  final VoidCallback onPressed;
  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isCapturing ? null : onPressed,
      child: Container(
        width: AppDimensions.w70,
        height: AppDimensions.h70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.backgroundWhite.withValues(alpha: 0.8),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: isCapturing ? AppDimensions.w48 : AppDimensions.w60,
          height: isCapturing ? AppDimensions.h48 : AppDimensions.h60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.backgroundWhite,
          ),
        ),
      ),
    );
  }
}
