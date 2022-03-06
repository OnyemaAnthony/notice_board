import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/blocs/authentication_bloc.dart';
import 'package:notice_board/repositories/user_repository.dart';
import 'package:notice_board/screens/navigation_screen.dart';
import 'package:notice_board/screens/sign_up_screen.dart';
import 'package:notice_board/theme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => AuthenticationBloc(repository: UserRepository())..add(AppStartedEvent()),
            ),
      ], child: const MyApp())

     );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, notifier,_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notice Board',
            theme: AppTheme.appTheme(notifier.isDark, context),
            home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
              builder: (context, state) {
                if(state is Authenticated){
                  return const NavigationScreen();
                }else if(state is UnAuthenticatedState){
                  return const SignUpScreen();
                }else if (state is AuthenticationErrorState){
                  return const Center(child: Text('Something went wrong try again latter'),);
                }
                  return Container();
              }),

          );
        }
      ),
    );
  }
}
