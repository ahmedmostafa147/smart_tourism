// import 'package:flutter/material.dart';

// class EditPersonalData extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("My Account"),
//           backgroundColor: Colors.blueGrey.shade700,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               // Center(
//               //   child: CircleAvatar(
//               //     backgroundImage: AssetImage("assets/images/pic1.jpg"),
//               //     radius: 60.0,
//               //   ),
//               // ),
//               Container(
//                 width: 130,
//                 height: 130,
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 4, color: Colors.white),
//                   boxShadow: [
//                     BoxShadow(
//                       spreadRadius: 2,
//                       blurRadius: 10,
//                       color: Colors.black.withOpacity(0.1),
//                     )
//                   ],
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage("assets/images/pic1.jpg"),
//                   )
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       width: 4,
//                       color: Colors.white,
//                     ),
//                     color: Colors.amberAccent,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'User name',
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password',
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Phone Number',
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Interests',
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class EditPersonalData extends StatefulWidget {
  @override
  State<EditPersonalData> createState() => _EditPersonalDataState();
}

class _EditPersonalDataState extends State<EditPersonalData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.blueGrey.shade700,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/pic1.jpg"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15.0,
                        right: 110.0,
                        child: GestureDetector(
                          onTap: () {
                            // Handle the edit icon tap
                          },
                          child: Container(
                            // height: 40,
                            // width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: Colors.amberAccent,
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Handle button press
                              },
                              icon: ClipOval(
                                child: Image.asset(
                                  'assets/images/pic3.png',
                                  width: 40, // Set the width as needed
                                  height: 40, 
                                  fit: BoxFit.cover,
                                  // Set the height as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Card(
                    child: ListTile(
                      title: Text("suhaila"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
