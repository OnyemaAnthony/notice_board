import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/repositories/user_repository.dart';
import 'package:notice_board/screens/login_screen.dart';
import 'package:notice_board/screens/tab_screen.dart';
import 'package:notice_board/screens/welcome_screen.dart';
import 'package:notice_board/theme.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final DateFormat dateFormatter = DateFormat('yMMMEd');
  String imageURL =
      'https://images.pexels.com/photos/267885/pexels-photo-267885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  String face ='https://firebasestorage.googleapis.com/v0/b/notice-board-d385d.appspot.com/o/Pictures%2F5BHhISn1QQRXHKqfdLROwiJU49d2%2F1651402738068?alt=media&token=705e82d8-1885-4a86-b8e0-26093c004bf5';
  @override
  Widget build(BuildContext context) {
    UserModel? user = Storage.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background:
                  CachedNetworkImage(
                      placeholder: (context, url) =>
                          Container(
                            child:
                            const CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                              AlwaysStoppedAnimation<
                                  Color>(
                                  Colors.blueGrey),
                            ),
                            width: 85,
                            height: 85,
                            padding: const EdgeInsets.all(15),
                          ),
                      imageUrl: imageURL, fit: BoxFit.cover),
            ),
            title: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user!.imageURL!),
                ),
                const SizedBox(
                  width: 12,
                ),
                 Text(user.firstName!)
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(primary: false, shrinkWrap: true, children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'User Information',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                   ),
                ),
                const SizedBox(
                  height: 10,
                ),
                UserTile(icon: Icons.email,color: Colors.red,title: 'Email',tIcon: Icons.arrow_forward_ios,subTitle: user.email,),
                UserTile(icon: Icons.call,color: Colors.green,title: 'Phone Number',tIcon: Icons.arrow_forward_ios,subTitle: user.phoneNumber,),
                UserTile(icon: Icons.local_shipping,color: Colors.indigo,title: 'About',tIcon: Icons.arrow_forward_ios,subTitle: user.description,),
                UserTile(icon: Icons.verified_user_sharp,color: Colors.grey,title: 'Sign out',tIcon: Icons.arrow_forward_ios,subTitle: '',onTap: (){
                  UserRepository().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen()));
                },),
                UserTile(icon: Icons.watch_later,color: Colors.red,title: 'joined Date',tIcon: Icons.arrow_forward_ios,subTitle: dateFormatter.format(user.createdAt!),),

                const Text(
                  'User Settings',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  child: Consumer<ThemeNotifier>(
                      builder: (context, notifier,_) {
                        return SwitchListTile.adaptive(
                            secondary: notifier.isDark? Icon(Icons.dark_mode,color: Colors.amber.shade700,): Icon(Icons.light_mode,color: Colors.amber.shade700,),
                            title: notifier.isDark ? const Text('Dark Mode'):const Text('Light Mode'),
                            value: notifier.isDark, onChanged: (value){
                          notifier.toggleTheme(value);
                        });
                      }
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: user.isAdmin!,
                  child: Align(
                    child: GestureDetector(
                      onTap: (){
                        Utilities.push(const TabScreen(), context);

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width:  double.infinity,
                        height: MediaQuery.of(context).size.height *0.08,
                        decoration: BoxDecoration(
                           color: Theme.of(context).buttonTheme.colorScheme!.primary,
                        ),
                        child:  const Text('Admin Panel',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                )

              ]),
            ),
          ),

        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final IconData? tIcon;
  final VoidCallback? onTap;
  final VoidCallback? tTap;
  final Color? color;

  const UserTile(
      {Key? key,
      this.onTap,
        this.color,
        required this.title,
      this.icon,
      this.subTitle,
    this.tIcon,
      this.tTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle:  Text(subTitle != null ?subTitle!:''),
        leading:  Icon(icon!,color: color,),
        title:  Text(title!),
        onTap: onTap,
        trailing: IconButton(
          icon:  Icon(tIcon),
          onPressed: tTap,
        ),
      ),
    );
  }
}
