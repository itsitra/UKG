import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ukgoe extends StatefulWidget {
  const ukgoe({Key? key}) : super(key: key);
  static String ver = "";
  @override
  State<ukgoe> createState() => _ukgoe();
}

var colon11 = "";
var lhs000 = "";
var lhs111 = "";
var lhs222 = "";
var lhs333 = "";
var rhs000 = "";
var rhs111 = "";
var rhs222 = "";
var rhs333 = "";

class _ukgoe extends State<ukgoe> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode focus1 = FocusNode();
  FocusNode _focusNode = FocusNode();
  var val = "-1";
  List<String> lhs = [];
  List<String> rhs = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    double screenheight = MediaQuery.of(context).size.width;
    double heightconv(double arg) {
      return screenWidth * (arg / 781.09);
    }

    double widthconv(double arg) {
      return screenheight * (arg / 392.7);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('SITRA’s Std 10s UKG CF',
              style: TextStyle(fontSize: widthconv(14))),
          backgroundColor: Color.fromARGB(255, 102, 50, 0),
          actions: [
            // Define the action button here
            IconButton(
              icon: Icon(Icons.help), // Icon for the button
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Return an AlertDialog widget as the content of the dialog.
                    return AlertDialog(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      title: Text(
                        "Help",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        """C-Combed | H-Hoisery | K-Carded | Comp-Compact | PC-Polyester Cotton | HT-High Twist | PSF-Polyester Staple Fibre | PV-Polyester Viscose | VSF-Viscose Staple Fibre""",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Close the dialog when the "OK" button is pressed.
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }, // Callback when the button is pressed
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/whitedash.jpg"),
                      fit: BoxFit.cover)),
            ),
            Column(
              children: [
                SizedBox(
                  height: heightconv(150),
                ),
                SizedBox(
                  height: heightconv(55),
                  width: widthconv(300),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 102, 50, 0),
                    ),
                    style:
                        TextStyle(color: Colors.white, fontSize: widthconv(18)),
                    focusColor: const Color.fromARGB(255, 102, 50, 0),
                    dropdownColor: const Color.fromARGB(255, 102, 50, 0),
                    value: val,
                    items: [
                      DropdownMenuItem(
                          value: "-1",
                          child: SizedBox(
                            width: widthconv(250),
                            child: const Opacity(
                              opacity: 1,
                              child: Text(
                                "    Yarn type ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          )),
                      const DropdownMenuItem(value: "1", child: Text(" K ")),
                      const DropdownMenuItem(
                        value: "2",
                        child: Text(" PC "),
                      ),
                    ],
                    onChanged: (v) {
                      setState(() {
                        val = v.toString();
                        focus1.requestFocus();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: heightconv(10),
                ),
                SizedBox(
                  width: widthconv(300),
                  child: TextField(
                    focusNode: focus1,
                    controller: _controller2,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 102, 50, 0),
                      hintText: 'Enter count',
                      hintStyle: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: heightconv(20),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenheight / 5,
                    ),
                    SizedBox(
                      width: widthconv(100),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (val != "-1" &&
                              _controller2.text != null &&
                              int.parse(_controller2.text) > 1 &&
                              int.parse(_controller2.text) < 36) {
                            lhs = [];
                            rhs = [];
                            var yarn;
                            if (val == "1") {
                              yarn = "K";
                            }
                            if (val == "2") {
                              yarn = "PC";
                            }
                            var count = _controller2.text;
                            focus1.unfocus();
                            var mapnames, mapvalues;
                            var dio = Dio();
                            var link =
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_sitra_ukg_factors_oe/$count/$yarn/";
                            print(link);
                            var data = await dio.get(
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_sitra_ukg_factors_oe/$count/$yarn/");
                            var map = jsonDecode(data.data.toString());
                            String names = jsonEncode(map["name"]);
                            mapnames = jsonDecode(names);
                            mapnames.forEach((key, value) {
                              lhs.add(value.toString());
                            });
                            String values = jsonEncode(map["value"]);
                            mapvalues = jsonDecode(values);
                            mapvalues.forEach((key, value) {
                              rhs.add(value.toString());
                            });
                            print(lhs);
                            print(rhs);
                            setState(() {
                              lhs000 = lhs[0];
                              lhs111 = lhs[1];
                              lhs222 = lhs[2];
                              lhs333 = lhs[3];
                              rhs000 = rhs[0];
                              rhs111 = rhs[1];
                              rhs222 = rhs[2];
                              rhs333 = rhs[3];
                              colon11 = ":";
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Return an AlertDialog widget as the content of the dialog.
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 102, 50, 0),
                                    title: Text(
                                      "Warning :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      "Inputs not in range ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          // Close the dialog when the "OK" button is pressed.
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Close',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenheight / 10,
                    ),
                    SizedBox(
                      width: widthconv(100),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _controller2.text = "";
                            val = "-1";
                            colon11 = "";
                            lhs000 = "";
                            lhs111 = "";
                            lhs222 = "";
                            lhs333 = "";
                            rhs000 = "";
                            rhs111 = "";
                            rhs222 = "";
                            rhs333 = "";
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: heightconv(40),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "10s UKG Conversion Factor :",
                    style: TextStyle(
                        color: Color.fromARGB(255, 102, 50, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: heightconv(20),
                ),
                Container(
                  color: Color.fromARGB(0, 102, 50, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: heightconv(20),
                      ),
                      Row(children: [
                        SizedBox(
                          width: widthconv(30),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              lhs000,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              colon11,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              rhs000,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: heightconv(10),
                      ),
                      Row(children: [
                        SizedBox(
                          width: widthconv(30),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              lhs111,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              colon11,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              rhs111,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: heightconv(10),
                      ),
                      Row(children: [
                        SizedBox(
                          width: widthconv(30),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              lhs222,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              colon11,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              rhs222,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: heightconv(10),
                      ),
                      Row(children: [
                        SizedBox(
                          width: widthconv(30),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              lhs333,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              colon11,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight / 4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              rhs333,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: heightconv(20),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenWidth - (screenWidth / 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: widthconv(314.16),
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: widthconv(10)),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
