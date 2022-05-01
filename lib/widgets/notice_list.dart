import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  final String? title;
  final String? description;
  final DateTime? createdAt;
  final DateTime? deadline;
  const NoticeList({Key? key,this.description,this.title,this.createdAt,this.deadline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
