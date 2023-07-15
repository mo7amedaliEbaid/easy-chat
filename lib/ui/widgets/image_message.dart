import 'package:flutter/material.dart';
class ShowImage extends StatelessWidget {
  final String imageUrl;
  final bool ismine;

  const ShowImage({required this.imageUrl, Key? key, required this.ismine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return  Center(child: Text('Could\'t get image'));
        },),
      ),
    );
  }
}