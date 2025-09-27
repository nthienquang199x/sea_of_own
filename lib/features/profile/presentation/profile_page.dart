import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/profile/components/custom_bottom_sheet.dart';
import 'package:app_base/features/profile/components/custom_circle_avatar.dart';
import 'package:app_base/features/profile/components/custom_dialog.dart';
import 'package:app_base/features/profile/components/privacy_policy.dart';
import 'package:app_base/features/profile/models/app_theme.dart';
import 'package:app_base/features/profile/models/feedback_reason.dart';
import 'package:app_base/features/profile/models/settings_type.dart';
import 'package:app_base/features/profile/presentation/profile_cubit.dart';
import 'package:app_base/features/profile/presentation/profile_state.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_radio_group.dart';
import 'package:app_base/utils/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState
    extends BaseState<ProfileState, ProfileCubit, ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool? isVisibleOldPassword = false;
  bool? isVisibleNewPassword = false;
  String appVersion = '1.0.0';

  @override
  void initState() {
    cubit.init();
    _controller = AnimationController(vsync: this);
    _getAppVersion();
    super.initState();
  }

  Future<void> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          appVersion = packageInfo.version;
        });
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, ProfileState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 53),
              CustomCircleAvatar(
                isEditEnabled: false,
                avatarSize: 120,
                imageUrl: state.user?.avatarUrl,
              ),
              const SizedBox(height: 12),
              Text(
                state.user?.name ?? "",
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.user?.email ?? "",
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 40),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.editProfile.title,
                  onTap: () {
                    cubit.nameEditingController.text =
                        cubit.state.user?.name ?? "";
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => buildDialogEditProfile(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: context.myTheme.colorScheme.separator1,
                    height: 1,
                  ),
                ),
                _buildSettingItem(
                  SettingsType.theme.title,
                  subtitle: state.selectedTheme.name,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => buildDialogAppTheme(),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 16),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.logout.title,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => buildDialogLogout(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: context.myTheme.colorScheme.separator1,
                    height: 1,
                  ),
                ),
                _buildSettingItem(
                  SettingsType.deleteAccount.title,
                  textColor: context.myTheme.colorScheme.destructive,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => buildDialogDeleteAccount(),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 16),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.privacyPolicy.title,
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const PrivacyPolicyCookies(),
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.sendUsYourFeedback.title,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => buildDialogSendFeedback(),
                    );
                  },
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Text(
                "App version $appVersion",
                style: context.myTheme.textThemeT1.body.copyWith(
                  color: context.myTheme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingItem(
    String title, {
    String? subtitle,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr(context),
            style: context.myTheme.textThemeT1.title.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? context.myTheme.colorScheme.foreground,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle.tr(context),
              style: context.myTheme.textThemeT1.body.copyWith(
                color: context.myTheme.colorScheme.mutedForeground,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildDialogSendFeedback() {
    return CustomBottomSheet(
        title: AppLocale.send_us_your_feedback,
        titleButton: AppLocale.send_feedback,
        onTap: () => {
              cubit.sendFeedbackEmail(
                  body: cubit.feedbackEditingController.text, context: context)
              //     .then((success) {
              //   if (success && mounted) {
              //     Navigator.pop(context);
              //     showToast(AppLocale.send_feedback_successfully.tr(context));
              //   } else if (mounted) {
              //     showToast(
              //       AppLocale.send_feedback_failed.tr(context),
              //     );
              //   }
              // })
            },
        child: Column(
          children: [
            Text(
              AppLocale.send_us_your_feedback_description.tr(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                fontWeight: FontWeight.w500,
                color: context.myTheme.colorScheme.foreground,
              ),
            ),
            const SizedBox(height: 24),
            TextFormFieldCustom(
              hintText: AppLocale.write_to_us.tr(context),
              borderColor: Colors.transparent,
              fillColor: context.myTheme.colorScheme.background,
              controller: cubit.feedbackEditingController,
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
              maxlines: 5,
            ),
          ],
        ));
  }

  Widget buildDialogChangePassword() {
    return CustomDialog(
        title: AppLocale.edit_profile,
        titleButton: AppLocale.save_changes,
        child: Column(
          children: [
            TextFormFieldCustom(
              hintText: AppLocale.old_password.tr(context),
              borderColor: Colors.transparent,
              fillColor: context.myTheme.colorScheme.background,
              controller: TextEditingController(),
              obscureText: !isVisibleOldPassword!,
              keyboardType: TextInputType.visiblePassword,
              borderRadius: BorderRadius.circular(8),
              suffix: Icon(
                isVisibleOldPassword! ? Icons.visibility : Icons.visibility_off,
                color: context.myTheme.colorScheme.primaryForeground,
              ),
            ),
            const SizedBox(height: 8),
            TextFormFieldCustom(
                hintText: AppLocale.new_password.tr(context),
                borderColor: Colors.transparent,
                fillColor: context.myTheme.colorScheme.background,
                controller: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                borderRadius: BorderRadius.circular(8),
                obscureText: !isVisibleNewPassword!,
                suffix: Icon(
                  isVisibleNewPassword!
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: context.myTheme.colorScheme.primaryForeground,
                )),
          ],
        ));
  }

  Widget buildDialogEditProfile() {
    return CustomBottomSheet(
        title: AppLocale.edit_profile,
        titleButton: AppLocale.save_changes,
        onTap: () {
          cubit.updateProfile(cubit.nameEditingController.text).then((success) {
            if (success && mounted) {
              Navigator.pop(context);
            }
          });
        },
        child: Column(
          children: [
            TextFormFieldCustom(
              hintText: "Maximus Meridias",
              borderColor: Colors.transparent,
              fillColor: context.myTheme.colorScheme.background,
              controller: cubit.nameEditingController,
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
            ),
            // const SizedBox(height: 8),
            // TextFormFieldCustom(
            //   hintText: "emailaddress@domain.com",
            //   borderColor: Colors.transparent,
            //   fillColor: context.myTheme.colorScheme.background,
            //   controller: TextEditingController(),
            //   keyboardType: TextInputType.text,
            //   borderRadius: BorderRadius.circular(8),
            // ),
          ],
        ));
  }

  Widget buildDialogAppTheme() {
    AppTheme? tempSelectedTheme = state.selectedTheme;

    return StatefulBuilder(
      builder: (context, setDialogState) => CustomBottomSheet(
        title: AppLocale.app_theme,
        titleButton: AppLocale.save_changes,
        onTap: () {
          cubit.onSavedTheme(tempSelectedTheme!);
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.myTheme.colorScheme.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomRadioGroup<AppTheme>(
            selected: tempSelectedTheme,
            options: AppTheme.values,
            itemLabelBuilder: (option) => option.name.tr(context),
            onChanged: (value) {
              setDialogState(() {
                tempSelectedTheme = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildDialogDeleteAccount() {
    return CustomBottomSheet(
      title: AppLocale.delete_account,
      titleButton: AppLocale.delete_account,
      textColor: context.myTheme.colorScheme.destructive,
      onTap: () {
        Navigator.of(context).pop();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => buildDialogFeedbackReason(),
        );
      },
      child: Text(
        AppLocale.delete_account_description.tr(context),
        style: context.myTheme.textThemeT1.title.copyWith(
          fontWeight: FontWeight.w500,
          color: context.myTheme.colorScheme.foreground,
        ),
      ),
    );
  }

  Widget buildDialogLogout() {
    return CustomBottomSheet(
      title: AppLocale.logout,
      titleButton: AppLocale.logout,
      onTap: () => cubit.logout(),
      child: Text(
        AppLocale.logout_description.tr(context),
        style: context.myTheme.textThemeT1.title.copyWith(
          fontWeight: FontWeight.w500,
          color: context.myTheme.colorScheme.foreground,
        ),
      ),
    );
  }

  Widget buildDialogFeedbackReason() {
    return CustomBottomSheet(
      title: AppLocale.tell_us_why_you_decided_to_leave,
      titleButton: AppLocale.confirm_delete,
      textColor: context.myTheme.colorScheme.destructive,
      onTap: () {
        cubit.deleteAccount().then((value) {
          if (value && mounted) {
            showToast(AppLocale.delete_account_successfully.tr(context));
            cubit.logout();
          } else if (mounted) {
            Navigator.of(context).pop();
            showToast(AppLocale.delete_account_failed.tr(context));
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: context.myTheme.colorScheme.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CustomRadioGroup<FeedbackReason>(
              selected: FeedbackReason.other,
              options: FeedbackReason.values,
              onChanged: (value) {},
              itemLabelBuilder: (option) => option.title.tr(context),
            ),
            const SizedBox(height: 4),
            TextFormFieldCustom(
              hintText: AppLocale.please_explain_a_little_more.tr(context),
              borderColor: context.myTheme.colorScheme.mutedForeground,
              fillColor: context.myTheme.colorScheme.background,
              controller: cubit.textEditingController,
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
