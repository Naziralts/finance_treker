import 'package:finance_treker/core/features/dashboard/add_transaction/presentation/pages/add_transaction_page.dart';
import 'package:finance_treker/core/features/dashboard/add_transaction/presentation/pages/statistics_page.dart';
import 'package:finance_treker/core/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:finance_treker/core/features/dashboard/settings/presentation/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

import 'main_scaffold.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [

      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [

    
          GoRoute(
            path: '/',
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),

       
          GoRoute(
            path: '/add',
            name: 'add',
            builder: (context, state) =>
                const AddTransactionPage(),
          ),

          GoRoute(
            path: '/statistics',
            name: 'statistics',
            builder: (context, state) =>
                const StatisticsPage(),
          ),

          /// ⚙ Settings
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) =>
                const SettingsPage(),
          ),
        ],
      ),
    ],

    
    debugLogDiagnostics: true,
  );
}
