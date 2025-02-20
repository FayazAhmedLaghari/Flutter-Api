import 'dart:convert';
import 'package:flutter_api/Books.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
Future<List<Books>> fetchBooks() async {
  final response = await http
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['items'];
    return data.map((json) => Books.fromJson(json['volumeInfo'])).toList();
  } else {
    throw Exception('Failed to load books');
  }
}
