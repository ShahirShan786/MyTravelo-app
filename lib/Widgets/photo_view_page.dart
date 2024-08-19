import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatelessWidget {
  final List<String> photos;
  final int index;
  const PhotoViewPage({super.key, required this.photos, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder: ((context, index) => PhotoViewGalleryPageOptions.customChild(
            child: CachedNetworkImage(
              imageUrl: photos[index],
              placeholder: (context, url) => CircularProgressIndicator(
                color: indicatorColor,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: red,
              ),
            ),
            minScale: PhotoViewComputedScale.covered)),
        pageController: PageController(initialPage: index),
        enableRotation: true,
      ),
    );
  }
}
