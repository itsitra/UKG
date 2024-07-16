import 'dart:convert';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class look extends StatefulWidget {
  const look({Key? key}) : super(key: key);
  static String ver = "";
  @override
  State<look> createState() => _look();
}

List<List<String>> csvdata = [
  ['Count', 'Type', 'Shift', 'Prod', 'Speed', 'TM', 'Lift', 'Ring Dia.']
];
List<List<String>> emptier = [
  ['Count', 'Type', 'Shift', 'Prod', 'Speed', 'TM', 'Lift', 'Ring Dia.']
];
List<String> empty = ['', '', '', '', '', '', '', ''];
String create = "Create";
var periodid = "";
var period = "";
var periodto = "";
var totunits = "";
var converted = "--";
var days = "";
var spindles = "";
var uss = "";
var util = "";
var aec = "";
var kwh = "";
List<String> periodlist = ['New Period'];
var val = "-1";
var val1 = "1";
var val2 = "1";
var val3 = "1";
var val4 = "1";
var username = "";

class _look extends State<look> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();
  final TextEditingController _controller11 = TextEditingController();
  final TextEditingController _controller12 = TextEditingController();
  final TextEditingController _controller13 = TextEditingController();
  final FocusNode focus1 = FocusNode();
  final FocusNode focus2 = FocusNode();
  final FocusNode focus3 = FocusNode();
  final FocusNode focus4 = FocusNode();
  final FocusNode focus5 = FocusNode();
  final FocusNode focus6 = FocusNode();
  final FocusNode focus7 = FocusNode();
  final FocusNode focus8 = FocusNode();
  final FocusNode focus9 = FocusNode();
  final FocusNode focus10 = FocusNode();
  final FocusNode focus11 = FocusNode();
  final FocusNode focus12 = FocusNode();
  final FocusNode focus13 = FocusNode();

  FocusNode _focusNode = FocusNode();

  List<String> lhs = [];
  List<String> rhs = [];
  Widget buildCustomButton() {
    return ElevatedButton(
      onPressed: () {
        // Your button's onPressed logic here
      },
      child: Text('Custom Button'),
    );
  }

  String _selectedItem = periodlist[0];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    double screenheight = MediaQuery.of(context).size.width;

    void save() async {
      if (csvdata.length > 1) {
        String tabcontent = "";
        for (int i = 1; i < csvdata.length; i++) {
          for (int j = 0; j < csvdata[i].length; j++) {
            tabcontent = tabcontent + csvdata[i][j] + "_";
          }
          tabcontent = tabcontent.substring(0, tabcontent.length - 1) + "-";
        }
        tabcontent = tabcontent.replaceAll("'", "");
        tabcontent = tabcontent.substring(0, tabcontent.length - 1);
        var dio = Dio();
        var data = await dio.get(
            "http://sitraonline.org.in/onlineserviceapi/index.php/api/save_ukg_data/$username/$periodid/$tabcontent/");
        var map = jsonDecode(data.data.toString());
        print(
            "http://sitraonline.org.in/onlineserviceapi/index.php/api/save_ukg_data/34804/$periodid/$tabcontent");
        print(map);
        map = map.toString();
        List<String> xtemp = map.split(',');
        setState(() {
          converted = xtemp[0];
          uss = xtemp[1];
          util = xtemp[2];
          aec = xtemp[3];
          kwh = xtemp[4];
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // Return an AlertDialog widget as the content of the dialog.
              return AlertDialog(
                backgroundColor: Color.fromARGB(255, 102, 50, 0),
                title: Text(
                  "Warning :",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  "Fill the table contents  ",
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            });
      }
    }

    void saveAsExcel() async {
      save();
      // Create an Excel workbook
      final excel = Excel.createExcel();
      final sheet = excel['UKG MIS Report'];

      // Add data to the sheet (replace this with your data)
      for (var row in csvdata) {
        sheet.appendRow(row);
      }
      List<String> ret1 = ["40s converted prod.", converted];
      List<String> ret2 = ["USS", uss];
      List<String> ret3 = ["Util(%)", util];
      List<String> ret4 = ["Act SEC", aec];
      List<String> ret5 = ["Kwh/spl/day", kwh];
      sheet.appendRow(ret1);
      sheet.appendRow(ret2);
      sheet.appendRow(ret3);
      sheet.appendRow(ret4);
      sheet.appendRow(ret5);
      DateTime curr = DateTime.now();
      String hr = curr.hour.toString();
      String min = curr.minute.toString();
      String sec = curr.second.toString();
      // Get the documents directory where the file will be saved
      final downloadsDirectory = await getExternalStorageDirectory();
      final String appDocPath = downloadsDirectory!.path;

      // Define the file path for the Excel file
      final String excelFilePath = '$appDocPath/data$hr:$min:$sec.xlsx';

      // Save the Excel file
      excel.delete('Sheet1');
      File(excelFilePath).writeAsBytesSync(excel.encode() ?? []);

      // Show a success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('File Saved'),
          content: Text('The Excel file has been saved at $excelFilePath.'),
          actions: [
            TextButton(
              onPressed: () async {
                await OpenFile.open(excelFilePath);
                Navigator.of(context).pop();
              },
              child: Text('Open'),
            ),
          ],
        ),
      );
    }

    bool isValidDate(String input) {
      // Define a regular expression pattern for "DD.MM.YYYY" format
      final pattern = r'^\d{2}\.\d{2}\.\d{2}$';

      // Create a RegExp object
      final regExp = RegExp(pattern);

      // Check if the input string matches the pattern
      if (!regExp.hasMatch(input)) {
        return false;
      }

      // Split the date into day, month, and year
      final parts = input.split('.');
      final day = int.tryParse(parts[2]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[0]);

      // Check if the day, month, and year are valid
      if (day == null || month == null || year == null) {
        return false;
      }
      if (day < 0 || day > 31) {
        return false;
      }
      if (month < 0 || month > 12) {
        return false;
      }
      if (year > 70) {
        return false;
      }
      // Check if the date is valid using the DateTime class
      try {
        final date = DateTime(year, month, day);
        return true;
      } catch (e) {
        return false;
      }
    }

    double heightconv(double arg) {
      return screenWidth * (arg / 781.09);
    }

    double widthconv(double arg) {
      return screenheight * (arg / 392.7);
    }

    TableRow buildCustomButton(List<String> row) {
      return TableRow(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[0], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[1], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[2], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[3], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[4], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[5], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[6], style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(row[7], style: TextStyle(fontSize: 12)),
        )
      ]);
    }

    var warntxt = "";
    return Scaffold(
        appBar: AppBar(
          title: Text('UKG Calculation',
              style: TextStyle(fontSize: widthconv(14))),
          backgroundColor: Color.fromARGB(255, 102, 50, 0),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: heightconv(20),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: widthconv(20),
                      ),
                      Container(
                        color: Color.fromARGB(255, 102, 50, 0),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
                          child: DropdownButton<String>(
                            value: _selectedItem,
                            dropdownColor: Color.fromARGB(255, 102, 50, 0),
                            items: periodlist.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 10),
                                ),
                              );
                            }).toList(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            onChanged: (String? selectedItem) {
                              if (selectedItem != "New Period") {
                                List<String> temp = _selectedItem.split(",");

                                setState(() {
                                  /*periodid = temp[1];
                                  period = temp[0];
                                  totunits = temp[2];*/
                                  create = "Retrieve";
                                });
                              }
                              if (selectedItem == "New Period") {
                                setState(() {
                                  setState(() {
                                    periodid = "";
                                    period = "";
                                    totunits = "";
                                  });
                                  create = "Create";
                                });
                              }
                              setState(() {
                                _selectedItem = selectedItem.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widthconv(15),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_selectedItem == "New Period") {
                            _controller6.text = "";
                            _controller7.text = "";
                            _controller8.text = "";
                            _controller9.text = "";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // Return an AlertDialog widget as the content of the dialog.
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  title: Text(
                                    "New Period :",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 102, 50, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenheight * 2 / 10,
                                                child: Text(
                                                  "Starting date",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight / 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight * 3 / 10,
                                                child: TextField(
                                                  focusNode: focus6,
                                                  controller: _controller6,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 102, 50, 0),
                                                    hintText: 'YY.MM.DD',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenheight * 2 / 10,
                                                child: Text(
                                                  "Ending Date",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight / 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight * 3 / 10,
                                                child: TextField(
                                                  focusNode: focus7,
                                                  controller: _controller7,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 102, 50, 0),
                                                    hintText: 'YY.MM.DD',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenheight * 2 / 10,
                                                child: Text(
                                                  "Total units",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight / 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight * 3 / 10,
                                                child: TextField(
                                                  focusNode: focus9,
                                                  controller: _controller9,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 102, 50, 0),
                                                    hintText: 'Enter units',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenheight * 2 / 10,
                                                child: Text(
                                                  "Total Days",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight / 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight * 3 / 10,
                                                child: TextField(
                                                  focusNode: focus10,
                                                  controller: _controller10,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 102, 50, 0),
                                                    hintText:
                                                        'Enter no. of days',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenheight * 2 / 10,
                                                child: Text(
                                                  "Installed Spindles",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight / 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: widthconv(15),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenheight * 3 / 10,
                                                child: TextField(
                                                  focusNode: focus11,
                                                  controller: _controller11,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        255, 102, 50, 0),
                                                    hintText:
                                                        'Enter no. of spindles',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          warntxt,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: widthconv(16),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ]),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (isValidDate(_controller6.text) &&
                                            isValidDate(_controller7.text) &&
                                            _controller9.text != null &&
                                            _controller10.text != null &&
                                            _controller11.text != null) {
                                          // Close the dialog when the "OK" button is pressed.

                                          var dio = Dio();
                                          String startdate = _controller6.text;
                                          String enddate = _controller7.text;
                                          String totunits = _controller9.text;
                                          String days = _controller10.text;
                                          String spindles = _controller11.text;
                                          var data = await dio.get(
                                              "http://sitraonline.org.in/onlineserviceapi/index.php/api/create_ukg_period/$username/$startdate/$enddate/$totunits/$days/$spindles/");
                                          var map =
                                              jsonDecode(data.data.toString());
                                          data = await dio.get(
                                              "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukg_period/34804/");
                                          map =
                                              jsonDecode(data.data.toString());
                                          setState(() {
                                            periodlist = ["New Period"];
                                          });
                                          for (int i = 0; i < map.length; i++) {
                                            setState(() {
                                              periodlist.add(map[i]);
                                            });
                                          }
                                          periodlist =
                                              periodlist.toSet().toList();
                                          Navigator.of(context).pop();
                                        } else {
                                          setState(() {
                                            warntxt = "Enter valid date !";
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Create',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 102, 50, 0)),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                          if (_selectedItem != "New Period") {
                            csvdata = [csvdata[0]];
                            List<String> temp = _selectedItem.split(",");
                            print(temp);
                            String perioddate = temp[0];
                            String id = temp[1];
                            String tot = temp[2];
                            String tempday = temp[3];
                            String tempspin = temp[4];
                            setState(() {
                              periodid = id;
                              period = perioddate;
                              totunits = tot;
                              days = tempday;
                              spindles = tempspin;
                            });
                            var dio = Dio();
                            var data = await dio.get(
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukg_data/$username/$periodid/");
                            print(
                                "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukg_data/$username/$periodid/");
                            var map = jsonDecode(data.data.toString());
                            List<String> rowStrings =
                                map.substring(2, map.length - 2).split("],[");
                            List<List<String>> retrievedcsv = [];
                            for (String rowString in rowStrings) {
                              List<String> values = rowString.split(',');
                              retrievedcsv.add(values);
                            }
                            for (int i = 0; i < retrievedcsv.length; i++) {
                              setState(() {
                                csvdata.add(retrievedcsv[i]);
                              });
                            }
                            for (int i = 0; i < csvdata.length; i++) {
                              for (int j = 0; j < csvdata[i].length; j++) {
                                setState(() {
                                  csvdata[i][j] =
                                      csvdata[i][j].replaceAll("'", "");
                                });
                              }
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: Text(
                          create,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightconv(25),
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenheight / 10),
                      SizedBox(
                        width: screenheight * 3 / 10,
                        child: Text(
                          "Period ID ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          width: screenheight * 1 / 10,
                          child: Text(":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widthconv(14)))),
                      SizedBox(
                        width: screenheight * 4.4 / 10,
                        child: Text(
                          periodid,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightconv(10),
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenheight / 10),
                      SizedBox(
                        width: screenheight * 3 / 10,
                        child: Text(
                          "Period ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          width: screenheight * 1 / 10,
                          child: Text(":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widthconv(14)))),
                      SizedBox(
                        width: screenheight * 4.4 / 10,
                        child: Text(
                          "$period",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightconv(10),
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenheight / 10),
                      SizedBox(
                        width: screenheight * 3 / 10,
                        child: Text(
                          "Total Days ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          width: screenheight * 1 / 10,
                          child: Text(":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widthconv(14)))),
                      SizedBox(
                        width: screenheight * 4.4 / 10,
                        child: Text(
                          days,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightconv(10),
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenheight / 10),
                      SizedBox(
                        width: screenheight * 3 / 10,
                        child: Text(
                          "Inst. Spindles ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          width: screenheight * 1 / 10,
                          child: Text(":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widthconv(14)))),
                      SizedBox(
                        width: screenheight * 4.4 / 10,
                        child: Text(
                          spindles,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightconv(15),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenheight * 0.9 / 10,
                      ),
                      SizedBox(
                        width: screenheight * 3.5 / 10,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Units : $totunits",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: widthconv(14),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenheight * 2.5 / 10,
                      ),
                      SizedBox(
                        width: screenheight * 1 / 10,
                        child: ElevatedButton(
                          onPressed: () {
                            if (csvdata.length <= 15) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Return an AlertDialog widget as the content of the dialog.
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    title: const Text(
                                      "Add Item :",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SizedBox(
                                      width: widthconv(350),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: heightconv(20),
                                            ),
                                            SizedBox(
                                              height: heightconv(45),
                                              width: widthconv(200),
                                              child: DropdownButtonFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: widthconv(18)),
                                                focusColor:
                                                    const Color.fromARGB(
                                                        255, 102, 50, 0),
                                                dropdownColor:
                                                    const Color.fromARGB(
                                                        255, 102, 50, 0),
                                                value: val,
                                                items: [
                                                  DropdownMenuItem(
                                                      value: "-1",
                                                      child: SizedBox(
                                                        width: widthconv(150),
                                                        child: const Opacity(
                                                          opacity: 1,
                                                          child: Text(
                                                            "    Yarn type ",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        ),
                                                      )),
                                                  const DropdownMenuItem(
                                                      value: "1",
                                                      child: Text(" K ")),
                                                  const DropdownMenuItem(
                                                    value: "2",
                                                    child: Text(" K-Comp "),
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        " KH "), //Combed Hoisery
                                                    value: "3",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" KH-Comp "),
                                                    value: "4",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" K-HT "),
                                                    value: "5",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" C "), //Carded
                                                    value: "6",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" C-Comp "),
                                                    value: "7",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" CH "),
                                                    value: "8",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        " CH-Comp "), //Polyester Cotton
                                                    value: "9",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" C-HT "),
                                                    value: "10",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" PSF "),
                                                    value: "11",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" PSF-HT "),
                                                    value: "12",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" VSF "),
                                                    value: "13",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" VSF-HT "),
                                                    value: "14",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        " PV "), //Polyester Staple Fibre
                                                    value: "15",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" PV-HT "),
                                                    value: "16",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        " PC "), //Polyester Viscose
                                                    value: "17",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(" PC-H "),
                                                    value: "18",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        " PC-HT "), //Viscose Staple Fibre
                                                    value: "19",
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
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus1,
                                                controller: _controller,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter count',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus2,
                                                controller: _controller2,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter shift',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus3,
                                                controller: _controller3,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter production',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus4,
                                                controller: _controller4,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter speed',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(40),
                                              child: TextField(
                                                focusNode: focus5,
                                                controller: _controller5,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter TM',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus12,
                                                controller: _controller12,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText: 'Enter Lift (mm)',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                            SizedBox(
                                              width: widthconv(200),
                                              height: heightconv(45),
                                              child: TextField(
                                                focusNode: focus13,
                                                controller: _controller13,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 102, 50, 0),
                                                  hintText:
                                                      'Enter Ring Dia. (mm)',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightconv(10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          if (val != "-1" &&
                                              _controller.text != null &&
                                              _controller2.text != null &&
                                              _controller3.text != null &&
                                              _controller4.text != null &&
                                              _controller5.text != null &&
                                              _controller12.text != null &&
                                              int.parse(_controller12.text) >
                                                  139 &&
                                              int.parse(_controller12.text) <
                                                  221 &&
                                              int.parse(_controller13.text) >
                                                  33 &&
                                              int.parse(_controller13.text) <
                                                  43 &&
                                              _controller13.text != null) {
                                            var yarn = "";
                                            var csvrow2 = "";
                                            var csvrow3 = "";
                                            var csvrow4 = "";
                                            var csvrow5 = "";
                                            var csvrow6 = "";
                                            var csvrow7 = "";
                                            var csvrow8 = "";
                                            if (val == "1") {
                                              yarn = "K";
                                            }
                                            if (val == "2") {
                                              yarn = "K-Comp";
                                            }
                                            if (val == "3") {
                                              yarn = "KH";
                                            }
                                            if (val == "4") {
                                              yarn = "KH-Comp";
                                            }
                                            if (val == "5") {
                                              yarn = "K-HT";
                                            }
                                            if (val == "6") {
                                              yarn = "C";
                                            }
                                            if (val == "7") {
                                              yarn = "C-Comp";
                                            }
                                            if (val == "8") {
                                              yarn = "CH";
                                            }
                                            if (val == "9") {
                                              yarn = "CH-Comp";
                                            }
                                            if (val == "10") {
                                              yarn = "C-HT";
                                            }
                                            if (val == "11") {
                                              yarn = "PSF";
                                            }
                                            if (val == "12") {
                                              yarn = "PSF-HT";
                                            }
                                            if (val == "13") {
                                              yarn = "VSF";
                                            }
                                            if (val == "14") {
                                              yarn = "VSF-HT";
                                            }
                                            if (val == "15") {
                                              yarn = "PV";
                                            }
                                            if (val == "16") {
                                              yarn = "PV-HT";
                                            }
                                            if (val == "17") {
                                              yarn = "PC";
                                            }
                                            if (val == "18") {
                                              yarn = "PC-H";
                                            }
                                            if (val == "19") {
                                              yarn = "PC-HT";
                                            }
                                            csvrow2 = _controller.text;

                                            csvrow3 = _controller2.text;
                                            csvrow4 = _controller3.text;
                                            csvrow5 = _controller4.text;
                                            csvrow6 = _controller5.text;
                                            csvrow7 = _controller12.text;
                                            csvrow8 = _controller13.text;
                                            setState(() {
                                              csvdata.add([
                                                csvrow2,
                                                yarn,
                                                csvrow3,
                                                csvrow4,
                                                csvrow5,
                                                csvrow6,
                                                csvrow7,
                                                csvrow8
                                              ]);
                                            });
                                            print(csvdata);
                                          }
                                          // Close the dialog when the "OK" button is pressed.
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontSize: widthconv(20),
                                              color: Color.fromARGB(
                                                  255, 212, 0, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 102, 50, 0)),
                          ),
                          child: const Text(
                            '+',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenheight * 0.5 / 10,
                      ),
                      SizedBox(
                        width: screenheight / 10,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              if (csvdata.length >= 2) {
                                csvdata.removeLast();
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 102, 50, 0)),
                          ),
                          child: const Text(
                            '-',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenheight * 0.5 / 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightconv(20),
                  ),
                  SizedBox(
                      width: screenheight,
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Table(
                            border: TableBorder.all(),
                            defaultColumnWidth:
                                FixedColumnWidth((screenheight / 1.05) / 8),
                            children: <TableRow>[
                              buildCustomButton(csvdata[0]),
                              (csvdata.length >= 2)
                                  ? buildCustomButton(csvdata[1])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 3)
                                  ? buildCustomButton(csvdata[2])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 4)
                                  ? buildCustomButton(csvdata[3])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 5)
                                  ? buildCustomButton(csvdata[4])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 6)
                                  ? buildCustomButton(csvdata[5])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 7)
                                  ? buildCustomButton(csvdata[6])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 8)
                                  ? buildCustomButton(csvdata[7])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 9)
                                  ? buildCustomButton(csvdata[8])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 10)
                                  ? buildCustomButton(csvdata[9])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 11)
                                  ? buildCustomButton(csvdata[10])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 12)
                                  ? buildCustomButton(csvdata[11])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 13)
                                  ? buildCustomButton(csvdata[12])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 14)
                                  ? buildCustomButton(csvdata[13])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 15)
                                  ? buildCustomButton(csvdata[14])
                                  : buildCustomButton(empty),
                              (csvdata.length >= 16)
                                  ? buildCustomButton(csvdata[15])
                                  : buildCustomButton(empty)
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedItem != "New Period") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Return an AlertDialog widget as the content of the dialog.
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                title: Text(
                                  "Delete period :",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  "Are you sure of deleting this period from your database ?",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      List<String> temp =
                                          _selectedItem.split(",");
                                      String tempid = temp[1];
                                      var dio = Dio();
                                      var data = await dio.get(
                                          "http://sitraonline.org.in/onlineserviceapi/index.php/api/del_ukg_period/$username/$tempid/");
                                      print(
                                          "http://sitraonline.org.in/onlineserviceapi/index.php/api/del_ukg_period/34804/$periodid/");
                                      var map =
                                          jsonDecode(data.data.toString());
                                      setState(() {
                                        periodid = "";
                                        period = "";
                                        periodto = "";
                                        csvdata = [csvdata[0]];
                                        totunits = "";
                                        _selectedItem = periodlist[0];
                                        create = "Create";
                                      });
                                      data = await dio.get(
                                          "http://sitraonline.org.in/onlineserviceapi/index.php/api/get_ukg_period/$username/");
                                      map = jsonDecode(data.data.toString());
                                      setState(() {
                                        periodlist = ["New Period"];
                                      });
                                      for (int i = 0; i < map.length; i++) {
                                        setState(() {
                                          periodlist.add(map[i]);
                                        });
                                      }
                                      periodlist = periodlist.toSet().toList();
                                      // Close the dialog when the "OK" button is pressed.
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 0, 0)),
                      ),
                      child: const Text(
                        ' Delete Period ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                                "40s converted prod.",
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
                                ":",
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
                                converted,
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
                                "USS",
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
                                ":",
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
                                uss,
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
                                "Util (%)",
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
                                ":",
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
                                util,
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
                                "Act SEC",
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
                                ":",
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
                                aec,
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
                                "Kwh/spl/day",
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
                                ":",
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
                                kwh,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: heightconv(150),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  SizedBox(
                    width: screenheight * 0.5 / 10,
                  ),
                  Container(
                    color: Color.fromARGB(0, 179, 156, 134),
                    child: SizedBox(
                      height: heightconv(75),
                      width: screenheight * 5 / 10,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: widthconv(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenheight * 0.75 / 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 7.0, 20.0),
                    child: FloatingActionButton(
                      onPressed: save,
                      backgroundColor: Color.fromARGB(255, 102, 50, 0),
                      child: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 7.0, 20.0),
                    child: FloatingActionButton(
                        onPressed: saveAsExcel,
                        backgroundColor: Color.fromARGB(255, 102, 50, 0),
                        child: Icon(
                          Icons.download,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
