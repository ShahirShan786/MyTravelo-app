import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:my_travelo_app/servies/signIn_service.dart';

initialisation() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  }
}
