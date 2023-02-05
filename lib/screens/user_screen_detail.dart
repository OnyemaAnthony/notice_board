import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/models/user_model.dart';
class UserScreenDetail extends StatelessWidget {
  final UserModel? user;
   UserScreenDetail({Key? key,this.user}) : super(key: key);
  final DateFormat dateFormatter = DateFormat('yMMMEd');


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Your  information'),
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
                  imageUrl: user!.imageURL!,
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
                          const Text('Full Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          const SizedBox(height: 10,),
                          Text('${user!.lastName}, ${user!.firstName}',style: const TextStyle(
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
                          Text(user!.description!,style: const TextStyle(
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
                            children: [
                              const Text('isPublisher',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              const SizedBox(width: 5,),
                              Text(user!.isPublisher!? 'Yes':'No',style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        const  SizedBox(height: 5,),
                          Row(
                            children: [
                              const Text('isAdmin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              const SizedBox(width: 5,),
                              Text(user!.isPublisher!? 'Yes':'No',style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),),
                            ],
                          ),

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
                                const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(width: 5,),
                                Text(user!.email!,style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                           const SizedBox(height: 5,),
                            Row(
                              children: [
                                const Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(width: 5,),
                                Text(user!.phoneNumber!,style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Joined On',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(width: 10,),
                                Text(dateFormatter.format(user!.createdAt!),style: const TextStyle(
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
                 const SizedBox(height: 200,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
