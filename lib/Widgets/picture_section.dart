import 'package:flutter/material.dart';

class PictureSection extends StatelessWidget {
  const PictureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://media.istockphoto.com/id/1281421659/photo/waterfall-falling-from-mountain-too-at-morning-from-low-angle.webp?b=1&s=170667a&w=0&k=20&c=H-I9RBOy44ZRSkL_0ztHVf9Omv5rU0t4zOB4jgs2r_4=",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://media.istockphoto.com/id/1082144686/photo/athirapally-falls.webp?b=1&s=170667a&w=0&k=20&c=oM-YqsNAb1AJwW_xzrppD0KzniyqC9s0exP6U4sV7E4=",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://media.istockphoto.com/id/1281421638/photo/girl-watching-the-waterfall-falling-from-mountain-too-at-morning-from-low-angle.webp?b=1&s=170667a&w=0&k=20&c=-vVyn8dr7yj3YIzJa9hao1ZYFsQveqJZMBSHsqPmKHY=",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://images.unsplash.com/photo-1668521801976-abd776daaa51?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXRoaXJhcGFsbHklMjB3YXRlcmZhbGx8ZW58MHx8MHx8fDA%3D",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
