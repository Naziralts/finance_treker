import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/add_transaction/presentation/pages/add_transaction_page.dart';
import '../../features/statistics/presentation/pages/statistics_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
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

    /// 🌐 Web URL Strategy (optional but recommended)
    debugLogDiagnostics: true,
  );
}
