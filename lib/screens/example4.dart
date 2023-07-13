// JSON with space in Key, e.g user name or company name

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  var data = [];
  Future getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera,
              color: Colors.white,
              size: 27,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "JSON with Errors",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: getPhotos(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[300],
                      ),
                      child: Column(
                        children: [
                          RowDesign(
                            text: "ID: ",
                            value: snapshot.data[index]['id'].toString(),
                            img:
                                snapshot.data[index]['thumbnailUrl'].toString(),
                          ),
                          RowDesign(
                            text: "Title: ",
                            value: snapshot.data[index]['title'].toString(),
                            img:
                                snapshot.data[index]['thumbnailUrl'].toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          })),
    );
  }
}

class RowDesign extends StatelessWidget {
  const RowDesign(
      {Key? key, required this.text, required this.value, required this.img})
      : super(key: key);

  final String text, value, img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                value,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Image.network(
            img,
          ),
        ],
      ),
    );
  }
}
