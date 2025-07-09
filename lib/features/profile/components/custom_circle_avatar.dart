import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/app/theme/icons.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    this.onEditTap,
    this.imageUrl,
    this.avatarSize = 58,
    required this.isEditEnabled,
  });

  final VoidCallback? onEditTap;
  final String? imageUrl;
  final bool isEditEnabled;
  final double avatarSize;

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty || url == '') return false;
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final isHttpScheme = uri.scheme == 'http' || uri.scheme == 'https';
    return isHttpScheme && uri.hasAbsolutePath;
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _isValidImageUrl(imageUrl);
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: avatarSize / 2,
          backgroundColor: AppColor.base30,
          child: ClipOval(
            child: isValid
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    width: avatarSize,
                    height: avatarSize,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.account_circle_outlined,
                        size: avatarSize,
                        color: AppColor.base90,
                      );
                    },
                  )
                : Image.asset(
                    AppImages.img_avatar,
                    fit: BoxFit.cover,
                    width: avatarSize,
                    height: avatarSize,
                  ),
          ),
        ),
        if (isEditEnabled)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap ?? () {},
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.base80,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ),
      ],
    );
  }
}
