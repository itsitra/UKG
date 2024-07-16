import 'package:shared_preferences/shared_preferences.dart';

import 'prereq.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Wel extends StatefulWidget {
  const Wel({Key? key}) : super(key: key);
  static String ver = "";
  @override
  State<Wel> createState() => Del();
}

class Del extends State<Wel> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode focus1 = FocusNode();
  final FocusNode focus2 = FocusNode();
  var logtext = "";
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/dashboard.jpg"),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              SizedBox(
                height: heightconv(125),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 5,
                  ),
                  const Text(
                    "SITRA",
                    style: TextStyle(
                        color: Color.fromARGB(255, 102, 50, 0), fontSize: 88),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 5,
                  ),
                  const Text(
                    "UKG CALCULATIONS",
                    style: TextStyle(
                        color: Color.fromARGB(255, 102, 50, 0), fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: heightconv(50),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 4,
                  ),
                  const Text(
                    "USER LOGIN ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 202, 2, 2), fontSize: 35),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: heightconv(25),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 4,
                  ),
                  SizedBox(
                    width: widthconv(200),
                    child: TextField(
                      focusNode: focus1,
                      controller: _controller,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 218, 105, 0),
                        hintText: 'Enter your user ID',
                        hintStyle: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightconv(10),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 4,
                  ),
                  SizedBox(
                    width: widthconv(200),
                    child: TextField(
                      obscureText: true,
                      controller: _controller2,
                      focusNode: focus2,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 218, 105, 0),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightconv(10),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 4,
                  ),
                  SizedBox(
                    width: widthconv(200),
                    child: ElevatedButton(
                      onPressed: () async {
                        focus1.unfocus();
                        focus2.unfocus();
                        var dio = Dio();
                        var temp1 = _controller.text;
                        var temp2 = _controller2.text;
                        var link =
                            "http://sitraonline.org.in/onlineserviceapi/index.php/api/validate_user_login/$temp1/$temp2/";
                        print(link);
                        var data = await dio.get(
                            "http://sitraonline.org.in/onlineserviceapi/index.php/api/validate_user_login/$temp1/$temp2/");
                        var map = jsonDecode(data.data.toString());

                        print(map);
                        if (map == "TRUE") {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          //prefs.remove('Logged');
                          prefs.setString('Logged', "Y");
                          print(prefs.getString('Logged').toString());
                          prefs.setString('UserID', temp1);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Prereq()));
                        } else {
                          setState(() {
                            logtext = "Unable to find your account";
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 102, 50, 0)),
                      ),
                      child: const Text('Verify'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightconv(20),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenheight / 4,
                  ),
                  Text(
                    logtext,
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 253, 253),
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
