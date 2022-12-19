import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  final DateFormat dateFormatter = DateFormat('yMMMEd');

  late NoticeBloc noticeBloc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserModel? user = Storage.user;
    return BlocProvider(
      create: (BuildContext context) =>
          NoticeBloc(repository: NoticeRepository()),
      child: Builder(
        builder: (BuildContext context){
          noticeBloc = BlocProvider.of<NoticeBloc>(context);
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Your notice detail'),
                  actions: [
                    user!.isPublisher! || user.id == widget.notice!.createdBy!
                        ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          deleteNotice(context);
                        },
                        child: const Icon(Icons.delete),
                      ),
                    )
                        : Container(),
                  ],
                  pinned: true,
                  stretch: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                          ),
                          width: 85,
                          height: 85,
                          padding: const EdgeInsets.all(15),
                        ),
                        imageUrl: widget.notice!.imageURL!,
                        fit: BoxFit.cover),
                  ),
                ),
                BlocBuilder<NoticeBloc, NoticeState>(
                  builder: (context, state) {
                    if (state is NoticeLoadingState) {
                      return Utilities.showCircularLoader('Deleting notice...');
                    }
                    return const SliverToBoxAdapter();
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20,left: 5,right: 5),
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children:  [
                        const Text('INFO',style: TextStyle(fontWeight: FontWeight.bold),),
                       const SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: Colors.black12
                          ),
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text('Title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                //const SizedBox(height: 10,),
                                Text(widget.notice!.title!,style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                                ),),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(width: size.width,
                        //height: size.height*0.7,
                          color: Colors.black12,
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 10,),
                                Text(widget.notice!.description!,style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                          )

                          ,),
                       // const SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          height: size.height *0.09,
                          decoration: const BoxDecoration(
                              color: Colors.black12
                          ),
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Posted by',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 10,),
                                Text(widget.notice!.createdByFullName!,style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),),

                              ],
                            ),

                          ),
                        ),
                       const SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          height: size.height *0.1,
                          decoration: const BoxDecoration(
                              color: Colors.black12
                          ),
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Posted At',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                    const SizedBox(width: 10,),
                                    Text(dateFormatter.format(widget.notice!.createdAt!),style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15
                                    ),),
                                  ],
                                ),
                                const SizedBox(height: 10,),

                                Row(
                                  children: [
                                    const Text('DeadLine At',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                    const SizedBox(width: 10,),
                                    Text(dateFormatter.format(widget.notice!.deadline!),style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 200,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },

      ),
    );
  }

  void deleteNotice(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        noticeBloc.add(DeleteNoticeEvent(widget.notice!.id!));
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Delete Notice'),
      content: Text('Are you sure you want to ${widget.notice!.title}?'),
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
