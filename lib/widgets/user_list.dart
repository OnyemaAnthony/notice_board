import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';

class UserList extends StatelessWidget {
  final UserModel? user;
  const UserList({Key? key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        subtitle: SizedBox(height: MediaQuery.of(context).size.height*0.089,child: Text(user!.description!),),
        title: Text('${user!.firstName}, ${user!.lastName}'),
        leading:   CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(user!.imageURL!),
        ),
      ),
    );
  }
}
