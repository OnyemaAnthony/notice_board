import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';

class UserList extends StatelessWidget {
  final UserModel? user;
  const UserList({Key? key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('the user is ${user!.firstName}');
  }
}
