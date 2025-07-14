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

  @override
  void initState() {
    cubit.init();
    _controller = AnimationController(vsync: this);
    super.initState();
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomCircleAvatar(
                isEditEnabled: false,
                avatarSize: 120,
                imageUrl: "assets/images/img_profile.png",
              ),
              Text(
                "User Name",
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "emailaddress@domain.com",
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
                    showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
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
                    showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
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
                    showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
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
                    showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => buildDialogDeleteAccount(),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 16),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.privacyPolicy.title,
                  onTap: () => showBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const PrivacyPolicyCookies(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: context.myTheme.colorScheme.separator1,
                    height: 1,
                  ),
                ),
                _buildSettingItem(
                  SettingsType.termsOfService.title,
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 16),
              _buildGroup([
                _buildSettingItem(
                  SettingsType.sendUsYourFeedback.title,
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => buildDialogSendFeedback(),
                    );
                  },
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Text(
                "App version 1.0.0",
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
      padding: const EdgeInsets.all(24),
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
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
      ),
    );
  }

  Widget buildDialogSendFeedback() {
    return CustomBottomSheet(
        title: AppLocale.send_us_your_feedback,
        titleButton: AppLocale.send_feedback,
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
              controller: TextEditingController(),
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
        child: Column(
          children: [
            TextFormFieldCustom(
              hintText: "Maximus Meridias",
              borderColor: Colors.transparent,
              fillColor: context.myTheme.colorScheme.background,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            TextFormFieldCustom(
              hintText: "emailaddress@domain.com",
              borderColor: Colors.transparent,
              fillColor: context.myTheme.colorScheme.background,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
            ),
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
        showBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
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
            TextFormFieldCustom(
              hintText: AppLocale.please_explain_a_little_more.tr(context),
              borderColor: context.myTheme.colorScheme.mutedForeground,
              fillColor: context.myTheme.colorScheme.background,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
