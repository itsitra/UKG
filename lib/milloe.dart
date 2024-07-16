import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class milloe extends StatefulWidget {
  const milloe({Key? key}) : super(key: key);
  static String ver = "";
  @override
  State<milloe> createState() => _milloe();
}

var colon111 = "";
var lhs0000 = "";
var lhs1111 = "";
var lhs2222 = "";
var lhs3333 = "";
var rhs0000 = "";
var rhs1111 = "";
var rhs2222 = "";
var rhs3333 = "";

class _milloe extends State<milloe> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final FocusNode focus1 = FocusNode();
  final FocusNode focus2 = FocusNode();
  final FocusNode focus3 = FocusNode();
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
          title: Text('10s UKG CF adj. to Mill Parameters',
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
                  height: heightconv(100),
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
                      )
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
                    controller: _controller,
                    inputFormatters: [LengthLimitingTextInputFormatter(5)],
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
                  height: heightconv(10),
                ),
                SizedBox(
                  width: widthconv(300),
                  child: TextField(
                    focusNode: focus2,
                    controller: _controller2,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 102, 50, 0),
                      hintText: 'Enter mill spindle speed (RPM)',
                      hintStyle: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: heightconv(10),
                ),
                SizedBox(
                    width: widthconv(300),
                    child: TextField(
                      focusNode: focus3,
                      controller: _controller3,
                      inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 102, 50, 0),
                        hintText: 'Enter Mill TM',
                        hintStyle: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.number,
                    )),
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
                          lhs = [];
                          rhs = [];
                          if (val != -1 &&
                              double.parse(_controller.text) > 1 &&
                              double.parse(_controller.text) < 36 &&
                              double.parse(_controller2.text) > 49999 &&
                              double.parse(_controller2.text) < 120001 &&
                              double.parse(_controller3.text) > 3 &&
                              double.parse(_controller3.text) < 7 &&
                              _controller2.text != null &&
                              _controller.text != null &&
                              _controller3.text != null) {
                            setState(() {
                              lhs0000 = "";
                              lhs1111 = "";
                              lhs2222 = "";
                              lhs3333 = "";
                              rhs0000 = "";
                              rhs1111 = "";
                              rhs2222 = "";
                              rhs3333 = "";
                              colon111 = "";
                            });
                            focus1.unfocus();
                            focus2.unfocus();
                            focus3.unfocus();
                            var yarn;
                            if (val == "1") {
                              yarn = "K";
                            }
                            if (val == "2") {
                              yarn = "PC";
                            }
                            var count = _controller.text;
                            var speed = _controller2.text;
                            var tpi = _controller3.text;
                            var mapnames, mapvalues;
                            var dio = Dio();
                            var link =
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_sitra_ukg_factors_oe/$count/$yarn/$speed/$tpi/";
                            print(link);
                            var data = await dio.get(
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukgmill_factors_oe/$count/$yarn/$speed/$tpi/");
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
                              lhs0000 = lhs[0];
                              lhs1111 = lhs[1];
                              lhs2222 = lhs[2];
                              lhs3333 = lhs[3];
                              rhs0000 = rhs[0];
                              rhs1111 = rhs[1];
                              rhs2222 = rhs[2];
                              rhs3333 = rhs[3];
                              colon111 = ":";
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
                            _controller.text = "";
                            _controller3.text = "";
                            val = "-1";
                            colon111 = "";
                            lhs0000 = "";
                            lhs1111 = "";
                            lhs2222 = "";
                            lhs3333 = "";
                            rhs0000 = "";
                            rhs1111 = "";
                            rhs2222 = "";
                            rhs3333 = "";
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
                              lhs0000,
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
                              colon111,
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
                              rhs0000,
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
                              lhs1111,
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
                              colon111,
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
                              rhs1111,
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
                              lhs2222,
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
                              colon111,
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
                              rhs2222,
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
                              lhs3333,
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
                              colon111,
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
                              rhs3333,
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
