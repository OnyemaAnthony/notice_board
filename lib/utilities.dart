import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notice_board/widgets/storage.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'models/user_model.dart';

class Utilities {

  static  showToast(String message){

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

  static  void pushReplace(Widget screen, BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  static void push(Widget screen, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
  static UserModel? getUser(BuildContext context){
      return (BlocProvider.of<AuthenticationBloc>(context).state.props[0] as UserModel);
  }
  static bool isAuthenticated(BuildContext context){
    var state = BlocProvider.of<AuthenticationBloc>(context);
    return state is Authenticated;



  }

  static Widget showCircularLoader(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.start),
        const SizedBox(
          height: 20,
        ),
        Center(child: Text(message)),
      ],
    );
  }
}