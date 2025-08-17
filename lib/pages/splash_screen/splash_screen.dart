import 'package:flutter/material.dart';

import '../home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2,),() {
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/icon/icon.png"),
                  ),
                  SizedBox(height: 30,),
                  Text("User Profile",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Color(0xff01a388)),softWrap: true,)
                ],
              )
            ],
          ),
      ),


    );
  }
}
