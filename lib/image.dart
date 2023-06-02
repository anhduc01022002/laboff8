import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class Avatar extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final bool isUpload;
  final double textSize;
  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.black87];

  Avatar({required this.name, this.avatarUrl, this.isUpload = false, this.textSize = 30.0});

  @override
  Widget build(BuildContext context) {
    final Color randomColor = colors[Random().nextInt(colors.length)];
    return Stack(
      children: [
        if (avatarUrl != null)
          CachedNetworkImage(
            imageUrl: avatarUrl!,
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: randomColor,
              radius: 50,
              child: Text(name[0].toUpperCase(),style: TextStyle(fontSize: textSize)),
            ),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
            ),
          )
        else
          CircleAvatar(
            backgroundColor: randomColor,
            radius: 50,
            child: Text(name[0].toUpperCase(),style: TextStyle(fontSize: textSize)),
          ),
        if (isUpload)
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.file_upload_outlined, color: Colors.red),
            ),
          ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Avatar(
                name: "Anh Duc",
                avatarUrl: "https://taixiuonlineuytin.com/wp-content/uploads/2022/12/hinh-dai-dien-co-them-chu-be-hoat-hinh-nay-kha-de-thuong-va-an-tuong.jpg",
                //có thể thêm chữ cái bất kì vào link để hiện ava có chữ cái đầu
                isUpload: true,
              ),
              SizedBox(height: 10),
              Text('0374016270', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
