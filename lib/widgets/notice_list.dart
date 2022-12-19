import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeList extends StatelessWidget {
  final NoticeModel? notice;

  NoticeList({Key? key, this.notice}) : super(key: key);
  final DateFormat dateFormatter = DateFormat('yMMMEd');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 0.8,),
          ListTile(
            trailing: notice!.deadline!.isAfter(DateTime.now())
                ? Text(dateFormatter.format(notice!.deadline!))
                : Text(
                    dateFormatter.format(notice!.deadline!),
                    style: const TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough),
                  ),
            subtitle: Text(timeago.format(notice!.createdAt!).toString()),
            title: Text(notice!.title!),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                notice!.imageURL??'',
              ),
            ),
          ),
        ],
        // child: ListTile(
        //   title: Text('${user!.firstName}, ${user.lastName}'),
        //     leading:  CircleAvatar(
        //       radius: 30,
        //       backgroundImage: CachedNetworkImageProvider(user.imageURL!),
        //     ),
      ),
    );
  }
}
