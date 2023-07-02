import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

//Colors for bg
var defaultBg = const Color.fromARGB(255, 246, 247, 246);
var underweight = const Color.fromARGB(255, 134, 177, 227);
var normal = const Color.fromARGB(255, 193, 232, 152);
var overweight = const Color.fromARGB(255, 243, 138, 140);

//color for button
var buttoncolor = const Color.fromARGB(255, 140, 140, 210);
var resbutton = const Color.fromARGB(255, 244, 244, 245);

//color for text
var nortext = Colors.black87;
var overtext = Colors.white;

//starting of main page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //current colors to set in page
  var currbg = defaultBg;
  var currbutton = buttoncolor;
  var currtext = nortext;
  var cal = overtext;

  //strings which will change over time
  String title = 'BMI App';
  String subtitle = 'Calculate your BMI';

  //variable used in page
  late int? result;
  late double res;
  late double? w;
  late double? h;
  String dropdownValue = 'Male';
  //controllers for input
  final _weightcontroller = TextEditingController();
  final _heightcontroller = TextEditingController();
  final _agecontroller = TextEditingController();

  //int value fpr reset button
  bool reset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currbg,
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 0,
              ),
              Text(title,
                  style: GoogleFonts.lato(
                    fontSize: 70,
                    fontWeight: FontWeight.w500,
                    color: currtext,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                  color: currtext,
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _agecontroller,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        label: Text(
                          'Age',
                          style:
                              GoogleFonts.lato(color: currtext, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        isExpanded: true,
                        value: dropdownValue,
                        items: <String>['Male', 'Female', 'Others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.lato(
                                  color: nortext, fontSize: 20),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              dropdownValue = newValue!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: _weightcontroller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        label: Text(
                          'Weight(kg)',
                          style: GoogleFonts.lato(
                            color: currtext,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            (r'^(?!300)(?:\d{1,2}|1\d{2}|2[0-9]{2})(?:\.\d{0,2})?$')))
                      ],
                      controller: _heightcontroller,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: currtext),
                        ),
                        label: Text(
                          'Height(cm)',
                          style: GoogleFonts.lato(
                            color: currtext,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 250.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currbutton,
                    ),
                    //processing of data
                    onPressed: () {
                      if (_agecontroller.text.isEmpty ||
                          _heightcontroller.text.isEmpty ||
                          _weightcontroller.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                            title: const Text("Hey!"),
                            content: const Text("You forgot to fill something"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: currbg,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14.0))),
                                  // color: currbg,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (_agecontroller.text.length > 6 ||
                          _agecontroller.text == '0') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                            title: const Text("Hey!"),
                            content: const Text("Something wrong with the age"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: currbg,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14.0))),
                                  // color: currbg,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    "Okay!",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (_weightcontroller.text.length > 6 ||
                          _weightcontroller.text == '0') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                            title: const Text("Hey!"),
                            content:
                                const Text("Something wrong with the weight"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: currbg,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14.0))),
                                  // color: currbg,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    "Okay!",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (_heightcontroller.text.length > 6 ||
                          _heightcontroller.text == '0') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                            title: const Text("Hey!"),
                            content: const Text("Something wrong with height"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: currbg,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14.0))),
                                  // color: currbg,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    "Okay!",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      //if everything works fine then, app shows the result[BMI]
                      else {
                        setState(() {
                          w = double.tryParse(_weightcontroller.text);
                          h = double.tryParse(_heightcontroller.text);
                          res = calc(w!, h!);
                        });
                        if (res < 18.5) {
                          //underweight
                          setState(() {
                            cal = nortext;
                            currtext = overtext;
                            currbg = underweight;
                            currbutton = resbutton;
                            title = res.toInt().toString();
                            subtitle = 'Time to eat some healthy snacks!';
                            reset = true;
                          });
                        } else if (res > 25) {
                          //overweight
                          setState(() {
                            cal = nortext;
                            currtext = overtext;
                            currbg = overweight;
                            currbutton = resbutton;
                            title = res.toInt().toString();
                            subtitle = 'Time to discover a lighter life';
                            reset = true;
                          });
                        } else {
                          //normal
                          setState(() {
                            cal = nortext;
                            currbg = normal;
                            currbutton = resbutton;
                            title = res.toInt().toString();
                            subtitle = 'You\'re doing well!';
                            reset = true;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Calculate',
                      style: GoogleFonts.lato(fontSize: 26, color: cal),
                    ),
                  ),
                ),
              ),
              Container(
                  child: reset
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: currbutton),
                              onPressed: () {
                                setState(() {
                                  title = 'BMI App';
                                  subtitle = 'Calculate your BMI';
                                  currbg = defaultBg;
                                  currbutton = buttoncolor;
                                  currtext = nortext;
                                  cal = overtext;
                                  _agecontroller.clear();
                                  _heightcontroller.clear();
                                  _weightcontroller.clear();
                                  reset = false;
                                });
                              },
                              child: Text(
                                'Reset',
                                style: GoogleFonts.lato(color: cal),
                              ),
                            ),
                          ),
                        )
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}

//function to calculate BMI
double calc(double w, double h) {
  double l = h / 100;
  double bmi = w / (l * l);
  return bmi;
}
