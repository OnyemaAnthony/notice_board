import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String imageURL = 'https://images.pexels.com/photos/267885/pexels-photo-267885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(imageUrl: imageURL,fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
