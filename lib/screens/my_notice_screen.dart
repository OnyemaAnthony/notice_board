import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../models/notice_model.dart';
import '../models/user_model.dart';
import '../widgets/notice_list.dart';
import 'notice_detail_screen.dart';

class MyNoticeScreen extends StatefulWidget {
  const MyNoticeScreen({Key? key}) : super(key: key);

  @override
  State<MyNoticeScreen> createState() => _MyNoticeScreenState();
}

class _MyNoticeScreenState extends State<MyNoticeScreen> {
  late AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NoticeBloc(repository: NoticeRepository())
        ..add(FetchPublishersNoticeEvent('xWdpMjDYpgQeCSm1nRZy')),
      child: Builder(builder: (BuildContext ctx) {
        authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Notices'),
            centerTitle: true,
          ),
          body: BlocConsumer<NoticeBloc, NoticeState>(
            listener: (context,state){
              if(state is UserUpdatedState){
              // return showAlert(context);
              }
            },
            builder: (context, state) {
              if (state is NoticeLoadingState) {
                return Utilities.showCircularLoader('Fetching your Notices...');
              } else if (state is NoticeLoadedState) {
                return Utilities.getUser(ctx)!.isPublisher!
                    ? buildPublishersList(state.noticeDocs)
                    :  unregisteredPublisher(context);
              }
              return Container();
            },
          ),
        );
      }),
    );
  }

  Widget unregisteredPublisher(BuildContext context) {
    return Utilities.getUser(context)!.isRequestedPublisher!?const Center(child: Text('You have requested to become a publisher please wait for admin to review your request'),): Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width *0.2,
              padding: const EdgeInsets.all(10),
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color:Colors.white, width: 1),
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


  void showAlert(BuildContext context) {
    Widget continueButton = FlatButton(
      child: const Text('Yes'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Your request has been received'),
      content:
      const Text('thanks for wanting to be a publisher in our platform, your request will be approved by the admin in the next 24 hour'),
      actions: [
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

  void becomePublisher(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: const Text('Ok'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: const Text('Yes'),
      onPressed: () {
        Map<String,dynamic>user = {
          'isRequestedPublisher':true,
          'updatedAt':DateTime.now(),
        };

        authenticationBloc.add(UpdateUserToPublisherEvent('5BHhISn1QQRXHKqfdLROwiJU49d2', user));
        Navigator.of(context).pop();
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
