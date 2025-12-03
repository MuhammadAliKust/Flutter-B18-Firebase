import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/provider/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(children: [
        Text(userProvider.getUser().name.toString()),
        Text(userProvider.getUser().email.toString()),
        Text(userProvider.getUser().phone.toString()),
        Text(userProvider.getUser().address.toString()),
        ElevatedButton(onPressed: (){}, child: Text("Update Profile"))
      ],),
    );
  }
}
