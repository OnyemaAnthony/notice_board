import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/theme.dart';
import 'package:provider/provider.dart';

import '../blocs/authentication_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);



  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Builder(
      builder: (BuildContext context) {
        authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
        final provider = Provider.of<ThemeNotifier>(context, listen: false);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff58A4EB),
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipper2(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff58A4EB),
                              Color(0xff58A4EB)
                            ])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper3(),
                      child: SizedBox(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        // decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //         colors: [Color(0x44ff3a5a), Color(0x44fe494d)])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper1(),
                      child: SizedBox(
                        child: Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Icon(
                              Icons.local_hospital,
                              color: Colors.white,
                              size: 60,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Stay Healthy",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    color: provider.isDark? Colors.white : Colors.black,
                    elevation: 2.0,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextFormField(
                      validator: (input) =>
                      input!.isEmpty ? 'Please your email' : null,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Material(
                            color: provider.isDark
                                ? Colors.white
                                : Colors.black,
                            elevation: 0,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    color: provider.isDark ? Colors.white : Colors.black,
                    elevation: 2.0,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextFormField(
                      validator: (input) =>
                      input!.isEmpty ? 'Please enter your password' : null,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Material(
                            color: provider.isDark
                                ? Colors.white
                                : Colors.black,
                            elevation: 0,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).buttonColor),
                      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                        },
                        builder: (context, state) {
                          if (state is AuthenticationLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return FlatButton(
                            child: buildText(),
                            onPressed: () {

                            },
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Text buildText() {
    return Text(
      "Sign up",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
