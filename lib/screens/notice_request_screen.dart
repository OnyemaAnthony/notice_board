import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:notice_board/utilities.dart';

class NoticeRequestScreen extends StatefulWidget {
  const NoticeRequestScreen({Key? key}) : super(key: key);

  @override
  _NoticeRequestScreenState createState() => _NoticeRequestScreenState();
}

class _NoticeRequestScreenState extends State<NoticeRequestScreen> {
  late NoticeBloc noticeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoticeBloc(repository: NoticeRepository())..add(FetchNoticeRequestEvent()),
      child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Notice Request'),
              ),
              body: BlocBuilder<NoticeBloc, NoticeState>(
                builder: (context, state) {
                  if(state is NoticeLoadingState){
                    return Utilities.showCircularLoader('Fetching Notices Requests...');
                  }else if(state is NoticeLoadedState){
                    return buildNoticeList(state.noticeDocs);
                  }
                  return Center();
                },
              ),
            );
          }
      ),
    );
  }

  Widget buildNoticeList(List<DocumentSnapshot> noticeDocs){
    List<NoticeModel> notices = noticeDocs.map((notice) => NoticeModel.fromFireStore(notice)).toList();
   return ListView.builder(
     itemCount: notices.length,
     itemBuilder: (context,index){
       NoticeModel notice = notices[index];
       return ListTile(
         title: Text(notice.title!),
       );
     },
   );
  }
}
