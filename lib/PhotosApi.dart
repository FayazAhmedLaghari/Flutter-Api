import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Photos.dart';
class Photos {
  final int id;
  final String title;
  final String url;
  Photos({required this.id, required this.title, required this.url});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}

class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  Future<List<Photos>> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Photos.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos API'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Photos>>(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No photos available'));
          } else {
            List<Photos> photos = snapshot.data!;
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 45, 231, 51),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:NetworkImage(photos[index].url.toString()),
                    ),
                    title: Text(photos[index].title.toString()),
                    subtitle: Text(photos[index].id.toString()),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
