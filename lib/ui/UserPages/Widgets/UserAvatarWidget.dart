import 'package:flutter/material.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget({Key? key, this.userProfilImage, this.size})
      : super(key: key);
  final String? userProfilImage;
  final double? size;
  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size ?? 80,
      width: widget.size ?? 80,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: (widget.userProfilImage != null)
          ? Image.network(
              widget.userProfilImage!,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.account_circle_rounded,
                  size: widget.size ?? 80,
                );
              },
            )
          : Icon(
              Icons.account_circle_rounded,
              size: widget.size ?? 80,
            ),
    );
  }
}
