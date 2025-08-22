import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showCameraGalleryDialog(BuildContext context,Function(ImageSource) pickImage) async{
  bool isCam = true;
  return showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Center(
                      child: ActionChip(
                        avatar: Icon(isCam ? Icons.camera_alt : Icons.photo_library),
                        label: Text(isCam ? "Camera Selected" : "Gallery Selected"),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 5,
                    child: IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.close),)
                  ),
                ],
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Take a Photo'),
                    onTap: () async {
                      setState(() {isCam = true;});
                      Navigator.of(context).pop();
                      await pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from Gallery'),
                    onTap: () async {
                      setState(() {isCam = false;});
                      Navigator.of(context).pop();
                      await pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          }
        );
      }
  );
}