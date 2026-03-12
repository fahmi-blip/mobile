import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/profile/data/models/profile_model.dart';

class ModernProfileCard extends StatelessWidget {
  final ProfileModel profile;

  const ModernProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor.withOpacity(0.7),
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, gradientColors[0].withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: gradientColors[0].withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  profile.nama.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              profile.nama,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(profile.role, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 20),
            _infoRow(Icons.badge_outlined, 'ID: ${profile.id}'),
            const SizedBox(height: 10),
            _infoRow(Icons.email_outlined, profile.email),
            const SizedBox(height: 10),
            _infoRow(Icons.school_outlined, profile.prodi),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
