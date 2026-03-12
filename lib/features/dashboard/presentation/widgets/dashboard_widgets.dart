import 'package:flutter/material.dart';

// Import ini disesuaikan dengan struktur folder proyek Anda
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/dashboard_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header Widget
/// Widget untuk header dashboard
/// Stat Card Widget
class StatCard extends StatelessWidget {
  final DashboardStats stats;
  final bool isSelected;
  final VoidCallback? onTap;

  const StatCard({
    Key? key,
    required this.stats,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      color: isSelected ? Colors.blue.withOpacity(0.1) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stats.title,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                stats.value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Row(
              //   children: [
              //     Icon(
              //       stats.isIncrease ? Icons.trending_up : Icons.trending_down,
              //       size: 12,
              //       color: stats.isIncrease ? Colors.green : Colors.red,
              //     ),
              //     const SizedBox(width: 2),
              //     Text(
              //       '${stats.percentage.toStringAsFixed(1)}%',
              //       style: TextStyle(
              //         fontSize: 9,
              //         color: stats.isIncrease ? Colors.green : Colors.red,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     const SizedBox(width: 2),
              //     Expanded(
              //       child: Text(
              //         stats.subtitle,
              //         style: const TextStyle(fontSize: 8, color: Colors.grey),
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHeader extends ConsumerWidget {
  final String userName;

  const DashboardHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.radiusLarge),
          bottomRight: Radius.circular(AppConstants.radiusLarge),
        ), // BorderRadius.only
      ), // BoxDecoration
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ), // TextStyle
                    ), // Text
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                  ],
                ), // Column
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ), // Icon
                ), // CircleAvatar
              ],
            ), // Row
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Data Mahasiswa D4TI',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ), // TextStyle
            ), // Text
          ],
        ), // Column
      ), // SafeArea
    ); // Container
  }
}

/// Modern Stat Card with Gradient and Glass Morphism
class ModernStatCard extends StatefulWidget {
  final DashboardStats stats;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isSelected;
  final VoidCallback? onTap;

  const ModernStatCard({
    Key? key,
    required this.stats,
    required this.icon,
    required this.gradientColors,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<ModernStatCard> createState() => _ModernStatCardState();
}

class _ModernStatCardState extends State<ModernStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    ); // AnimationController
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradientColors,
            ), // LinearGradient
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(0.3),
                blurRadius: widget.isSelected ? 20 : 12,
                offset: Offset(0, widget.isSelected ? 8 : 4),
              ), // BoxShadow
            ],
          ), // BoxDecoration
          child: Stack(
            children: [
              // Background decoration circles
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ), // BoxDecoration
                ), // Container
              ), // Positioned
              Positioned(
                left: -10,
                bottom: -10,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ), // BoxDecoration
                ), // Container
              ), // Positioned
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ), // BoxDecoration
                      child: Icon(widget.icon, color: Colors.white, size: 24),
                    ), // Container
                    const Spacer(),

                    // Value
                    Text(
                      widget.stats.value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ), // TextStyle
                    ), // Text
                    const SizedBox(height: 4),

                    // Title
                    Text(
                      widget.stats.title,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ), // TextStyle
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                  ],
                ), // Column
              ), // Padding
            ],
          ), // Stack
        ), // Container
      ), // ScaleTransition
    ); // GestureDetector
  }
}
