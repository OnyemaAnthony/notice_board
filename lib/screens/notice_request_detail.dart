import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/repositories/notice_repository.dart';

class NoticeRequestDetail extends StatefulWidget {
  NoticeModel? notice;
   NoticeRequestDetail({Key? key,this.notice}) : super(key: key);

  @override
  State<NoticeRequestDetail> createState() => _NoticeRequestDetailState();
}

class _NoticeRequestDetailState extends State<NoticeRequestDetail> {
  final DateFormat dateFormatter = DateFormat('yMMMEd');
  late NoticeBloc noticeBloc;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context)=> NoticeBloc(repository: NoticeRepository()),
      child: Builder(
        builder: (BuildContext context){
          noticeBloc = BlocProvider.of<NoticeBloc>(context);
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Notice information'),
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
                        imageUrl:widget.notice!.imageURL!,
                        fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20,left: 5,right: 5),
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children:  [
                        const Text('USER INFO',style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
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
                                const Text('Published by',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 10,),
                                Text('${widget.notice!.createdByFullName}',style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(width: size.width,
                          height: size.height*0.3,
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
                        const SizedBox(height: 10,),
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
                                Row(
                                  children: const [
                                    Text('Role : Publisher',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                    SizedBox(width: 5,),
                                  ],
                                ),
                                const  SizedBox(height: 5,),


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
                            child: SingleChildScrollView(
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [
                                      const Text('Deadline',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      const SizedBox(width: 5,),
                                      Text(dateFormatter.format(widget.notice!.deadline!),style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      const Text('Published  On',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      const SizedBox(width: 10,),
                                      Text(dateFormatter.format(widget.notice!.createdAt!),style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: (){
                                  Navigator.pop(context);

                                }, child: const Text("Reject")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: (){
                                  publish(context);

                                },
                                child:  BlocConsumer<NoticeBloc,NoticeState>(
                                  listener: (BuildContext context,state){
                                    if(state is NoticeAddedState){
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  builder: (BuildContext context, state) {
                                  if(state is NoticeLoadingState){
                                    return const CircularProgressIndicator();
                                  }
                                  return const Text("Publish");


                                },

                                )),
                          ],
                        ),
                        const SizedBox(height: 200,)

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

  void showAlert(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text('Yes'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Your request has been received'),
      content:
      const Text('You can now view your Notice in the notice list'),
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

  void publish(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text('Yes'),
      onPressed: () {
        Map<String,dynamic>noticeMap = {
          'isVisible':true,
          'updatedAt':DateTime.now(),
        };

        noticeBloc.add(ApproveNoticeEvent(noticeMap, widget.notice!.id!));
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Publish notice'),
      content:
      const Text('Are you sure you want to Publish this notice?'),
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


