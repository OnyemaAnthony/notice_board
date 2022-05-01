import 'package:flutter/material.dart';
import 'package:notice_board/models/notice_model.dart';

class NoticeList extends StatelessWidget {
  final NoticeModel? notice;

  const NoticeList({Key? key,this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(notice!.title![0]),),
      title: Text(notice!.title!),
    );;
  }
}
