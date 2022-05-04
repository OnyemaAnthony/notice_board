import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notice_board/blocs/authentication/authentication_bloc.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/repositories/user_repository.dart';
import 'package:notice_board/screens/login_screen.dart';
import 'package:notice_board/screens/navigation_screen.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';

import '../widgets/curve.dart';




class SignUpScreen extends StatefulWidget {
 const  SignUpScreen({Key ?key}) : super(key: key);



  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthenticationBloc authenticationBloc;
  File? profilePicture;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
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
            //controller: emailController,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
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
              colors: [Colors.purple,Colors.purpleAccent])),
      child:  BlocConsumer<AuthenticationBloc, AuthenticationState>(
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
          authenticationBloc.add(SignUpEvent(UserModel(createdAt: DateTime.now(),description: 'hello',isRequestedPublisher:false,email: 'anthon@gmail.com',password:'this.tony',lastName: 'onyema',isPublisher: false,isAdmin: false), profilePicture!));
        },
        child: const Text('Register now'),
       // style: TextButton.styleFrom( ),
        //style: TextStyle(fontSize: 20, color: Colors.white),
      );
  },
),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
      Utilities.push(const LoginScreen(), context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
        _entryField("Username"),
        _entryField("Email "),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
  create: (context) =>AuthenticationBloc(repository: UserRepository()),
  child: Builder(
    builder: (BuildContext context) {
      authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
      return Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                       profilePicture != null?
                       //Container(child: Text('the file is picked'),color: Colors.red,):
                       Material(
                          child: Image.file(
                            profilePicture!,
                            width: 90.0,
                            height: 90.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(45.0)),
                          clipBehavior: Clip.hardEdge,
                        ):
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey,width: 1.5)
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.teal.withOpacity(0.5),
                            ),
                            onPressed: pickImage,
                            padding: const EdgeInsets.all(30.0),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.grey,
                            iconSize: 30.0,
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        SizedBox(height: height * .14),
                        _loginAccountLabel(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        );
    }
  ),
);
  }
  Future pickImage() async {

    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profilePicture = File(image.path);

      });
    }
  }

}