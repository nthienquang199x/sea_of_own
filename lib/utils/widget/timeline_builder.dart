import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

abstract class TimelineStep {
  String get title;
  String get description;
}

class TimelineBuilder<T extends dynamic> extends StatelessWidget {
  const TimelineBuilder({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.itemBuilder,
    this.isDashed = false,
    this.isDashedBuilder,
    this.isBorderedBuilder,
  });

  final List<T> items;
  final int currentIndex;
  final Widget Function(T item, int index, bool isCurrent) itemBuilder;
  final bool isDashed;
  final bool Function(int index)? isDashedBuilder;
  final bool Function(int index)? isBorderedBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final isLast = index == items.length - 1;
        final isCurrent = index == currentIndex;
        final item = items[index];
        final isDashed = isDashedBuilder?.call(index) ?? false;
        final isBordered = isBorderedBuilder?.call(index) ?? false;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(double.infinity, double.infinity),
                      painter: TimelinePainter(
                        isDashed: isDashed,
                        drawTop: index != 0,
                        drawBottom: !isLast,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isBordered
                                ? Colors.transparent
                                : AppColor.base90,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: isCurrent
                              ? AppColor.base80
                              : isBordered
                                  ? const Color(0xFF353535)
                                  : Colors.transparent,
                          child: Text(
                            '${index + 1}',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: itemBuilder(item, index, isCurrent))
            ],
          ),
        );
      },
    );
  }
}

class TimelinePainter extends CustomPainter {
  final bool isDashed;
  final bool drawTop;
  final bool drawBottom;
  final Color color;

  TimelinePainter({
    required this.isDashed,
    required this.drawTop,
    required this.drawBottom,
    this.color = AppColor.base90,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    const avatarRadius = 14.0;
    const padding = 3.0;

    if (drawTop) {
      final endY = centerY - avatarRadius - padding;
      if (isDashed) {
        _drawDashedLine(canvas, centerX, 0, endY, paint);
      } else {
        canvas.drawLine(Offset(centerX, 0), Offset(centerX, endY), paint);
      }
    }

    if (drawBottom) {
      final startY = centerY + avatarRadius + padding;
      if (isDashed) {
        _drawDashedLine(canvas, centerX, startY, size.height, paint);
      } else {
        canvas.drawLine(
            Offset(centerX, startY), Offset(centerX, size.height), paint);
      }
    }
  }

  void _drawDashedLine(
      Canvas canvas, double x, double startY, double endY, Paint paint) {
    const dashHeight = 4;
    const dashSpace = 4;
    double y = startY;
    while (y < endY) {
      final nextY = y + dashHeight;
      canvas.drawLine(Offset(x, y), Offset(x, nextY.clamp(y, endY)), paint);
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
