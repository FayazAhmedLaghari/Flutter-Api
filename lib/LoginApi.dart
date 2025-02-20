// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
//
// class Utils {
//   void showToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }
// class LoginApi extends StatefulWidget {
//   const LoginApi({super.key});
//
//   @override
//   State<LoginApi> createState() => _LoginApiState();
// }
//
// class _LoginApiState extends State<LoginApi> {
//   final Utils ts = Utils();
//
//   Future<void> Login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://reqres.in/api/login'),
//         body: {
//           "email": email,
//           "password": password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body.toString());
//         print(data);
//         print('Success');
//         ts.showToast('Login Successfully');
//       } else {
//         ts.showToast('Failed!');
//         print('Failed');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Api'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: 'Email',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 hintText: 'Password',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {
//                   Login(emailController.text, passwordController.text);
//                 },
//                 child: Container(
//                   color: Colors.green,
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   child: Center(child: Text('Login')),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
