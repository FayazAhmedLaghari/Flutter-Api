//
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// class ImageUplaodServer extends StatefulWidget {
//   const ImageUplaodServer({super.key});
//   @override
//   State<ImageUplaodServer> createState() => _ImageUplaodServerState();
// }
// class _ImageUplaodServerState extends State<ImageUplaodServer> {
//   File? image;
//   final _imagepicker = ImagePicker();
//   bool showSpinner = false;
//   Future getImage() async {
//     final pickedFile = await _imagepicker.pickImage(
//         source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         image = File(pickedFile.path);
//       });
//     } else {
//       print('No image selected');
//     }
//   }
//   Future<void> UploadImage() async {
//     setState(() {
//       showSpinner = true;
//     });
//
//     if (image == null) {
//       // Handle the case when no image is selected
//       setState(() {
//         showSpinner = false;
//       });
//       return;
//     }
//
//     var stream = http.ByteStream(image!.openRead());
//     var length = await image!.length();
//     var url = Uri.parse(
//         'https://fakestoreapi.com/products'); // Ensure this URL is correct for your server
//     var request = http.MultipartRequest('POST', url);
//     request.fields['title'] = 'static title';
//
//     var multiport = http.MultipartFile(
//       'images',
//       stream,
//       length,
//       filename: image!
//           .path
//           .split('/')
//           .last,
//     );
//     request.files.add(multiport);
//     try {
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         // Success handling
//         print('Image uploaded successfully');
//       } else {
//         // Error handling
//         print('Failed to upload image: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred while uploading image: $e');
//     } finally {
//       setState(() {
//         showSpinner = false;
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: showSpinner,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('IMAGE Upload Screen'),
//           backgroundColor: Colors.amber,
//           foregroundColor: Colors.indigo,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 getImage();
//               },
//               child: Container(
//                 child: image == null
//                     ? Center(child: Text('No Image Selected'))
//                     : Image.file(
//                   image!,
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {
//                   UploadImage();
//                 },
//                 child: Container(
//                   color: Colors.green,
//                   height: 40,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width,
//                   child: Center(child: Text('Upload')),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }