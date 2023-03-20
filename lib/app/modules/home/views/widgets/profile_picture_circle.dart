import 'package:flutter/material.dart';

Widget profilePictureCircle(String imageUrl) {
  return CircleAvatar(
    backgroundImage: imageUrl.isEmpty
        ? AssetImage('assets/images/default-profile.png')
        : NetworkImage(imageUrl) as ImageProvider,
  );
}
