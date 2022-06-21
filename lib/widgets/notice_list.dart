import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/widgets/storage.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeList extends StatelessWidget {
  final NoticeModel? notice;

  const NoticeList({Key? key,this.notice}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    UserModel? user = Storage.user;
  return  Container(
    margin:const  EdgeInsets.only(top: 10),
    child: Card(
      child: Container(
        padding: const EdgeInsets.only(bottom: 25,top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Title:${notice!.title}')

          ],
        // child: ListTile(
        //   title: Text('${user!.firstName}, ${user.lastName}'),
        //     leading:  CircleAvatar(
        //       radius: 30,
        //       backgroundImage: CachedNetworkImageProvider(user.imageURL!),
        //     ),
        ),
      ),
    ),
  );
  }
}
