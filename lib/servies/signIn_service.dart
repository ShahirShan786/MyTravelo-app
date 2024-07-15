
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/models/singInModel.dart';

class Signinservice {
  Box<Singinmodel>? _signInBox;

  // To open the box
  Future<void> openBox() async {
    _signInBox = await Hive.openBox<Singinmodel>("singIn");
  }

  // To add sign in data
  Future<void> addsignInData(Singinmodel value) async {
    log('in add sign in');
    if (_signInBox == null) {
      await openBox();
    }
    await _signInBox!.add(value);
    log("data passed... $value");
  }

  // To update sign in data
  Future<void> updatesignInData(Singinmodel value) async {
    log('in update sign in');
    if (_signInBox == null) {
      await openBox();
    }
    final index = _signInBox!.values.toList().indexWhere((element) => element.id == value.id);
    if (index != -1) {
      await _signInBox!.putAt(index, value);
      log("data updated... $value");
    }
  }

  // To get sign in data
  Future<List<Singinmodel>> getsignInData() async {
    if (_signInBox == null) {
      await openBox();
    }
    return _signInBox!.values.toList();
  }
}
