import 'dart:developer';


import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/models/profileModel.dart';

class Profileservies {
  Box<Profilemodel>? _profileBox;

//  to open Box

  Future<void> openBox() async {
    _profileBox = await Hive.openBox<Profilemodel>("ProfileBox");
  }

// to add Data

  Future<void> addProfileData(Profilemodel values) async {
    log('in add sign in');
    if (_profileBox == null) {
      await openBox();
    }
    await _profileBox!.add(values);
    log("data passed... $values");
    log("Data Added..");
  }

  // to get datas..

  Future<Profilemodel?> getProfileData(String username) async {
    if (_profileBox == null) {
      log('here');
      await openBox();
    }
    try {
      log('${_profileBox!.values.length}');
      log('${_profileBox!.values.toList()[3].userName}');
      return _profileBox!.values
          .toList()
          .where((user) => user.userName == username)
          .first;
    } catch (e) {
      log('Error: $e');
      return null;
      // return _profileBox!.values.toList();
    }
  }

  // To update Data

  Future<void>updateProfileData(String username , Profilemodel newValue)async{
     if(_profileBox == null){
      await openBox();
     }
    try{
      final key = _profileBox!.values.firstWhere((Key){
        final profile = _profileBox!.get(Key) as Profilemodel;
        return profile.userName == username;

      });
      await _profileBox!.put(key, newValue);
      log("Data added for user :$username");

    }catch(e){
      log("Error $e");
    }
  }
}
