import 'dart:math' as math;
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/material.dart';

class ModernSidebarIcon extends StatelessWidget {
  const ModernSidebarIcon({
    super.key,
    required this.pageLabel,
    this.selected = false,
    this.size = 24.0,
  });

  final PageLabel pageLabel;
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: CustomPaint(
          size: Size(size, size),
          painter: _ModernIconPainter(
            pageLabel: pageLabel,
            selected: selected,
            isDark: Theme.of(context).brightness == Brightness.dark,
          ),
        ),
      ),
    );
  }
}

class _ModernIconPainter extends CustomPainter {
  const _ModernIconPainter({
    required this.pageLabel,
    required this.selected,
    required this.isDark,
  });

  final PageLabel pageLabel;
  final bool selected;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    canvas.save();
    canvas.scale(s, s);

    final opacity = selected ? 1.0 : (isDark ? 0.65 : 0.6);

    switch (pageLabel) {
      case PageLabel.dashboard:
        _drawDashboard(canvas, opacity);
        break;
      case PageLabel.proxies:
        _drawProxies(canvas, opacity);
        break;
      case PageLabel.profiles:
        _drawProfiles(canvas, opacity);
        break;
      case PageLabel.connections:
        _drawConnections(canvas, opacity);
        break;
      case PageLabel.tools:
      case PageLabel.resources:
        _drawTools(canvas, opacity);
        break;
      case PageLabel.requests:
        _drawRequests(canvas, opacity);
        break;
      case PageLabel.dns:
        _drawDns(canvas, opacity);
        break;
      case PageLabel.logs:
        _drawLogs(canvas, opacity);
        break;
    }

    canvas.restore();
  }

  void _drawDashboard(Canvas canvas, double opacity) {
    // 4 rounded tiles with M3 harmonized colors
    // Top-left: Royal Blue
    final p1 = Paint()
      ..color = const Color(0xFF2563EB).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3.5, 3.5, 7.5, 7.5),
        const Radius.circular(2.5),
      ),
      p1,
    );

    // Top-right: Indigo / Violet
    final p2 = Paint()
      ..color = const Color(0xFF6366F1).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(13.0, 3.5, 7.5, 7.5),
        const Radius.circular(2.5),
      ),
      p2,
    );

    // Bottom-left: Emerald / Cyan
    final p3 = Paint()
      ..color = const Color(0xFF0D9488).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3.5, 13.0, 7.5, 7.5),
        const Radius.circular(2.5),
      ),
      p3,
    );

    // Bottom-right: Sky Blue / Cyan
    final p4 = Paint()
      ..color = const Color(0xFF0284C7).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(13.0, 13.0, 7.5, 7.5),
        const Radius.circular(2.5),
      ),
      p4,
    );
  }

  void _drawProxies(Canvas canvas, double opacity) {
    // Network / Globe with Emerald and Teal
    final strokePaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Outer globe circle
    canvas.drawCircle(const Offset(12, 12), 8.5, strokePaint);

    // Equator line
    final linePaint = Paint()
      ..color = const Color(0xFF06B6D4).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawLine(const Offset(3.5, 12), const Offset(20.5, 12), linePaint);

    // Longitude oval
    canvas.drawOval(
      const Rect.fromLTWH(7.8, 3.5, 8.4, 17.0),
      linePaint,
    );

    // Center active node
    final nodePaint = Paint()
      ..color = const Color(0xFF22D3EE).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(12, 12), 2.2, nodePaint);
  }

  void _drawProfiles(Canvas canvas, double opacity) {
    // Elegant document with folded corner and amber tag
    final docPaint = Paint()
      ..color = const Color(0xFF3B82F6).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(5.5, 3.5)
      ..lineTo(14.0, 3.5)
      ..lineTo(19.0, 8.5)
      ..lineTo(19.0, 20.5)
      ..lineTo(5.5, 20.5)
      ..close();
    canvas.drawPath(path, docPaint);

    // Folded corner
    final foldPath = Path()
      ..moveTo(14.0, 3.5)
      ..lineTo(14.0, 8.5)
      ..lineTo(19.0, 8.5);
    canvas.drawPath(foldPath, docPaint);

    // Config stripes inside (Warm Coral / Amber)
    final stripePaint = Paint()
      ..color = const Color(0xFFF59E0B).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(9.0, 13.0), const Offset(15.5, 13.0), stripePaint);

    final stripePaint2 = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(9.0, 16.5), const Offset(13.5, 16.5), stripePaint2);
  }

  void _drawConnections(Canvas canvas, double opacity) {
    // 3 connected network nodes
    final linePaint = Paint()
      ..color = const Color(0xFF818CF8).withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(12, 6), const Offset(6.5, 17.5), linePaint);
    canvas.drawLine(const Offset(12, 6), const Offset(17.5, 17.5), linePaint);

    // Top node (Violet)
    final node1 = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(12, 6), 3.0, node1);

    // Bottom left node (Indigo)
    final node2 = Paint()
      ..color = const Color(0xFF6366F1).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(6.5, 17.5), 2.8, node2);

    // Bottom right node (Cyan / Blue)
    final node3 = Paint()
      ..color = const Color(0xFF0EA5E9).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(17.5, 17.5), 2.8, node3);
  }

  void _drawTools(Canvas canvas, double opacity) {
    // Modern toolbox with Teal and Amber clasp
    final boxPaint = Paint()
      ..color = const Color(0xFF0F766E).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(4.0, 8.0, 16.0, 12.0),
        const Radius.circular(2.5),
      ),
      boxPaint,
    );

    // Handle (Teal)
    final handlePaint = Paint()
      ..color = const Color(0xFF14B8A6).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    final handlePath = Path()
      ..moveTo(8.5, 8.0)
      ..lineTo(8.5, 4.5)
      ..lineTo(15.5, 4.5)
      ..lineTo(15.5, 8.0);
    canvas.drawPath(handlePath, handlePaint);

    // Latch / clasp (Amber accent)
    final claspPaint = Paint()
      ..color = const Color(0xFFFBBF24).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(10.5, 10.0, 3.0, 4.0),
        const Radius.circular(1.0),
      ),
      claspPaint,
    );
  }

  void _drawRequests(Canvas canvas, double opacity) {
    final strokePaint = Paint()
      ..color = const Color(0xFF0284C7).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(const Offset(12, 12), 8.5, strokePaint);

    final needlePaint = Paint()
      ..color = const Color(0xFFF97316).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(12, 12), const Offset(12, 7.5), needlePaint);
    canvas.drawLine(const Offset(12, 12), const Offset(15.5, 14.0), needlePaint);
  }

  void _drawDns(Canvas canvas, double opacity) {
    final strokePaint = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: opacity)
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

  void _drawLogs(Canvas canvas, double opacity) {
    final framePaint = Paint()
      ..color = const Color(0xFF059669).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(4, 5, 16, 14),
        const Radius.circular(2.5),
      ),
      framePaint,
    );
    final promptPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(7, 9.5), const Offset(9, 11.5), promptPaint);
    canvas.drawLine(const Offset(9, 11.5), const Offset(7, 13.5), promptPaint);
    canvas.drawLine(const Offset(11, 13.5), const Offset(15, 13.5), promptPaint);
  }

  @override
  bool shouldRepaint(covariant _ModernIconPainter oldDelegate) {
    return oldDelegate.pageLabel != pageLabel ||
        oldDelegate.selected != selected ||
        oldDelegate.isDark != isDark;
  }
}
