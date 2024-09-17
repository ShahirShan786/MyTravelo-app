import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/photo_view_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Admin-screens/admin_edit_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPageImage extends StatefulWidget {
  PlaceModel? place;
  bool isActive;
  BuildContext? context;
  int? index;

  DetailsPageImage({super.key, required this.place, required this.context , required this.isActive , this.index});
 
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
                  options: CarouselOptions(
                    height: 350.h,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        picture = index;
                      });
                    },
                  ),
                  items: widget.place?.subImage.map((images) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhotoViewPage(
                              photos: widget.place!.subImage, index: picture),
                        ));
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.place!.subImage[picture],
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple[100],
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                widget.isActive ?
                  Positioned(
                  top: 40.h,
                  right: 20.w,
                  child: CircleAvatar(
                    backgroundColor: transperant,
                    radius: 25.sp,
                    child: IconButton(
                      onPressed: () async {
                        fevorite
                            ? setState(() {
                                fevorite = false;
                              })
                            : setState(() {
                                fevorite = true;
                              });
                        SharedPreferences prefz =
                            await SharedPreferences.getInstance();
                        final userId = prefz.getString("currentuserId");
                        final fevs = FevoriteModel(
                            id: widget.place!.id,
                            fevoritePlace: widget.place!.id,
                            userId: userId!);
                        fevorite
                            ? addFevorite(fevoritePlace: fevs)
                            : removeFevorite(fevoritePlace: widget.place!.id);
                      },
                      icon: fevorite
                          ? const Icon(
                              Icons.favorite,
                              color: red,
                            )
                          : const Icon(Icons.favorite_border),
                    ),
                  ),
                ): 
                Positioned(
                  top: 40.h,
                  right: 20.w,
                  child: CircleAvatar(
                    backgroundColor: white,
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => AdminEditPlaceScreen(firebasePlaceModel: widget.place, index: widget.index),));
                  },
                   icon: const Icon(Icons.edit)),
                ))
                
              ]
            ),
             SizedBox(
              height: 70.h,
            )
          ],
        ),
        Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90.h,
              decoration:  BoxDecoration(
                  color: white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r))),
              child: Padding(
                padding:  EdgeInsets.only(top: 5.h),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.place!.subImage.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.all(10.w),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              picture = index;
                            });
                          },
                          child: index == picture
                              ? Container(
                                  width: 80.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                      border: Border.all(
                                          color: primaryColor, width: 3.w)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
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
                              : SizedBox(
                                  width: 80.w,
                                  height: 50.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
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
