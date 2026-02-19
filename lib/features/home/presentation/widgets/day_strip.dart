import 'package:flutter/material.dart';

class DayStrip extends StatefulWidget {
  const DayStrip({
    super.key,
    required this.daysInMonth,
    required this.selectedDay,
    required this.onSelect,
    this.initialScrollDay, // ekranda açılınca hangi güne odaklansın
    this.todayDay,

  });

  final int daysInMonth;
  final int selectedDay;
  final ValueChanged<int> onSelect;
  final int? initialScrollDay;
  final int? todayDay;


  @override
  State<DayStrip> createState() => _DayStripState();
}

class _DayStripState extends State<DayStrip> {
  late final ScrollController _controller;

  static const _itemWidth = 46.0;
  static const _gap = 10.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    // İlk açılışta bugüne (veya initialScrollDay'e) kaydır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetDay = (widget.initialScrollDay ?? widget.selectedDay).clamp(1, widget.daysInMonth);
      final offset = (targetDay - 1) * (_itemWidth + _gap);
      if (_controller.hasClients) {
        _controller.jumpTo(offset);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DayStrip oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Ay değiştiğinde veya initial scroll değiştiğinde yeniden odaklanmak istersen:
    // (Şimdilik dokunmuyoruz; gerekirse ekleriz.)
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 56,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.daysInMonth,
        separatorBuilder: (_, __) => const SizedBox(width: _gap),
        itemBuilder: (context, i) {
          final day = i + 1;
          final isSelected = day == widget.selectedDay;
          final isToday = widget.todayDay != null && day == widget.todayDay;
          final showDashed = isToday && !isSelected;

          return GestureDetector(
            onTap: () => widget.onSelect(day),
            child: SizedBox(
              width: _itemWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ✅ Bugünse ve seçili değilse kesikli halka
                  if (showDashed)
                    CustomPaint(
                      size: const Size(_itemWidth, _itemWidth),
                      painter: _DashedCirclePainter(
                        color: accent,
                        strokeWidth: 2,
                        dashLength: 5,
                        gapLength: 3,
                      ),
                    ),

                  // Gün balonu
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _itemWidth,
                    height: _itemWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : accent,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        )
                      ]
                          : null,
                    ),
                    child: Text(
                      "$day",
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

    // Çember çevresi
    final circumference = 2 * 3.141592653589793 * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    double startAngle = -3.141592653589793 / 2; // üstten başlasın
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

