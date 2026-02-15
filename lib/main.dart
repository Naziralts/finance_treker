import 'package:finance_treker/%20injection_container.dart';
import 'package:finance_treker/%20injection_container.dart' as di;
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),

        BlocProvider(
          create: (_) => sl<DashboardBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,

            routerConfig: AppRouter.router,

           
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
