import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/primary_button.dart';

/// Home ekranındaki orta kart: döngü özet alanı
/// - Daire tasarımını kaldırır
/// - Gradient kart + chip + büyük sayı + CTA butonu verir
class CycleSummaryCard extends StatelessWidget {
  const CycleSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Demo değerler (sonra gerçek hesaplamaya bağlarız)
    const daysLeft = 0;
    const statusText = "Hamile kalma olasılığı düşük";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pageHPad),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          // Arka plan gradient (kartın karakteri)
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFA2BD),
              Color(0xFFFF6B9A),
              Color(0xFFFFD6E3),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 26,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // 1) Ön plan için yumuşak “wave” efekti (özgün görünüm)
              Positioned.fill(
                child: CustomPaint(
                  painter: _WavePainter(),
                ),
              ),

              // 2) İçerik
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Üst satır: boşluk + chip
                    Row(
                      children: [
                        const Spacer(),
                        _StatusChip(text: statusText),
                      ],
                    ),

                    const Spacer(),

                    // Büyük sayı + “gün”
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$daysLeft",
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2B1B2A),
                            height: 0.95,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "gün",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2B1B2A),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // CTA: Regl gir
                    SizedBox(
                      width: 140,
                      child: PrimaryButton(
                        label: "Regl gir",
                        height: 40,
                        onPressed: () {
                          // TODO: regl giriş modalı açılacak
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sağ üstteki durum chip'i
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF51D7B6), // mint/yeşil
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Kartın içindeki beyaz dalga formu
/// Referanstan uzaklaştırıp özgün “soft” bir tasarım verir.
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.78)
      ..style = PaintingStyle.fill;

    final path = Path();
    // Sol üstten başlayıp kavisle sağa ilerleyen bir “wave”
    path.moveTo(0, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.18,
      size.width,
      size.height * 0.42,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Alt tarafta ikinci, çok hafif bir katman (derinlik)
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.58);
    path2.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.72,
      size.width,
      size.height * 0.55,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
