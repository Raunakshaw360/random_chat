import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userPhotoUrl;

  TransparentAppBar({required this.userPhotoUrl});
//moy moy
  @override
  Widget build(BuildContext context) {
    return AppBar(

      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(userPhotoUrl),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Add your action here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
