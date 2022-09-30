import 'package:flutter/material.dart';

Widget BulletinBoard(double ratio, void fetch, dynamic contentsList) {
  return Column(children: [
    for (var i = 0; i < contentsList.length; i++)
      Container(
          padding: EdgeInsets.all(15),
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(3)),
          child: Column(children: [
            if (contentsList.length > 0)
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(contentsList[i]["fields"]["date"],
                    style: TextStyle(fontSize: 14 * ratio)),
              ]),
            if (contentsList.length > 0)
              Text(contentsList[i]["fields"]["title"],
                  style: TextStyle(
                      fontSize: 20 * ratio, fontWeight: FontWeight.w800)),
            SizedBox(height: 20),
            // from ~　は　配列に入っているため指定してあげる
            if (contentsList.length > 0)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  '${contentsList[i]["fields"]["organization_name (from organization)"][0]}各位',
                  style: TextStyle(fontSize: 10 * ratio),
                  textAlign: TextAlign.right,
                ),
              ]),
            SizedBox(height: 10),
            if (contentsList.length > 0)
              Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(contentsList[i]["fields"]["content"],
                      style: TextStyle(fontSize: 14 * ratio))),
            SizedBox(
              height: 100,
            )
          ]))
  ]);
}
/*
Widget _documentContent(dynamic contentsList) {
  if (contentsList.length > 0) {
    for (var i = 0; i < 3; i++) {
      return Column(children: [
        Text(contentsList[i]["fields"]["title"]),
        Text(contentsList[i]["fields"]["content"]),
/*         Text(contentsList[0]["fields"]["name (from autor)"]) */
      ]);
    }
  }
  return Text("error");
}*/
