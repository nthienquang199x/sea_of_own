import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

void showDataCookiesDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Dialog(
        backgroundColor: context.myTheme.colorScheme.muted,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              constraints: const BoxConstraints(
                maxHeight: 700,
              ),
              decoration: BoxDecoration(
                color: context.myTheme.colorScheme.muted,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data & Cookies',
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: context.myTheme.colorScheme.mutedForeground,
                        )),
                    const SizedBox(height: 8),
                    Text('Last updated: June 29, 2025',
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.myTheme.colorScheme.mutedForeground,
                        )),
                    const SizedBox(height: 16),
                    Text(
                        'We use minimal data collection to make SeaOfOwn work better for you.',
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.myTheme.colorScheme.mutedForeground,
                        )),
                    const SizedBox(height: 24),
                    _buildSectionTitle('What we track?', context),
                    _buildSubSection(
                        'Essential Functions',
                        [
                          'Login sessions and account authentication',
                          'Recently viewed products',
                          'Saved lists and product interactions',
                          'App crashes and performance issues',
                        ],
                        context),
                    _buildSubSection(
                        'Improving Your Experience',
                        [
                          'Search queries to improve results',
                          'Popular products and categories',
                          'User interface interactions to optimize design',
                        ],
                        context),
                    _buildSectionTitle('Cookies We Use', context),
                    _buildSubSection(
                        'Required Cookies',
                        [
                          'Authentication (keeps you logged in)',
                          'Session management (remembers your preferences)',
                          'Security (prevents unauthorized access)',
                        ],
                        context),
                    _buildSubSection(
                        'Analytics Cookies',
                        [
                          'App usage patterns (anonymized)',
                          'Feature popularity (helps us improve)',
                          'Performance monitoring (loading times, errors)',
                        ],
                        context),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -40,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildSectionTitle(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      text,
      style: context.myTheme.textThemeT1.title.copyWith(
        fontWeight: FontWeight.w500,
        color: context.myTheme.colorScheme.mutedForeground,
      ),
    ),
  );
}

Widget _buildSubSection(
    String title, List<String> items, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 6),
      ...items.map((e) => Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(color: Colors.grey)),
                Expanded(
                  child: Text(
                    e,
                    style: context.myTheme.textThemeT1.title.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.myTheme.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          )),
      const SizedBox(height: 12),
    ],
  );
}
