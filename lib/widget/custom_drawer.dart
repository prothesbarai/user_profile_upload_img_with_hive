import 'package:flutter/material.dart';
import 'package:user_profile_image_with_hive/widget/sun_bg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: AssetImage("assets/icon/icon.png"),
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
