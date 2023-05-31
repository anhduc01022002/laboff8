import 'package:flutter/material.dart';

void main() {
  runApp(KenoApp());
}

class KenoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Keno Statistics')),
        body: KenoStatistics(),
      ),
    );
  }
}

class KenoStatistics extends StatelessWidget {
  final statistic = [
    Keno('Lẻ',5),
    Keno('Hoà CL',3),
    Keno('Chẵn',2),
  ];

  final int maxCount = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: statistic.map((keno) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(keno.text),
                  ),
                  Flexible(
                    flex: keno.count,
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 10.0,
                    ),
                  ),
                  Flexible(
                    flex: maxCount - keno.count,
                    fit: FlexFit.tight,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      '${keno.count} lần',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
          ],
        );
      }).toList(),
    );
  }
}

class Keno {
  final String text;
  final int count;

  Keno(this.text, this.count);
}
