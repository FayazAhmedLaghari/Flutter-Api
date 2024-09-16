import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Photos.dart';
class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<Photos> photoList=[];
  Future<List<Photos>> photoApi()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
    {
      for(Map i in data){
        photoList.add(Photos.fromJson(i));

      }
      return photoList;
    }
    else
    {
      return photoList;

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
      body: Column(
        children: [
          Expanded(child: FutureBuilder(future:photoApi() , builder:(context,snapshot){
            return ListView.builder(itemBuilder: (context,index){
              return Card(
                child: ListTile(

                  leading:CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                  subtitle:Text(snapshot.data![index].id.toString()) ,
                ),
              );
            });
          }))
        ],
      ),
    );
  }
}
//
// class Photos{
//   String title;
//   String url;
//   Photos({required this.title, required this.url});
// }
