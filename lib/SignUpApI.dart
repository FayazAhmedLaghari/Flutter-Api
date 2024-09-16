import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUpApi extends StatefulWidget {
  const SignUpApi({super.key});

  @override
  State<SignUpApi> createState() => _SignUpApiState();
}
class _SignUpApiState extends State<SignUpApi> {

  Future<void> Login(String email,String password) async {
    try{
      Response response=await post(
        Uri.parse('https://reqres.in/api/register'),
        body:{
          "email":email,
          "password":password,
        }
      );
      if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data);
        print(data['id']);
        print(data['token']);
        print('Registeration Successfully');
      }
      else
        {
          print('Fail');
        }
    }
    catch(e){
      print(e);
    }
  }
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Api'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Login(emailController.text.toString(),passwordController.text.toString());
                },
                child: Container(
                  color: Colors.green,
                  height: 40,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(child: Text('Regsiter')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
