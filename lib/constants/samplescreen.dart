import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/models/admin_model.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  FireStoreServices fireStoreServices = FireStoreServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreServices.getFirebaseDetails();
  }

  @override
  Widget build(BuildContext context) {
    log("placeModelListeners length :${placeModelListener.value.length}");
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample Page"),
        ),
        body: ValueListenableBuilder(
            valueListenable: placeModelListener,
            builder: (context, value, child) {
              return ListView.builder(
                  itemCount: placeModelListener.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    PlaceModel firestorData = placeModelListener.value[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.yellow,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.network(firestorData.mainImage),
                              Text(firestorData.place),
                              SizedBox(
                                height: 10,
                              ),
                              Text(firestorData.district),
                              SizedBox(
                                height: 10,
                              ),
                              Text(firestorData.location),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
