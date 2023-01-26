import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/authentication/authentication_bloc.dart';
import 'package:notice_board/repositories/user_repository.dart';
import 'package:notice_board/screens/forget_password_screen.dart';
import 'package:notice_board/screens/navigation_screen.dart';
import 'package:notice_board/screens/sign_up_screen.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';

import '../widgets/curve.dart';


class LoginScreen extends StatefulWidget {
const  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late AuthenticationBloc authenticationBloc;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: <Widget>[

        ],
      ),
    );
  }

  Widget _entryField(String title,TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  //fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purple, Colors.purpleAccent])),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
         if(state is Authenticated){
           Storage.user = state.user;
           Utilities.pushReplace(const NavigationScreen(), context);
         }
        },
  builder: (context, state) {
    if(state is AuthenticationLoadingState){
      return const CircularProgressIndicator();
    }
    return TextButton(
        onPressed: (){
          authenticationBloc.add(LogInEvent(emailController.text,passwordController.text));
        },
        child:  const Text(
          'Login',
          style: TextStyle(fontSize: 20),
        ),
      );
  },
),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }


  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Utilities.push(const SignUpScreen(), context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email",emailController),
        _entryField("Password",passwordController,isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
  create: (BuildContext context) => AuthenticationBloc(repository: UserRepository()),
  child: Builder(
    builder: (BuildContext context) {
      authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
      return Scaffold(
            body: SizedBox(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: const BezierContainer()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          const SizedBox(height: 50),
                          _emailPasswordWidget(),
                          const SizedBox(height: 20),
                          _submitButton(),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                                Utilities.push(const ForgetPasswordScreen(), context);
                              },
                              child: const Text('Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          _divider(),
                          SizedBox(height: height * .055),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            ));
    }
  ),
);
  }
}