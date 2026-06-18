import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        leading: IconButton(
          icon: Icon(Icons.close, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AboutHeader(cs: cs),
            const SizedBox(height: 24),
            _AboutSection(
              title: 'Who We Are',
              content:
                  'Cinema App helps movie lovers discover films, pick showtimes, '
                  'and book seats in a smooth and modern experience.',
              cs: cs,
            ),
            const SizedBox(height: 16),
            _AboutSection(
              title: 'What We Focus On',
              content:
                  'We focus on reliable showtime data, easy seat selection, '
                  'and a clean interface that feels fast and simple.',
              cs: cs,
            ),
            const SizedBox(height: 16),
            _AboutSection(
              title: 'Version',
              content: 'Cinema App v1.0.0',
              cs: cs,
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  final ColorScheme cs;

  const _AboutHeader({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: cs.primary,
            child: Icon(Icons.movie_filter_rounded, color: cs.onPrimary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Cinema App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final String content;
  final ColorScheme cs;

  const _AboutSection({
    required this.title,
    required this.content,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
