import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
              child: Text(name.isNotEmpty ? name[0].toUpperCase() : "",style: TextStyle(fontSize: textSize)),
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
            child: Text(name.isNotEmpty ? name[0].toUpperCase() : "",style: TextStyle(fontSize: textSize)),
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<bool> isSelected = [true, false];
  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        }
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd/mm/yyyy').format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Thông tin cá nhân"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Avatar(
              name: "Anh Duc",
              avatarUrl: "https://taixiuonlineuytin.com/wp-content/uploads/2022/12/hinh-dai-dien-co-them-chu-be-hoat-hinh-nay-kha-de-thuong-va-an-tuong.jpg",
              textSize: 30.0,
              isUpload: true,
            ),
            SizedBox(height: 10),
            Text('0374016270',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Họ & tên', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nhập họ và tên',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
              ),
            ),
            SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ngày sinh', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: 'Nhập ngày sinh',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                            suffixIcon: IconButton(
                              icon: Image.asset('assets/ic_calendar.png'),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Giới tính', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 57,
                          child: ToggleButtons(
                            borderColor: Colors.black,
                            fillColor: Colors.black,
                            borderWidth: 2,
                            selectedBorderColor: Colors.black,
                            selectedColor: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Nam',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Nữ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
                                  isSelected[i] = i == index;
                                }
                              });
                            },
                            isSelected: isSelected,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Email (không bắt buộc)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            TextField(
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Nhập Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
              ),
            ),
            SizedBox(height: 0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Địa chỉ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            TextField(
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Nhập địa chỉ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                ),
                onPressed: () {},
                child: Text('Lưu thay đổi', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', 'US'),
    ],
  ));
}
