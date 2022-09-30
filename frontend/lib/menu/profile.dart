import 'package:flutter/material.dart';

const image_url =
    'https://netabare-comic.com/wp-content/uploads/2022/05/%E3%83%AB%E3%83%95%E3%82%A3%E3%80%80%E8%A6%9A%E9%86%92.png';
const name = 'takamina';
const team = 'hoge町内会';
const mail = 'tomatomnt@gmial.com';

Widget Profile(double ratio) {
  return Center(
      child: Column(
    children: [
      SizedBox(height: 40),
      Image.network(image_url, height: 200, width: 200),
      SizedBox(height: 40 * (2 - ratio)),
      Text(name,
          style: TextStyle(fontSize: 40 * ratio, fontWeight: FontWeight.bold)),
      SizedBox(height: 40 * (2 - ratio)),
      Text('所属 : ${team}', style: TextStyle(fontSize: 20 * ratio)),
      Text('メールアドレス : ${mail}', style: TextStyle(fontSize: 20 * ratio))
    ],
  ));
}
