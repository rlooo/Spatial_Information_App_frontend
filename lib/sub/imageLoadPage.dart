import 'package:flutter/material.dart';

class ImageLoadPage extends StatefulWidget {
  @override
  State<ImageLoadPage> createState() => _ImageLoadPageState();
}

class _ImageLoadPageState extends State<ImageLoadPage> {
  String imageUrl =
      'http://10.0.2.2:8000/media/media/putout/scaled_image_picker3614051294157898634.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello")),
      body: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(border: Border.all()),
        child: Image.network(
          imageUrl,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset('images/default.PNG', fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}
