import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/models/admin_model.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPageImage extends StatefulWidget {
  PlaceModel? place;
  BuildContext? context;

  DetailsPageImage({super.key, required this.place, required this.context});

  @override
  State<DetailsPageImage> createState() => _DetailsPageImageState();
}

class _DetailsPageImageState extends State<DetailsPageImage> {
  int picture = 0;
  bool fevorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                    items: widget.place?.subImage.map((images) {
                      return CachedNetworkImage(
                        imageUrl: widget.place!.subImage[picture],
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple[100],
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          picture = index;
                        });
                      },
                    )),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: transperant,
                    radius: 25,
                    child: IconButton(
                      onPressed: () async {
                        fevorite
                            ? setState(() {
                                fevorite = false;
                              })
                            : setState(() {
                                fevorite = true;
                              });
                              SharedPreferences prefz = await SharedPreferences.getInstance();
                              final userId = prefz.getString("currentuserId");
                              final fevs = FevoriteModel(
                                id: widget.place!.id,
                               fevoritePlace: widget.place!.id,
                                userId: userId!);
                              fevorite ?
                              addFevorite(fevoritePlace: fevs):
                              removeFevorite(fevoritePlace: widget.place!.id);
                              
                      },
                      icon: fevorite
                          ? Icon(
                              Icons.favorite,
                              color: red,
                            )
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
        Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.place!.subImage.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              picture = index;
                            });
                          },
                          child: index == picture
                              ? Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                          color: primaryColor, width: 3)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.place!.subImage[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.purple[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.place!.subImage[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.purple[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    }),
              ),
            )),
      ],
    );
  }
}
