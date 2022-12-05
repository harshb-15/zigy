import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zigy/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>?> getUsers() async {
    try {
      var url = Uri.parse('https://reqres.in/api/users?page=2');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data);
        List<dynamic> usersJson = data['data'];
        List<User> users = usersJson.map((e) => User.fromJson(e)).toList();
        return users;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<String>?> addUser(String name, String job) async {
    try {
      var url = Uri.parse('https://reqres.in/api/users');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      );
      if(response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<String> createdUser = [data['name'], data['job'], data['id']];
        return createdUser;
      } else {
        return null;
      }
    } catch (e) {
      return null;
      debugPrint(e.toString());
    }
  }
}
