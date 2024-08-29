import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/Functions/signIn_service.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/models/user_model.dart';

import 'package:firebase_core/firebase_core.dart';

initialisation() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SinginmodelAdapter().typeId)) {
    Hive.registerAdapter(SinginmodelAdapter());
    await Signinservice().openBox();
  }
  if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    Hive.registerAdapter(TripModelAdapter());
    // await Hive.openBox<TripModel>(tripDbName);

    if (!Hive.isAdapterRegistered(CompletedTripModelPhotosAdapter().typeId)) {
      Hive.registerAdapter(CompletedTripModelPhotosAdapter());
    }
    if (!Hive.isAdapterRegistered(FevoriteModelAdapter().typeId)) {
      Hive.registerAdapter(FevoriteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(ExpenseModelAdapter().typeId)) {
      Hive.registerAdapter(ExpenseModelAdapter());
    }
  }
}
