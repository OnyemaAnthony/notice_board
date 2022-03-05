import 'package:flutter/material.dart';
import 'package:notice_board/screens/navigation_screen.dart';
import 'package:notice_board/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
            home: const NavigationScreen(),
          );
        }
      ),
    );
  }
}
