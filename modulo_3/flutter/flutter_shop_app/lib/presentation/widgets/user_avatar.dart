import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.avatarUrl,
    this.username,
    this.radius = 32,
    this.onTap,
  });

  final String? avatarUrl;
  final String? username;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget avatar;

    if (avatarUrl != null) {
      avatar = CachedNetworkImage(
        imageUrl: avatarUrl!,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => _InitialsAvatar(
          username: username,
          radius: radius,
          colorScheme: colorScheme,
        ),
        errorWidget: (context, url, error) => _InitialsAvatar(
          username: username,
          radius: radius,
          colorScheme: colorScheme,
        ),
      );
    } else {
      avatar = _InitialsAvatar(
        username: username,
        radius: radius,
        colorScheme: colorScheme,
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            avatar,
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.camera_alt,
                  size: radius * 0.5,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return avatar;
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({
    this.username,
    required this.radius,
    required this.colorScheme,
  });

  final String? username;
  final double radius;
  final ColorScheme colorScheme;

  String get _initials {
    if (username == null || username!.isEmpty) return '';
    final parts = username!.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return username![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _initials;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      child: initials.isNotEmpty
          ? Text(
              initials,
              style: TextStyle(
                fontSize: radius * 0.65,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            )
          : Icon(
              Icons.person,
              size: radius,
              color: colorScheme.onPrimaryContainer,
            ),
    );
  }
}
