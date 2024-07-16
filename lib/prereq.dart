import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ukgspg.dart';
import 'millspg.dart';
import 'ukgoe.dart';
import 'milloe.dart';
import 'lookup.dart';

class Prereq extends StatefulWidget {
  const Prereq({Key? key}) : super(key: key);
  static String ver = "";
  @override
  State<Prereq> createState() => Pre();
}

class Pre extends State<Prereq> {
  final TextEditingController _controller = TextEditingController();
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

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit the application?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        return exit;
      },
      child: Scaffold(
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
                    height: heightconv(90),
                  ),
                  SizedBox(
                    width: screenheight,
                    child: const Text(
                      "SITRA",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 80,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: screenheight,
                    child: const Text(
                      "Module for UKG Analysis",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: heightconv(60),
                  ),
                  SizedBox(
                    height: heightconv(30),
                    width: screenheight,
                    child: Text(
                      "Ring Spun Yarn UKG Conv. Factors (40s) :",
                      style: TextStyle(
                          fontSize: widthconv(16),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 102, 50, 0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: heightconv(50),
                    width: screenheight,
                    child: ElevatedButton(
                      onPressed: () async {
                        colon = "";
                        lhs0 = "";
                        lhs1 = "";
                        lhs2 = "";
                        lhs3 = "";
                        rhs0 = "";
                        rhs1 = "";
                        rhs2 = "";
                        rhs3 = "";
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ukgspg()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 127, 127, 127)),
                      ),
                      child: Text(
                        'SITRA’s Std 40s UKG CF',
                        style: TextStyle(
                            fontSize: widthconv(16),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightconv(50),
                    width: screenheight,
                    child: ElevatedButton(
                      onPressed: () async {
                        colon1 = "";
                        lhs00 = "";
                        lhs11 = "";
                        lhs22 = "";
                        lhs33 = "";
                        rhs00 = "";
                        rhs11 = "";
                        rhs22 = "";
                        rhs33 = "";
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => millspg()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 204, 0)),
                      ),
                      child: Text(
                        '40s UKG CF adj. to Mill Parameters',
                        style: TextStyle(
                            fontSize: widthconv(16),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightconv(15),
                  ),
                  SizedBox(
                    height: heightconv(30),
                    width: screenheight,
                    child: Text(
                      "OE Yarn UKG Conv. Factors (10s) :",
                      style: TextStyle(
                          fontSize: widthconv(16),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 102, 50, 0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: heightconv(50),
                    width: screenheight,
                    child: ElevatedButton(
                      onPressed: () async {
                        lhs000 = "";
                        lhs111 = "";
                        lhs222 = "";
                        lhs333 = "";
                        colon11 = "";
                        rhs000 = "";
                        rhs111 = "";
                        rhs222 = "";
                        rhs333 = "";
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ukgoe()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 127, 127, 127)),
                      ),
                      child: Text(
                        'SITRA’s Std 10s UKG CF',
                        style: TextStyle(
                            fontSize: widthconv(16),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightconv(50),
                    width: screenheight,
                    child: ElevatedButton(
                      onPressed: () async {
                        lhs0000 = "";
                        lhs1111 = "";
                        lhs2222 = "";
                        lhs3333 = "";
                        colon111 = "";
                        rhs0000 = "";
                        rhs1111 = "";
                        rhs2222 = "";
                        rhs3333 = "";
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => milloe()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 204, 0)),
                      ),
                      child: Text(
                        '10s UKG CF adj. to Mill Parameters',
                        style: TextStyle(
                            fontSize: widthconv(16),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightconv(15),
                  ),
                  SizedBox(
                    height: heightconv(30),
                    width: screenheight,
                    child: Text(
                      "Ring Spinning :",
                      style: TextStyle(
                          fontSize: widthconv(16),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 102, 50, 0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: heightconv(50),
                    width: screenheight,
                    child: ElevatedButton(
                      onPressed: () async {
                        csvdata = [
                          [
                            'Count',
                            'Type',
                            'Shift',
                            'Prod',
                            'Speed',
                            'TM',
                            'Lift',
                            'Ring Dia.'
                          ]
                        ];
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        //prefs.remove('Logged');
                        username = prefs.getString('UserID').toString();
                        periodlist = ["New Period"];
                        var dio = Dio();
                        var data = await dio.get(
                            "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukg_period/$username/");
                        var map = jsonDecode(data.data.toString());

                        for (int i = 0; i < map.length; i++) {
                          periodlist.add(map[i].toString());
                        }
                        periodid = "";
                        period = "";
                        totunits = "";
                        create = "Create";
                        converted = "--";
                        days = "";
                        spindles = "";
                        uss = "--";
                        util = "--";
                        aec = "--";
                        kwh = "--";
                        val = "-1";
                        periodlist = periodlist.toSet().toList();

                        /*for (int i = 0; i < rawls.length; i += 3) {
                          String item =
                              rawls[i] + "," + rawls[i + 1] + "," + rawls[i + 2];
                          periodlist.add(item);
                        }
                        print(periodlist);*/

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => look()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 127, 127, 127)),
                      ),
                      child: Text(
                        'UKG Calculation',
                        style: TextStyle(
                            fontSize: widthconv(16),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
