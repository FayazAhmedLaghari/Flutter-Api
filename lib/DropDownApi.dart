import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DropdowonApModeli.dart';

class DropDownApi extends StatefulWidget {
  const DropDownApi({super.key});

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {
  var selectedValue;

  Future<List<DropdowonApiModel>> dropdowonApiFun() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic e) {
          final map = e as Map<String, dynamic>;
          return DropdowonApiModel(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      } else {
        // Handle non-200 responses
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Return an empty list or handle error accordingly
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown Api'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.cyanAccent,
      ),
      body: FutureBuilder<List<DropdowonApiModel>>(
        future: dropdowonApiFun(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return DropdownButton<String>(
              value: selectedValue,
              hint: Text('Select Value'),
              items: snapshot.data!.map((e) {
                return DropdownMenuItem<String>(
                  value: e.id.toString(),
                  child: Text(e.id.toString() ?? 'No Title'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
