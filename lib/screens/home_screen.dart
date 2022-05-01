import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:notice_board/screens/create_notice_screen.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/notice_list.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoticeBloc noticeBloc;

  @override
  Widget build(BuildContext context) {
    UserModel user = (BlocProvider
        .of<AuthenticationBloc>(context)
        .state
        .props[0] as UserModel);
    return Scaffold(
      floatingActionButton: user.isPublisher != null && user.isPublisher!
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Utilities.push(const CreateNoticeScreen(), context);
        },
      )
          : Container(),
      appBar: AppBar(
        title: const Text('Notice Board'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => NoticeBloc(repository: NoticeRepository()),
        child: Builder(builder: (BuildContext context) {
          noticeBloc = BlocProvider.of<NoticeBloc>(context)..add(GetAllNoticeEvent());
          return BlocBuilder<NoticeBloc, NoticeState>(
            builder: (context, state) {
              if(state is NoticeLoadingState){
                return Utilities.showCircularLoader('Fetching notices...');
              }else if(state is NoticeLoadedState){
                print('the notice is ${state.noticeDocs.length}');
                return buildNoticeList(state.noticeDocs);
              }
              return Container();
            },
          );
        }),
      ),
    );
  }
  Widget buildNoticeList(List<DocumentSnapshot> noticeDocs){
    List<NoticeModel> notices = noticeDocs.map((notice) =>NoticeModel.fromFireStore(notice) ).toList();
    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context,index){
        NoticeModel notice = notices[index];
        return NoticeList(notice: notice);
      },
    );

  }

}
