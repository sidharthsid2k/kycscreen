import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/kyc/presentation/screens/bank_account_screen.dart';
import '../../features/kyc/presentation/screens/beneficial_owners_screen.dart';
import '../../features/kyc/presentation/screens/business_details_screen.dart';
import '../../features/kyc/presentation/screens/camera_capture_screen.dart';
import '../../features/kyc/presentation/screens/enter_gstin_screen.dart';
import '../../features/kyc/presentation/screens/kyc_intro_screen.dart';
import '../../features/kyc/presentation/screens/kyc_success_screen.dart';
import '../../features/kyc/presentation/screens/pan_upload_screen.dart';
import '../../features/kyc/presentation/screens/pan_verified_screen.dart';
import '../../features/kyc/presentation/state/kyc_cubit.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.kycIntro,
    routes: [
      GoRoute(
        path: RouteNames.kycIntro,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const KycIntroScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.panUpload,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const PanUploadScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.panUploadError,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const _PanUploadErrorWrapper(),
        ),
      ),
      GoRoute(
        path: RouteNames.takePhoto,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const CameraCaptureScreen(),
          transitionType: _TransitionType.fade,
        ),
      ),
      GoRoute(
        path: RouteNames.panVerified,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const PanVerifiedScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.enterGstin,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const EnterGstinScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.businessDetails,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const BusinessDetailsScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.beneficialOwners,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const BeneficialOwnersScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.bankAccountDetails,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const BankAccountScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.kycSuccess,
        pageBuilder: (context, state) => _buildPageWithTransition(
          key: state.pageKey,
          child: const KycSuccessScreen(),
        ),
      ),
    ],
  );

  static CustomTransitionPage<void> _buildPageWithTransition({
    required LocalKey key,
    required Widget child,
    _TransitionType transitionType = _TransitionType.slide,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (transitionType == _TransitionType.fade) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }

        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

enum _TransitionType { slide, fade }

class _PanUploadErrorWrapper extends StatefulWidget {
  const _PanUploadErrorWrapper();

  @override
  State<_PanUploadErrorWrapper> createState() => _PanUploadErrorWrapperState();
}

class _PanUploadErrorWrapperState extends State<_PanUploadErrorWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<KycCubit>().selectBwDocument();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PanUploadScreen();
  }
}
