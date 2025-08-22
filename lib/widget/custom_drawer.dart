import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile_image_with_hive/widget/bg/sun_bg.dart';
import '../provider/profile_image_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ProfileImageProvider>(context);
    return Drawer(
      child: Stack(
        children: [
          SunBg(),
          Container(color: Colors.black.withValues(alpha: 0.5),),
          ListView(
            children: [
              DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: (imageProvider.profileImages == null) ? Color(0xff1f2b3b) : null,
                        backgroundImage: (imageProvider.profileImages != null) ? FileImage(imageProvider.profileImages!) : null,
                        child: (imageProvider.profileImages == null) ? Icon(Icons.person, size: 50, color: Colors.white) : null,
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Prothes",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                            Text("01317818826",overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white,fontSize: 20),)
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
