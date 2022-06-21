import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeList extends StatelessWidget {
  final NoticeModel? notice;

  const NoticeList({Key? key,this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return const Text('hello world');
  }
}
