import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UsersModels.dart';
class UsersApi extends StatefulWidget {
  const UsersApi({super.key});

  @override
  State<UsersApi> createState() => _UsersApiState();
}

class _UsersApiState extends State<UsersApi> {
  List<UsersModels> userList=[];
  Future<List<UsersModels>> getapi() async{
    var response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){

    for(Map i in data){
      userList.add(UsersModels.fromJson(i));

    }
    return userList;

    }
    else {

      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users API'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Expanded(child: FutureBuilder(future: getapi(), builder:(context,AsyncSnapshot<List<UsersModels>> snapshot){
          return ListView.builder(itemCount: userList.length,
              itemBuilder: (context,index){


       if (snapshot.connectionState == ConnectionState.waiting) {
         return Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
         return Card(
           color: Colors.green,
           child: ListTile(
             title: Row(
               children: [
                 Text('Name:'),
                 Text(snapshot.data![index].name.toString()),
               ],
             ),
             subtitle: Row(
               children: [
                 Text('Id:'),
                 Text(snapshot.data![index].id.toString()),
                 SizedBox(width: 10,),
                 Text('Address:'),
                 Text(snapshot.data![index].address!.geo.toString()),
               ],
             ),
             trailing: Column(
               children: [
                 Text('Email'),
                 Text(snapshot.data![index].email.toString()),
               ],
             ),
           ),
         );
       }
          });
        }))
      ],),
    );
  }
}
