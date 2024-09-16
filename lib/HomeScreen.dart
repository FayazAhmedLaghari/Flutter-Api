import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostsModel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  List<PostsModel> postList=[];
  Future<List<PostsModel>> postsApi()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
              for(Map i in data){
                postList.add(PostsModel.fromJson(i));
              }
              return postList;
      }
    else
      {
        return postList;

      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body:Center(
        child: Column(
          children: [
             Expanded(
               child: FutureBuilder(future:postsApi() , builder:(context,snapshot){
                     return ListView.builder(itemCount: postList.length,
                         itemBuilder: (context,index){
                       return Card(
                         color: Colors.green,
                         elevation: 3,
                         child: ListTile(
                             title: Text(postList[index].id.toString()),
                             subtitle: Text(postList[index].title!.length.toString()),
                           trailing: Text(postList[index].userId!.toString()),
                         ),
                       );
                     });

               }),
             )
          ],
        ),
      ),
    );
  }
}
