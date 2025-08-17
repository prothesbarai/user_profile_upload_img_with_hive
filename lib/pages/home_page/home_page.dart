import 'package:flutter/material.dart';
import 'package:user_profile_image_with_hive/widget/custom_appbar.dart';
import 'package:user_profile_image_with_hive/widget/custom_drawer.dart';

import '../../widget/josna_bg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: CustomDrawer(),
      body: SafeArea(
          child: Stack(
            children: [
              JosnaNight(),
              Positioned(
                  top: 20,
                  left: 20,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xff1f2b3b),
                    backgroundImage: null,
                    child: Icon(Icons.person,color: Colors.white,size: 70,),
                  )
              ),

              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        side: const BorderSide(color: Colors.white, width: 2),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white, 
                      ),
                      child: const Icon(Icons.camera_alt_outlined, size: 28),
                    ),

                    SizedBox(width: 30,),

                    OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: const BorderSide(color: Colors.white,width: 2),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white
                        ),
                        child: const Icon(Icons.photo_library_outlined,size: 28,)
                    )
                  ],
                )
              )
            ],
          ),
      ),
    );
  }
}
