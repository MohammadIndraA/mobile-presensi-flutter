import 'dart:convert';

import 'package:smart_presence/app/models/UserModel.dart';
import 'package:smart_presence/contans.dart';
import 'package:http/http.dart' as http;

void main() {
  getData();
}

Future getData() async {
  try {
    var response = await http.get(
      Uri.parse("${URL}user/data/1111111111"),
      headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer VAsdtcuicbg08c2vfB3QmxRistBbZuenBxdbYKk147de1e83',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> dataUser = json.decode(response.body);
      if (dataUser.isEmpty) {
        return [];
      } else {
        print(dataUser);
        return UserModel.fromJson(dataUser as Map<String, dynamic>);
      }
    } else {
      print(json.decode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
}
