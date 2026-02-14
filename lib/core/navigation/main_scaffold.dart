import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_icons.dart';
import '../constants/app_strings.dart';
import '../widgets/app_svg_icon.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _calculateIndex(location);

    if (width < 600) {
      return _MobileScaffold(
        child: child,
        selectedIndex: selectedIndex,
      );
    }

    return _DesktopScaffold(
      child: child,
      selectedIndex: selectedIndex,
    );
  }

  int _calculateIndex(String location) {
    if (location.startsWith('/statistics')) return 1;
    if (location.startsWith('/add')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }
}

//////////////////////////////////////////////////////////////////
// 📱 MOBILE SCAFFOLD (Drawer)
//////////////////////////////////////////////////////////////////

class _MobileScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const _MobileScaffold({
    required this.child,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: AppSvgIcon(path: AppIcons.bell),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(Icons.account_balance, size: 60),
            ),
            _drawerItem(
              context,
              AppIcons.home,
              AppStrings.dashboard,
              '/',
              0,
            ),
            _drawerItem(
              context,
              AppIcons.stats,
              AppStrings.statistics,
              '/statistics',
              1,
            ),
            _drawerItem(
              context,
              AppIcons.add,
              AppStrings.add,
              '/add',
              2,
            ),
            _drawerItem(
              context,
              AppIcons.settings,
              AppStrings.settings,
              '/settings',
              3,
            ),
          ],
        ),
      ),
      body: child,
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String iconPath,
    String title,
    String route,
    int index,
  ) {
    final isSelected = selectedIndex == index;

    return ListTile(
      leading: AppSvgIcon(
        path: iconPath,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight:
              isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}

//////////////////////////////////////////////////////////////////
// 🖥 DESKTOP / TABLET SCAFFOLD (NavigationRail)
//////////////////////////////////////////////////////////////////

class _DesktopScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const _DesktopScaffold({
    required this.child,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  context.go('/');
                  break;
                case 1:
                  context.go('/statistics');
                  break;
                case 2:
                  context.go('/add');
                  break;
                case 3:
                  context.go('/settings');
                  break;
              }
            },
            destinations: const [
              NavigationRailDestination(
                icon: AppSvgIcon(path: AppIcons.home),
                label: Text(AppStrings.dashboard),
              ),
              NavigationRailDestination(
                icon: AppSvgIcon(path: AppIcons.stats),
                label: Text(AppStrings.statistics),
              ),
              NavigationRailDestination(
                icon: AppSvgIcon(path: AppIcons.add),
                label: Text(AppStrings.add),
              ),
              NavigationRailDestination(
                icon: AppSvgIcon(path: AppIcons.settings),
                label: Text(AppStrings.settings),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
