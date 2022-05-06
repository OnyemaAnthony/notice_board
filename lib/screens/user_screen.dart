import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/authentication/authentication_bloc.dart';
import 'package:notice_board/models/user_model.dart';

import '../utilities.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (BuildContext context) {
          BlocProvider.of<AuthenticationBloc>(context).add(FetchAllUsersEvent());
          return Scaffold(
            appBar: AppBar(
              title: const Text('Users Screen'),
            ),
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is AuthenticationLoadingState){
                  return Utilities.showCircularLoader('Fetching Notices Requests...');
                }else if(state is UserLoadedState){
                  return buildUserList(state.users);
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
        return ListTile(
          title: Text(user.firstName!),
        );
      },
    );
  }

}
