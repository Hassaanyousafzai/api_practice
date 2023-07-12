import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/nba_model.dart';

class NBAHome extends StatefulWidget {
  const NBAHome({super.key});

  @override
  State<NBAHome> createState() => _NBAHomeState();
}

class _NBAHomeState extends State<NBAHome> {
  List<NBA> nbaList = [];
  Future getNBA() async {
    var response =
        await http.get(Uri.parse('https://www.balldontlie.io/api/v1/players'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final player = NBA(
        firstname: eachTeam['first_name'],
        lastname: eachTeam['last_name'],
      );
      nbaList.add(player);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sports_basketball),
            SizedBox(
              width: 20,
            ),
            Text("NBA Players")
          ],
        ),
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: FutureBuilder(
          future: getNBA(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: nbaList.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Center(
                            child: Text(
                                "First Name: ${nbaList[index].firstname}")),
                        subtitle: Center(
                            child:
                                Text("Last Name: ${nbaList[index].lastname}")),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
