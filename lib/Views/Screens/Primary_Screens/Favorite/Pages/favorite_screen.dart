import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Favorite/widgets/favorite_place_card_widget.dart';
import 'package:my_travelo_app/Views/Screens/Sub_Screens/place_details_screen.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';

import 'package:my_travelo_app/constants/constable.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    userRefresh();
  }

  @override
  Widget build(BuildContext context) {
    log("fevoriteList length is : ${fevoriteList.value.length}");

    return Scaffold(
      appBar: const PrimaryAppBar(
        titles: "Saved Trips",
        backgroundColors: BoxColor,
      ),
      body: Padding(
          padding: EdgeInsets.all(10.w),
          child: ValueListenableBuilder(
              valueListenable: fevoriteList,
              builder: (context, value, child) {
                return fevoriteList.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: fevoriteList.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final fav = fevoriteList.value[index];
                          return InkWell(
                            onTap: () {
                              
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlaceDetailsScreen(
                                  index: index,
                                  fav: true,
                                ),
                              ));
                            },
                            child: buildFavePlaceCard(fav: fav),
                          );
                        })
                    : const Center(
                        child: Text("No Favorite"),
                      );
              })),
    );
  }
}

