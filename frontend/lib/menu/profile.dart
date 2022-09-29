import 'package:flutter/material.dart';

const image_url =
    'https://1.bp.blogspot.com/-tVeC6En4e_E/X96mhDTzJNI/AAAAAAABdBo/jlD_jvZvMuk3qUcNjA_XORrA4w3lhPkdQCNcBGAsYHQ/s400/onepiece01_luffy.png';
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
