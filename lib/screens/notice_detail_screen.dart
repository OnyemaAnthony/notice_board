import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';
import '../models/user_model.dart';

class NoticeDetailScreen extends StatefulWidget {
  final NoticeModel? notice;

  const NoticeDetailScreen({Key? key, this.notice}) : super(key: key);

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  late NoticeBloc noticeBloc;

  @override
  Widget build(BuildContext context) {
    UserModel? user = Storage.user;
    return BlocProvider(
      create: (BuildContext context) => NoticeBloc(repository: NoticeRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.notice!.title!),
          actions: [
            user!.isPublisher! ||user.id ==widget.notice!.createdBy!? Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                deleteNotice(context);
                },
                child: const Icon(Icons.delete),
              ),
            ):Container(),
          ],
        ),
        body: Builder(
            builder: (BuildContext context) {
              noticeBloc = BlocProvider.of<NoticeBloc>(context);
              return BlocBuilder<NoticeBloc, NoticeState>(
                builder: (context, state) {
                  if(state is NoticeLoadingState){
                    return Utilities.showCircularLoader('Deleting notice...');
                  }
                  return Column(
                    children: [
                      Text('the text is ${widget.notice!.description}')
                    ],
                  );
                },
              );
            }
        ),
      ),
    );
  }

  void deleteNotice(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: const Text('Ok'),
      onPressed: () {
        noticeBloc.add(DeleteNoticeEvent(widget.notice!.id!));
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Delete Notice'),
      content:
      Text('Are you sure you want to ${widget.notice!.title}?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
