import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyCookies extends StatefulWidget {
  const PrivacyPolicyCookies({super.key});

  @override
  State<PrivacyPolicyCookies> createState() => _PrivacyPolicyCookiesState();
}

class _PrivacyPolicyCookiesState extends State<PrivacyPolicyCookies> {
  ScrollController scrollController = ScrollController();
  double maxHeightFactor = 0.6;
  bool hasExpanded = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!scrollController.position.atEdge && !hasExpanded) {
        setState(() {
          hasExpanded = true;
          maxHeightFactor = 0.8;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            padding: const EdgeInsets.all(24),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * maxHeightFactor,
            ),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.muted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data & Cookies',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: context.myTheme.colorScheme.foreground,
                            )),
                        const SizedBox(height: 8),
                        Text('Last updated: June 29, 2025',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.myTheme.colorScheme.foreground,
                            )),
                        const SizedBox(height: 16),
                        Text(
                            'We use minimal data collection to make SeaOfOwn work better for you.',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.myTheme.colorScheme.foreground,
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
              ],
            ),
          ),
          Positioned(
            top: -50,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16),
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
  }
}

Widget _buildSectionTitle(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      text,
      style: context.myTheme.textThemeT1.title.copyWith(
        fontWeight: FontWeight.w500,
        color: context.myTheme.colorScheme.foreground,
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
        style: context.myTheme.textThemeT1.title.copyWith(
          fontWeight: FontWeight.w500,
          color: context.myTheme.colorScheme.foreground,
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
                      color: context.myTheme.colorScheme.foreground,
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
