import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/models/user_model.dart';

class UserList extends StatelessWidget {
  final DateFormat dateFormatter = DateFormat('yMMMEd');

  final UserModel? user;
  UserList({Key? key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        subtitle: Row(
          children: [
           const Text('Joined On ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            Text(dateFormatter.format(user!.createdAt!))
          ],
        ),
        title: Text('${user!.lastName}, ${user!.firstName}'),
        leading:   CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(user!.imageURL!),
        ),
      ),
    );
  }
}
