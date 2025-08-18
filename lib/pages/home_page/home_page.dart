import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_profile_image_with_hive/provider/profile_image_provider.dart';
import 'package:user_profile_image_with_hive/widget/custom_appbar.dart';
import 'package:user_profile_image_with_hive/widget/custom_drawer.dart';
import '../../widget/josna_bg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? profileImage;
  final ImagePicker _imagePicker = ImagePicker();


  Future<void> pickImage(ImageSource source) async{
    try{
      final imageProvider = Provider.of<ProfileImageProvider>(context,listen: false);

      final originalImage = await _imagePicker.pickImage(source: source);
      if(originalImage == null) return;

      // Now Print Original Image Size
      final originalImageSize = await File(originalImage.path).length();
      if(kDebugMode){print("Original Image Size : ${originalImageSize / 1024} KB");}


      // Now Crop Image Here
      final cropImage = await ImageCropper().cropImage(
          sourcePath: originalImage.path,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop Image",
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
              hideBottomControls: false,
              initAspectRatio: CropAspectRatioPreset.square
            ),
            IOSUiSettings(
              title: "Crop Image",
              aspectRatioLockEnabled: true,
              hidesNavigationBar: false,
              aspectRatioPickerButtonHidden: false,
              minimumAspectRatio: 1.0
            )
          ]
      );

      if(cropImage == null) return;

      // Now Crop Image Size Print
      final cropImageSize = await File(cropImage.path).length();
      if(kDebugMode){print("Crop Image Size : ${cropImageSize / 1024} KB");}


      // >>>  Now Image Compressed Start Here
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path,"compressed_${DateTime.now().millisecondsSinceEpoch}.jpg");

      final firstCompressed = await FlutterImageCompress.compressAndGetFile(cropImage.path, tempPath,quality: 70,minHeight: 512,minWidth: 512);
      if(firstCompressed == null) return;

      final firstCompressedImgSize = await firstCompressed.length();

      // Print First Compressed
      if(kDebugMode){print("First Compressed Size : ${firstCompressedImgSize / 1024} KB");}

      // Now Check 300 KB
      if(firstCompressedImgSize > (300 * 1024)){
        final againFinalCompressed = await FlutterImageCompress.compressAndGetFile(cropImage.path, tempPath,quality: 50,minHeight: 512,minWidth: 512);

        if(againFinalCompressed != null){
          // Print Final Compressed Image
          final finalCompressedSize = await againFinalCompressed.length();
          if(kDebugMode){print("Final Compressed Image is : ${finalCompressedSize/1024} KB");}

          final permanentDirectory = await getApplicationDocumentsDirectory();
          final permanentPath = "${permanentDirectory.path}/profile_${DateTime.now().millisecondsSinceEpoch}.jpg";
          await againFinalCompressed.saveTo(permanentPath);
          final permanentImage = File(permanentPath);
          profileImage = permanentImage;
          setState(() {});
          await imageProvider.saveProfileImage(permanentImage);
        }
      }else{
        final permanentDirectory = await getApplicationDocumentsDirectory();
        final permanentPath = "${permanentDirectory.path}/profile_${DateTime.now().millisecondsSinceEpoch}.jpg";
        await firstCompressed.saveTo(permanentPath);
        final permanentImage = File(permanentPath);
        profileImage = permanentImage;
        setState(() {});
        await imageProvider.saveProfileImage(permanentImage);
      }

    }catch(e){
      debugPrint("Something Error : $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ProfileImageProvider>(context);
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
                    backgroundColor: (imageProvider.profileImages == null && profileImage == null) ? Color(0xff1f2b3b) : null,
                    backgroundImage: (imageProvider.profileImages != null) ? FileImage(imageProvider.profileImages!) : (profileImage != null) ? FileImage(profileImage!) : null,
                    child: (imageProvider.profileImages == null && profileImage == null) ? Icon(Icons.person, size: 50, color: Colors.white) : null,
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
                      onPressed: ()=> pickImage(ImageSource.camera),
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
                        onPressed: ()=>pickImage(ImageSource.gallery),
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
