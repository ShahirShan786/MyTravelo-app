
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/models/singInModel.dart';

class Signinservice{

  Box<Singinmodel>?_signInBox;

//  to Open Box

Future<void>openBox()async{

  _signInBox = await Hive.openBox<Singinmodel>("singIn");
}

// to add sing in data

 Future<void>addsignInData(Singinmodel value)async{
  log('in add sign in');
    if(_signInBox == null){
      await openBox();
    }
    await _signInBox!.add(value);
    log("data passed... $value");
 }

//  to get sign in dataa

Future<List<Singinmodel>> getsignInData()async{
  if(_signInBox == null){
    await openBox();
  }
  return _signInBox!.values.toList();
}



}