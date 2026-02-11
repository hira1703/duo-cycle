import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/day_strip.dart';
import '../widgets/cycle_summary_card.dart';

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
              // ÜST BAR
              SliverToBoxAdapter(child: _TopBar(theme: theme)),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // GÜN SEÇİCİ
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.pageHPad),
                  child: DayStrip(
                    days: days,
                    selectedDay: selectedDay,
                    onSelect: (d) => setState(() => selectedDay = d),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 18)),

              // CYCLE ÖZET KARTI (eski daireli kart)
              const SliverToBoxAdapter(child: CycleSummaryCard()),

              const SliverToBoxAdapter(child: SizedBox(height: 18)),

              // HIZLI KAYIT BAŞLIĞI
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.pageHPad),
                  child: Row(
                    children: [
                      Text(
                        "Hızlı kayıt",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Bugün",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.55),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),

              // HIZLI KAYIT AKSİYONLARI
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                    AppSizes.pageHPad, 0, AppSizes.pageHPad, 24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _ActionTile(
                        title: "Mood ekle",
                        subtitle: "Bugünkü ruh halini seç",
                        icon: Icons.emoji_emotions_outlined,
                        accent: const Color(0xFF6C63FF),
                        onTap: () {
                          // TODO: Mood ekleme sayfasına git
                        },
                      ),
                      const SizedBox(height: 12),
                      _ActionTile(
                        title: "Belirti ekle",
                        subtitle: "Semptomları kaydet",
                        icon: Icons.healing_outlined,
                        accent: const Color(0xFF20B2AA),
                        onTap: () {
                          // TODO: Belirti ekleme sayfasına git
                        },
                      ),
                      const SizedBox(height: 12),
                      _ActionTile(
                        title: "Regl günü işaretle",
                        subtitle: "Başlangıç/bitiş günü gir",
                        icon: Icons.water_drop_outlined,
                        accent: AppColors.accent,
                        onTap: () {
                          // TODO: Regl giriş modalı aç
                        },
                      ),
                    ],
                  ),
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
      padding: const EdgeInsets.fromLTRB(
          AppSizes.pageHPad, 8, AppSizes.pageHPad, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, color: Colors.grey.shade700),
          ),
          const Spacer(),
          Text(
            "Şubat",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
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

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.35)),
          ],
        ),
      ),
    );
  }
}
