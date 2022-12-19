import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/screens/publishers_request_detail.dart';
import 'package:notice_board/widgets/user_list.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../models/user_model.dart';
import '../utilities.dart';

class PublishersRequestScreen extends StatefulWidget {
  const PublishersRequestScreen({Key? key}) : super(key: key);

  @override
  _PublishersRequestScreenState createState() => _PublishersRequestScreenState();
}

class _PublishersRequestScreenState extends State<PublishersRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          BlocProvider.of<AuthenticationBloc>(context).add(FetchPublishersRequestEvent());
          return Scaffold(
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is AuthenticationLoadingState){
                  return Utilities.showCircularLoader('Fetching Notices Requests...');
                }else if(state is UserLoadedState){
                  return state.users.isEmpty?const Center(child: Text('Sorry you don\'t have any pending publishers request ',style: TextStyle(
                    fontWeight:FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black
                  ),),) :buildUserList(state.users);
                }
                return Container();
              },
            ),
          );
        }
    );
  }
  Widget buildUserList(List<UserModel> users){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        UserModel user = users[index];
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> PublishersRequestDetail(user: user,)));
          },
            child: UserList(user: user));
      },
    );
  }
}
