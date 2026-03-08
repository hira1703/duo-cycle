import 'package:flutter/material.dart';

class DayStrip extends StatefulWidget {
  const DayStrip({
    super.key,
    required this.selectedDate,
    required this.onSelect,
    this.todayDate,
    this.baseColor,
    this.onVisibleDateChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelect;
  final DateTime? todayDate;
  final Color? baseColor;
  /// Scroll sırasında görünürdeki/merkezdeki tarihi dışarı bildirir
  final ValueChanged<DateTime>? onVisibleDateChanged;

  @override
  State<DayStrip> createState() => _DayStripState();
}

class _DayStripState extends State<DayStrip> {
  late final ScrollController _controller;

  static const _itemWidth = 46.0;
  static const _gap = 10.0;
  static final DateTime _now = DateTime.now();
  static final DateTime _rangeStart = DateTime(_now.year - 1, 1, 1);
  static final DateTime _rangeEnd = DateTime(_now.year + 1, 12, 31);

  static final int _itemCount = _daysBetween(_rangeStart, _rangeEnd) + 1;
  bool _didInitialJump = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_handleScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToDate(widget.selectedDate);
      _didInitialJump = true;
    });
  }

  @override
  void didUpdateWidget(covariant DayStrip oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Kullanıcı gün seçtiğinde listeyi yeniden zıplatma
    // sadece ilk açılışta otomatik konumlandırma yapıyoruz
    if (!_didInitialJump) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _jumpToDate(widget.selectedDate);
        _didInitialJump = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  /// Scroll sırasında ekranda merkeze en yakın tarihi bulup parent'a bildirir
  void _handleScroll() {
    if (!_controller.hasClients || widget.onVisibleDateChanged == null) return;

    // Ekranda merkeze yakın item index'i
    final centerOffset = _controller.offset + 120;
    final rawIndex = (centerOffset / (_itemWidth + _gap)).round();
    final clampedIndex = rawIndex.clamp(0, _itemCount - 1);

    final visibleDate = _addDays(_rangeStart, clampedIndex);
    widget.onVisibleDateChanged!(visibleDate);
  }

  static int _daysBetween(DateTime from, DateTime to) {
    final fromUtc = DateTime.utc(from.year, from.month, from.day);
    final toUtc = DateTime.utc(to.year, to.month, to.day);
    return toUtc.difference(fromUtc).inDays;
  }

  static DateTime _addDays(DateTime date, int days) {
    final utc = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).add(Duration(days: days));
    return DateTime(utc.year, utc.month, utc.day);
  }

  static bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _jumpToDate(DateTime date) {
    if (!_controller.hasClients) return;

    final rawIndex = _daysBetween(_rangeStart, date);
    final clampedIndex = rawIndex.clamp(0, _itemCount - 1) as int;
    final targetOffset = clampedIndex * (_itemWidth + _gap);
    final maxOffset = _controller.position.maxScrollExtent;
    _controller.jumpTo(targetOffset.clamp(0.0, maxOffset).toDouble());
  }

  Color _monthColor(Color base, int month) {
    final alternate = Color.alphaBlend(Colors.white.withOpacity(0.16), base);
    return month.isOdd ? base : alternate;
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.baseColor ?? Theme.of(context).colorScheme.primary;
    final today = widget.todayDate ?? DateTime.now();

    return SizedBox(
      height: 56,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: _itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: _gap),
        itemBuilder: (context, i) {
          final date = _addDays(_rangeStart, i);
          final isSelected = _isSameDate(date, widget.selectedDate);
          final isToday = _isSameDate(date, today);
          final showDashed = isToday && !isSelected;
          final dayColor = _monthColor(base, date.month);

          return GestureDetector(
            onTap: () => widget.onSelect(date),
            child: SizedBox(
              width: _itemWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (showDashed)
                    CustomPaint(
                      size: const Size(_itemWidth, _itemWidth),
                      painter: _DashedCirclePainter(
                        color: dayColor,
                        strokeWidth: 2,
                        dashLength: 5,
                        gapLength: 3,
                      ),
                    ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _itemWidth,
                    height: _itemWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : dayColor,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final radius = (size.width / 2) - strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * 3.141592653589793 * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    double startAngle = -3.141592653589793 / 2;
    final sweepPerDash = (dashLength / circumference) * 2 * 3.141592653589793;
    final sweepPerGap = (gapLength / circumference) * 2 * 3.141592653589793;

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepPerDash,
        false,
        paint,
      );
      startAngle += sweepPerDash + sweepPerGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
