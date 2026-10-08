import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/screen_utils.dart';
import 'features/kyc/presentation/state/kyc_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IdUploadApp());
}

class IdUploadApp extends StatelessWidget {
  const IdUploadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KycCubit(),
      child: AppScreenUtils.init(
        child: MaterialApp.router(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
