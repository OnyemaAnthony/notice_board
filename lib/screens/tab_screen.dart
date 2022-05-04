import 'package:flutter/material.dart';
import 'package:notice_board/screens/notice_request_screen.dart';
import 'package:notice_board/screens/publishers_request_screen.dart';
import 'package:notice_board/screens/user_screen.dart';
class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  const TabBar(
                    tabs:[
                       Text('User Screen'),
                      Text("Notice Requests"),
                      Text("Publishers Request")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body:const TabBarView(
          children:[
            UserScreen(),
            NoticeRequestScreen(),
            PublishersRequestScreen(),
          ],
        ),
      ),
    );
  }
}
