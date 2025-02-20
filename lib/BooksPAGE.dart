import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Books.dart';

class BooksListPage extends StatefulWidget {
  @override
  _BooksListPageState createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  Future<List<Items>> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['items'];
      return data.map((json) => Items.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: FutureBuilder<List<Items>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Items> books = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookTile(book: books[index]);
              },
            );
          } else {
            return Center(child: Text('No books available'));
          }
        },
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  final Items book;
  BookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    final volumeInfo = book.volumeInfo;
    return Card(
      color: Colors.green,
      elevation: 3,
      child: Column(
        children: [
          // Check if imageLinks is not null and has a valid 'thumbnail'
          // volumeInfo?.imageLinks != null &&
          //         volumeInfo!.imageLinks!.thumbnail != null
          //     ? CachedNetworkImage(
          //         imageUrl: volumeInfo.imageLinks!.thumbnail!,
          //         placeholder: (context, url) => CircularProgressIndicator(),
          //         errorWidget: (context, url, error) => Icon(Icons.error),
          //       )
          //     : Icon(Icons.image_not_supported),

          // Display book title
          Text(volumeInfo?.title ?? 'No Title Available'),

          // Display authors (if available)
          Text(volumeInfo?.authors?.join(', ') ?? 'No Author Available'),

          // Display categories (if available)
          Text(volumeInfo?.categories?.join(', ') ?? 'No Categories Available'),
          Text(volumeInfo?.language?.toString() ?? 'No Categories Available'),
        ],
      ),
    );
  }
}
