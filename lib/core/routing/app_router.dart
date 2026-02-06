import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_today_page.dart';
import '../../features/cycle/presentation/pages/cycle_calendar_page.dart';
import '../../features/tracking/presentation/pages/daily_log_page.dart';
import '../../features/partner/presentation/pages/partner_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    HomeTodayPage(),
    CycleCalendarPage(),
    DailyLogPage(),
    PartnerPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.today_outlined), label: "Bugün"),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: "Takvim"),
          NavigationDestination(icon: Icon(Icons.note_alt_outlined), label: "Günlük"),
          NavigationDestination(icon: Icon(Icons.qr_code_2_outlined), label: "Partner"),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Ayarlar"),
        ],
      ),
    );
  }
}
