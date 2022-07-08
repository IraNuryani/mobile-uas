// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:request_api/style.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: Kelas4C(),
  ));
}

class Kelas4C extends StatelessWidget {
  final String ApiUrl = "https://dummyjson.com/products";
  Future<List<dynamic>> AmbilData() async {
    var result = await http.get(ApiUrl);
    return json.decode(result.body)['products'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Produk-produk Tersedia',
            style: Judul,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: AmbilData(),
          builder: (BuildContext context, AsyncSnapshot snapsot) {
            if (snapsot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapsot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapsot.data[index]['thumbnail']),
                      ),
                      title: Text(
                        snapsot.data[index]['title'] +
                            " || ( " +
                            snapsot.data[index]['category'] +
                            " )",
                        style: Titlle,
                      ),
                      subtitle: Text(
                        "Brand : ( " +
                            snapsot.data[index]['brand'] +
                            " ) || Deskripsi : ( " +
                            snapsot.data[index]['description'] +
                            " )",
                        style: Subtitle,
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
