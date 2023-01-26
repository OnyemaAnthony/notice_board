import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/blocs/authentication/authentication_bloc.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/repositories/user_repository.dart';

class PublishersRequestDetail extends StatefulWidget {
  UserModel? user;
   PublishersRequestDetail({Key? key,this.user}) : super(key: key);

  @override
  State<PublishersRequestDetail> createState() => _PublishersRequestDetailState();
}

class _PublishersRequestDetailState extends State<PublishersRequestDetail> {
  final DateFormat dateFormatter = DateFormat('yMMMEd');
  late AuthenticationBloc? authenticationBloc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context)=> AuthenticationBloc(repository: UserRepository()),
      child: Builder(
        builder: (BuildContext context){
          authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
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
                        imageUrl:widget.user!.imageURL!,
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
                                const SizedBox(height: 10,),
                                Text('${widget.user!.firstName}, ${widget.user!.lastName}',style: const TextStyle(
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
                                Text(widget.user!.description!,style: const TextStyle(
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
                                  const SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      const Text('Joined  On',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      const SizedBox(width: 10,),
                                      Text(dateFormatter.format(widget.user!.createdAt!),style: const TextStyle(
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
                                  publish(context,'${widget.user!.lastName} ${widget.user!.firstName}');

                                },
                                child:  BlocConsumer<AuthenticationBloc,AuthenticationState>(
                                  listener: (BuildContext context,state){
                                    if(state is UserUpdatedState){
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  builder: (BuildContext context, state) {
                                    if(state is AuthenticationLoadingState){
                                      return const CircularProgressIndicator();
                                    }
                                    return const Text("Approve");


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
  void showAlert(BuildContext context,String name) {
    Widget continueButton = TextButton(
      child: const Text('Yes'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Your request has been received'),
      content:
       Text('$name Can now publish notice'),
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

  void publish(BuildContext context,String name) {
    Widget cancelButton = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        Map<String,dynamic> userMap ={'isRequestedPublisher':false};

        authenticationBloc!.add(RejectPublishersRequest(widget.user!.id!, userMap));

        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text('Yes'),
      onPressed: () {
        Map<String,dynamic> userMap ={'isPublisher':true};

        authenticationBloc!.add(UpdateUserToPublisherEvent(widget.user!.id!, userMap));
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Update user to publisher'),
      content:
       Text('Are you sure you want to make $name a publisher?'),
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
