import 'dart:convert';

import 'package:api_practice/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/user_row_component.dart';

class MyUserApp extends StatefulWidget {
  const MyUserApp({super.key});

  @override
  State<MyUserApp> createState() => _MyUserAppState();
}

class _MyUserAppState extends State<MyUserApp> {
  List<userModel> userInfo = [];

  Future<List<userModel>> getUserInfo() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userInfo.add(userModel.fromJson(i));
      }
      return userInfo;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Complex JSON Practice",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          )),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: getUserInfo(),
            builder: (context, AsyncSnapshot<List<userModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            RowDesign(
                                text: "Name: ", value: user.name.toString()),
                            RowDesign(
                                text: "Email: ", value: user.email.toString()),
                            RowDesign(
                                text: "Phone: ", value: user.phone.toString()),
                            RowDesign(
                                text: "City: ",
                                value: user.address!.city.toString()),
                            RowDesign(
                                text: "Compnay: ",
                                value: user.company!.name.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
