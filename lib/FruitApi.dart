import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FruitApi extends StatefulWidget {
  const FruitApi({super.key});

  @override
  State<FruitApi> createState() => _FruitApiState();
}

class _FruitApiState extends State<FruitApi> {
  Future<List<Photos>> fruitApi() async {
    final response = await http.get(Uri.parse('https://webhook.site/26e9a97f-32e9-4abc-a5b9-874660e0b5ab'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List<Photos> fruitList = [];
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(name: i['name'], url: i['url']);
        fruitList.add(photos);
      }
      return fruitList;
    } else {
      throw Exception('Failed to load fruits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Api'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Photos>>(
        future: fruitApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            var fruitList = snapshot.data!;
            return ListView.builder(
              itemCount: fruitList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(fruitList[index].name),
                  subtitle: Text(fruitList[index].url),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Photos {
  String name;
  String url;
  Photos({required this.name, required this.url});
}
