import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String imageURL =
      'https://images.pexels.com/photos/267885/pexels-photo-267885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  String face =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60';

  @override
  Widget build(BuildContext context) {
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
                  CachedNetworkImage(imageUrl: imageURL, fit: BoxFit.cover),
            ),
            title: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(face),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text('Goz man')
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(primary: false, shrinkWrap: true, children: [
                const Text(
                  'User Bag',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                     ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const UserTile(icon: Icons.favorite,color: Colors.red,title: 'Wishlist',tIcon: Icons.arrow_forward_ios),
                const UserTile(icon: Icons.favorite,color: Colors.deepPurpleAccent,title: 'Cart',tIcon: Icons.arrow_forward_ios),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'User Settings',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: SwitchListTile.adaptive(
                    secondary:  Icon(Icons.light_mode,color: Colors.amber.shade700,),
                      title: const Text('Light Mode'),
                      value: false, onChanged: (value){

                  }),
                ),
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
                const UserTile(icon: Icons.email,color: Colors.red,title: 'Email',tIcon: Icons.arrow_forward_ios,subTitle: 'Email',),
                const UserTile(icon: Icons.call,color: Colors.green,title: 'Phone Number',tIcon: Icons.arrow_forward_ios,subTitle: 'Number',),
                const UserTile(icon: Icons.local_shipping,color: Colors.indigo,title: 'Address',tIcon: Icons.arrow_forward_ios,subTitle: 'Address',),
                const UserTile(icon: Icons.watch_later,color: Colors.red,title: 'joined Date',tIcon: Icons.arrow_forward_ios,subTitle: 'date',),


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
