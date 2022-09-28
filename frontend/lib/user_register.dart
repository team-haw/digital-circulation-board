import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

fetchList() async {
  final dio = Dio();
  const url =
      'https://api.airtable.com/v0/appG0X7Egx1XCDWkr/users?api_key=keyrmU6zPEdCXGPXv';
  var response = await dio.get(url);
  try {
    final datas = response.data;
    print(datas);
  } catch (e) {
    print(e);
  }
  ;
}

class UserRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () => {fetchList()}, child: Text('fetch')),
      ],
    );
  }
}
