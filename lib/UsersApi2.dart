import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UsersApi2 extends StatefulWidget {
  const UsersApi2({super.key});

  @override
  State<UsersApi2> createState() => _UsersApi2State();
}
class _UsersApi2State extends State<UsersApi2> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getApi();
  }

  Future<List<dynamic>> getApi() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Api2'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
               // var user = data[index];
                return Card(
                  color: Colors.orange,
                  child: ListTile(
                    title: Text(data[index]['name'].toString()),
                    subtitle: Text(data[index]['id'].toString()),
                    trailing: Text(data[index]['address']['geo'].toString()),
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
