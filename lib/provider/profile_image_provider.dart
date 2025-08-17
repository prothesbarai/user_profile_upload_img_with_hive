import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileImageProvider extends ChangeNotifier{
  File? _profileImage;
  late Box _storeImage;
  
  File? get profileImages => _profileImage;
  
  ProfileImageProvider(){
    initFetch();
  }
  
  Future<void> initFetch() async{
    _storeImage = Hive.box("StoreUserImages");
    final String? imgPath =_storeImage.get("store_user_image_path");
    if(imgPath != null){
      final File file = File(imgPath);
      if(await file.exists()){
        _profileImage = file;
        notifyListeners();
      }
    }
  }



  Future<void> saveProfileImage(File images) async{
    _profileImage = images;
    await _storeImage.put("store_user_image_path", images.path);
    notifyListeners();
  }


  Future<void> removeProfileImg() async{
    _profileImage = null;
    await _storeImage.delete("store_user_image_path");
    notifyListeners();
  }

  
  
}