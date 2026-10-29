import 'dart:math' as math;
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/material.dart';

class ModernSidebarIcon extends StatelessWidget {
  const ModernSidebarIcon({
    super.key,
    required this.pageLabel,
    this.selected = false,
    this.size = 26.0,
  });

  final PageLabel pageLabel;
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // When selected: unified theme primary color
    // When unselected: monochrome / neutral grey (onSurfaceVariant)
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.72);
    final iconColor = selected ? activeColor : inactiveColor;
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: CustomPaint(
          size: Size(size, size),
          painter: _ThemedIconPainter(
            pageLabel: pageLabel,
            selected: selected,
            color: iconColor,
            isDark: isDark,
          ),
        ),
      ),
    );
  }
}

class _ThemedIconPainter extends CustomPainter {
  const _ThemedIconPainter({
    required this.pageLabel,
    required this.selected,
    required this.color,
    required this.isDark,
  });

  final PageLabel pageLabel;
  final bool selected;
  final Color color;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    canvas.save();
    canvas.scale(s, s);

    switch (pageLabel) {
      case PageLabel.dashboard:
        _drawDashboard(canvas);
        break;
      case PageLabel.proxies:
        _drawProxies(canvas);
        break;
      case PageLabel.profiles:
        _drawProfiles(canvas);
        break;
      case PageLabel.connections:
        _drawConnections(canvas);
        break;
      case PageLabel.tools:
      case PageLabel.resources:
        _drawTools(canvas);
        break;
      case PageLabel.requests:
        _drawRequests(canvas);
        break;
      case PageLabel.dns:
        _drawDns(canvas);
        break;
      case PageLabel.logs:
        _drawLogs(canvas);
        break;
    }

    canvas.restore();
  }

  void _drawDashboard(Canvas canvas) {
    // 2x2 rounded squares
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final fillPaint = Paint()
      ..color = selected ? color : color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Tile 1: Top-Left
    final r1 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(3.5, 3.5, 7.5, 7.5),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(r1, fillPaint);
    if (!selected) canvas.drawRRect(r1, strokePaint);

    // Tile 2: Top-Right
    final r2 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(13.0, 3.5, 7.5, 7.5),
      const Radius.circular(2.5),
    );
    if (selected) {
      canvas.drawRRect(
        r2,
        Paint()
          ..color = color.withValues(alpha: 0.75)
          ..style = PaintingStyle.fill,
      );
    } else {
      canvas.drawRRect(r2, strokePaint);
    }

    // Tile 3: Bottom-Left
    final r3 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(3.5, 13.0, 7.5, 7.5),
      const Radius.circular(2.5),
    );
    if (selected) {
      canvas.drawRRect(
        r3,
        Paint()
          ..color = color.withValues(alpha: 0.75)
          ..style = PaintingStyle.fill,
      );
    } else {
      canvas.drawRRect(r3, strokePaint);
    }

    // Tile 4: Bottom-Right
    final r4 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(13.0, 13.0, 7.5, 7.5),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(r4, fillPaint);
    if (!selected) canvas.drawRRect(r4, strokePaint);
  }

  void _drawProxies(Canvas canvas) {
    // Elegant globe
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    // Outer globe
    canvas.drawCircle(const Offset(12, 12), 8.5, strokePaint);

    // Equator line
    final linePaint = Paint()
      ..color = selected ? color.withValues(alpha: 0.85) : color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(3.8, 12), const Offset(20.2, 12), linePaint);

    // Meridian ellipse
    canvas.drawOval(
      const Rect.fromLTWH(7.8, 3.5, 8.4, 17.0),
      linePaint,
    );

    // Center connection node
    final centerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(12, 12), selected ? 2.4 : 1.8, centerPaint);
  }

  void _drawProfiles(Canvas canvas) {
    // Clean folded document
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final docPath = Path()
      ..moveTo(5.5, 3.5)
      ..lineTo(14.0, 3.5)
      ..lineTo(19.0, 8.5)
      ..lineTo(19.0, 20.5)
      ..lineTo(5.5, 20.5)
      ..close();

    if (selected) {
      canvas.drawPath(
        docPath,
        Paint()
          ..color = color.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill,
      );
    }
    canvas.drawPath(docPath, strokePaint);

    // Folded corner
    final foldPath = Path()
      ..moveTo(14.0, 3.5)
      ..lineTo(14.0, 8.5)
      ..lineTo(19.0, 8.5);
    canvas.drawPath(foldPath, strokePaint);

    // Config stripes
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(9.0, 13.0), const Offset(15.5, 13.0), linePaint);
    canvas.drawLine(
      const Offset(9.0, 16.5),
      const Offset(13.5, 16.5),
      Paint()
        ..color = color.withValues(alpha: 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawConnections(Canvas canvas) {
    // 3 network nodes
    final linePaint = Paint()
      ..color = selected ? color.withValues(alpha: 0.75) : color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(12, 6.0), const Offset(6.5, 17.5), linePaint);
    canvas.drawLine(const Offset(12, 6.0), const Offset(17.5, 17.5), linePaint);

    final nodePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Top node
    canvas.drawCircle(const Offset(12, 6.0), selected ? 3.0 : 2.5, nodePaint);
    // Left node
    canvas.drawCircle(const Offset(6.5, 17.5), selected ? 2.8 : 2.3, nodePaint);
    // Right node
    canvas.drawCircle(const Offset(17.5, 17.5), selected ? 2.8 : 2.3, nodePaint);
  }

  void _drawTools(Canvas canvas) {
    // Modern toolbox
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final boxRRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(4.0, 8.0, 16.0, 12.0),
      const Radius.circular(2.5),
    );

    if (selected) {
      canvas.drawRRect(
        boxRRect,
        Paint()
          ..color = color.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill,
      );
    }
    canvas.drawRRect(boxRRect, strokePaint);

    // Handle
    final handlePath = Path()
      ..moveTo(8.5, 8.0)
      ..lineTo(8.5, 4.5)
      ..lineTo(15.5, 4.5)
      ..lineTo(15.5, 8.0);
    canvas.drawPath(handlePath, strokePaint);

    // Center latch
    final claspRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(10.5, 10.0, 3.0, 4.0),
      const Radius.circular(1.0),
    );
    canvas.drawRRect(
      claspRect,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  void _drawRequests(Canvas canvas) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(const Offset(12, 12), 8.5, strokePaint);
    canvas.drawLine(const Offset(12, 12), const Offset(12, 7.5), strokePaint);
    canvas.drawLine(const Offset(12, 12), const Offset(15.5, 14.0), strokePaint);
  }

  void _drawDns(Canvas canvas) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(12, 4)
      ..lineTo(18, 6.5)
      ..lineTo(18, 12)
      ..cubicTo(18, 16.5, 15.5, 19.5, 12, 20.5)
      ..cubicTo(8.5, 19.5, 6, 16.5, 6, 12)
      ..lineTo(6, 6.5)
      ..close();
    canvas.drawPath(path, strokePaint);
  }

  void _drawLogs(Canvas canvas) {
    final framePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(4, 5, 16, 14),
        const Radius.circular(2.5),
      ),
      framePaint,
    );
    canvas.drawLine(const Offset(7, 9.5), const Offset(9, 11.5), framePaint);
    canvas.drawLine(const Offset(9, 11.5), const Offset(7, 13.5), framePaint);
    canvas.drawLine(const Offset(11, 13.5), const Offset(15, 13.5), framePaint);
  }

  @override
  bool shouldRepaint(covariant _ThemedIconPainter oldDelegate) {
    return oldDelegate.pageLabel != pageLabel ||
        oldDelegate.selected != selected ||
        oldDelegate.color != color ||
        oldDelegate.isDark != isDark;
  }
}
