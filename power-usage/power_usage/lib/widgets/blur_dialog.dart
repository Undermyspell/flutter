//  showDialog(
//             context: context,
//             builder: (context) => new BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: AlertDialog(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0)),
//                   backgroundColor: Colors.white,
//                   content: Container(
//                     height: MediaQuery.of(context).size.height / 2,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   actions: [
//                     FlatButton(
//                       child: Text("ok"),
//                       onPressed: () {},
//                     ),
//                     FlatButton(
//                       child: Text("cancel"),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     )
//                   ],
//                 )),
//           );