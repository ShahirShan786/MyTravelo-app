import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<List<String>> uploadSubImages({required List<XFile> images}) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference refereceDirImages = referenceRoot.child("subImages${DateTime.now().millisecondsSinceEpoch}");

  List<String> urls = [];

  for (int i = 0; i < images.length; i++) {
    Reference referenceImageUpload = refereceDirImages.child(images[i].name);
    try {
      await referenceImageUpload.putFile(File(images[i].path));
      urls.add(await referenceImageUpload.getDownloadURL());
    } catch (e) {
      log("============$e");
    }
  }
  return urls;
}


Future<String?> uploadMainImage({required XFile? image})async{
  if(image == null) return null;
  
    try{
       Reference storageRef = FirebaseStorage.instance.ref();
  Reference imageRef = storageRef.child("mainImage${DateTime.now().millisecondsSinceEpoch}");
    
    await imageRef.putFile(File(image.path));
   final downloadUrl = await imageRef.getDownloadURL();
   return downloadUrl;
    }catch(e){
      log("print error uploading main image $e");
      log('====image uploaded to firebase====');
      return null;
    }
     
  }