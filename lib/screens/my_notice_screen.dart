import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:notice_board/utilities.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../models/notice_model.dart';
import '../models/user_model.dart';
import '../widgets/notice_list.dart';
import 'notice_detail_screen.dart';

class MyNoticeScreen extends StatelessWidget {
  const MyNoticeScreen({Key? key}) : super(key: key);

  //thanks for wanting to be a publisher in our platform, your request will be approved by the admin in the next 24 hours

  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<AuthenticationBloc>(context);

      UserModel user =state is Authenticated? (BlocProvider
          .of<AuthenticationBloc>(context)
          .state
          .props[0] as UserModel):UserModel();

    return BlocProvider(
      create: (context) => NoticeBloc(repository: NoticeRepository())
        ..add(FetchPublishersNoticeEvent(user.id!)),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Notices'),
            centerTitle: true,
          ),
          body: BlocBuilder<NoticeBloc, NoticeState>(
            builder: (context, state) {
              if (state is NoticeLoadingState) {
                return Utilities.showCircularLoader('Fetching your Notices...');
              } else if (state is NoticeLoadedState) {
                return user.isPublisher!
                    ? buildPublishersList(state.noticeDocs)
                    : unregisteredPublisher(context);
              }
              return Container();
            },
          ),
        );
      }),
    );
  }

  Widget unregisteredPublisher(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: GestureDetector(
            onTap: (){
              becomePublisher(context);
            },
            child: const Text(
              'Become a Publisher',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPublishersList(List<DocumentSnapshot> publishersDoc) {
    List<NoticeModel> notices = publishersDoc
        .map((notice) => NoticeModel.fromFireStore(notice))
        .toList();
    return publishersDoc.isEmpty
        ? const Center(
            child: Text('There is no Notice published by you yet '),
          )
        : ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              NoticeModel notice = notices[index];
              return GestureDetector(
                  onTap: () {
                    Utilities.push(
                        NoticeDetailScreen(
                          notice: notice,
                        ),
                        context);
                  },
                  child: NoticeList(notice: notice));
            },
          );
  }


  void becomePublisher(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: const Text('No'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: const Text('Yes'),
      onPressed: () {
        //noticeBloc.add(DeleteNoticeEvent(widget.notice!.id!));
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Delete Notice'),
      content:
      const Text('Are you sure you want to become a Publisher?'),
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
