import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/authentication/authentication_bloc.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/screens/user_screen_detail.dart';
import 'package:notice_board/widgets/user_list.dart';

import '../utilities.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (BuildContext context) {
          BlocProvider.of<AuthenticationBloc>(context).add(FetchAllUsersEvent());
          return Scaffold(
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is AuthenticationLoadingState){
                  return Utilities.showCircularLoader('Fetching Notices Requests...');
                }else if(state is UserLoadedState){
                  return buildUserList(state.users,context);
                }
                return Container();
              },
            ),
          );
        }
    );
  }
  Widget buildUserList(List<UserModel> users,BuildContext context){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        UserModel user = users[index];
        return GestureDetector(
          onTap: (){
            Utilities.push(UserScreenDetail(user: user,), context);
          },
            child: UserList(user: user));
      },
    );
  }

}
