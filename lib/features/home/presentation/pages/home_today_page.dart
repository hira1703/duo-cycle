import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/day_strip.dart';
import '../widgets/cycle_summary_card.dart';
import '../widgets/quick_card.dart';

class HomeTodayPage extends StatefulWidget {
  const HomeTodayPage({super.key});

  @override
  State<HomeTodayPage> createState() => _HomeTodayPageState();
}

class _HomeTodayPageState extends State<HomeTodayPage> {
  int selectedDay = 6;
  final days = List.generate(14, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.bgBottom,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgTop, AppColors.bgBottom],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _TopBar(theme: theme)),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.pageHPad),
                  child: DayStrip(
                    days: days,
                    selectedDay: selectedDay,
                    onSelect: (d) => setState(() => selectedDay = d),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 18)),
              const SliverToBoxAdapter(child: CycleSummaryCard()),
              const SliverToBoxAdapter(child: SizedBox(height: 18)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.pageHPad),
                  child: Row(
                    children: [
                      Text(
                        "Günlük yazılarım • Bugün",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      TextButton(onPressed: () {}, child: const Text("Tümü")),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppSizes.pageHPad, 8, AppSizes.pageHPad, 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    QuickCard(
                      title: "Belirti kaydedin",
                      subtitle: "Bugün neler hissediyorsun?",
                      icon: Icons.add,
                      accent: const Color(0xFF20B2AA),
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    QuickCard(
                      title: "Bugün hamilelik olasılığı",
                      subtitle: "Günlük güncellemeyi gör",
                      icon: Icons.insights,
                      accent: AppColors.accent,
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    QuickCard(
                      title: "6 Şubat: Beklenen belirtiler",
                      subtitle: "İçgörü al",
                      icon: Icons.favorite,
                      accent: const Color(0xFF4A74FF),
                      onTap: () {},
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSizes.pageHPad, 8, AppSizes.pageHPad, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, color: Colors.grey.shade700),
          ),
          const Spacer(),
          Text("Şubat", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}
