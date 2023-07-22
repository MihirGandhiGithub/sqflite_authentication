import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Globaly Accesible/Row  widget with 2 items.dart';

class HomeCompareOilMillCalculator extends StatefulWidget {
  final bool forOrReverse;
  final bool compareReverseCalculatemix;
  final bool compareForwardCalculatemix;

  const HomeCompareOilMillCalculator({
    Key? key,
    required this.forOrReverse,
    required this.compareReverseCalculatemix,
    required this.compareForwardCalculatemix,
  }) : super(key: key);

  @override
  State<HomeCompareOilMillCalculator> createState() =>
      _HomeCompareOilMillCalculatorState();
}

class _HomeCompareOilMillCalculatorState
    extends State<HomeCompareOilMillCalculator>
    with SingleTickerProviderStateMixin {
  late bool compare_forward_calulateMix;
  late bool compare_reverse_calulateMix;

  // for calculator 1
  final reverseinputkapas1 = TextEditingController();
  final reverseinputexpense1 = TextEditingController();
  final reverseinputoilrate1 = TextEditingController();
  final reverseinputkapasia1 = TextEditingController();
  final reverseinpututaro1 = TextEditingController();
  final reverseinputghati1 = TextEditingController();

  double reverseanswer = 0;
  double reversedubanswer = 0;
  double reverseanswer2 = 0;
  double reversedubanswer2 = 0;
  double reversediff = 0;
  double reversedubdiff = 0;
  //for calculator 2

  final reverseinputkapas2 = TextEditingController();
  final reverseinputexpense2 = TextEditingController();
  final reverseinputoilrate2 = TextEditingController();
  final reverseinputkapasia2 = TextEditingController();
  final reverseinpututaro2 = TextEditingController();
  final reverseinputghati2 = TextEditingController();

  void _reverseupdateValues_for_calculator1() {
    double storeInputKapas1 = double.tryParse(reverseinputkapas1.text) ?? 0;
    double storeInputExpense1 = double.tryParse(reverseinputexpense1.text) ?? 0;
    double storeInputOilrate1 = double.tryParse(reverseinputoilrate1.text) ?? 0;
    double storeInputKapasia1 = double.tryParse(reverseinputkapasia1.text) ?? 0;
    double storeInputUtaro1 = double.tryParse(reverseinpututaro1.text) ?? 0;
    double storeInputGhati1 = double.tryParse(reverseinputghati1.text) ?? 0;
    double sum1 = (storeInputKapas1 + storeInputExpense1);

    if (storeInputKapas1 != 0 &&
        storeInputExpense1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputOilrate1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer = double.parse(storeInputKapas1.toStringAsFixed(2));
        reversedubanswer = storeInputKapas1;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer = double.parse(sum1.toStringAsFixed(2));
        reversedubanswer = sum1;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1);
      double a3 = (storeInputOilrate1 / 10);
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer = double.parse(f.toStringAsFixed(2));
        reversedubanswer = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1);
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer = double.parse(f.toStringAsFixed(2));
        reversedubanswer = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1) * storeInputUtaro1;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer = double.parse(f.toStringAsFixed(2));
        reversedubanswer = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 != 0) {
      double a2 = (storeInputKapas1 / storeInputGhati1) * storeInputUtaro1;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer = double.parse(f.toStringAsFixed(2));
        reversedubanswer = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    }
  }

  void _reverseupdateValues_for_calculator2() {
    double storeInputKapas1 = double.tryParse(reverseinputkapas2.text) ?? 0;
    double storeInputExpense1 = double.tryParse(reverseinputexpense2.text) ?? 0;
    double storeInputOilrate1 = double.tryParse(reverseinputoilrate2.text) ?? 0;
    double storeInputKapasia1 = double.tryParse(reverseinputkapasia2.text) ?? 0;
    double storeInputUtaro1 = double.tryParse(reverseinpututaro2.text) ?? 0;
    double storeInputGhati1 = double.tryParse(reverseinputghati2.text) ?? 0;
    double sum1 = (storeInputKapas1 + storeInputExpense1);

    if (storeInputKapas1 != 0 &&
        storeInputExpense1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputOilrate1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer2 = double.parse(storeInputKapas1.toStringAsFixed(2));
        reversedubanswer2 = storeInputKapas1;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer2 = double.parse(sum1.toStringAsFixed(2));
        reversedubanswer2 = sum1;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1);
      double a3 = (storeInputOilrate1 / 10);
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1);
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 == 0) {
      double a2 = (storeInputKapas1) * storeInputUtaro1;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 != 0) {
      double a2 = (storeInputKapas1 / storeInputGhati1) * storeInputUtaro1;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 + a3;
      double a5 = a4 / 5;
      double f = (a5 - storeInputExpense1);

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    }
  }

  // for calculator 1
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();

  //for calculator 2

  final inputkapas2 = TextEditingController();
  final inputexpense2 = TextEditingController();
  final inputoilrate2 = TextEditingController();
  final inputkapasia2 = TextEditingController();
  final inpututaro2 = TextEditingController();
  final inputghati2 = TextEditingController();

  double answer = 0;
  double dubanswer = 0;
  double answer2 = 0;
  double dubanswer2 = 0;
  double diff = 0;
  double dubdiff = 0;
  void _updateValuesForCalculator1() {
    double storeInputKapas1 = double.tryParse(inputkapas1.text) ?? 0;
    double storeInputExpense1 = double.tryParse(inputexpense1.text) ?? 0;
    double storeInputOilrate1 = double.tryParse(inputoilrate1.text) ?? 0;
    double storeInputKapasia1 = double.tryParse(inputkapasia1.text) ?? 0;
    double storeInputUtaro1 = double.tryParse(inpututaro1.text) ?? 0;
    double storeInputGhati1 = double.tryParse(inputghati1.text) ?? 0;
    double sum1 = (storeInputKapas1 + storeInputExpense1);

    if (storeInputKapas1 != 0 &&
        storeInputExpense1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputOilrate1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        answer = double.parse(storeInputKapas1.toStringAsFixed(2));
        dubanswer = storeInputKapas1;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 == 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        answer = double.parse(sum1.toStringAsFixed(2));
        dubanswer = sum1;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a3 = (storeInputOilrate1 / 10);

      setState(() {
        answer = double.parse(a3.toStringAsFixed(2));
        dubanswer = a3;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      double a2 = sum1 * 5;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 - a3;

      setState(() {
        answer = double.parse(a4.toStringAsFixed(2));
        dubanswer = a4;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 == 0) {
      double a2 = sum1 * 5;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 - a3;
      double f = (a4 / storeInputUtaro1);

      setState(() {
        answer = double.parse(f.toStringAsFixed(2));
        dubanswer = f;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputOilrate1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 != 0) {
      double a2 = sum1 * 5;
      double a3 = (storeInputOilrate1 / 10) * storeInputKapasia1;
      double a4 = a2 - a3;
      double f = (a4 / storeInputUtaro1) * storeInputGhati1;

      setState(() {
        answer = double.parse(f.toStringAsFixed(2));
        dubanswer = f;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    }
  }

  void _updateValuesForCalculator2() {
    double storeInputKapas2 = double.tryParse(inputkapas2.text) ?? 0;
    double storeInputExpense2 = double.tryParse(inputexpense2.text) ?? 0;
    double storeInputOilrate2 = double.tryParse(inputoilrate2.text) ?? 0;
    double storeInputKapasia2 = double.tryParse(inputkapasia2.text) ?? 0;
    double storeInputUtaro2 = double.tryParse(inpututaro2.text) ?? 0;
    double storeInputGhati2 = double.tryParse(inputghati2.text) ?? 0;
    double sum2 = (storeInputKapas2 + storeInputExpense2);

    if (storeInputKapas2 != 0 &&
        storeInputExpense2 == 0 &&
        storeInputKapasia2 == 0 &&
        storeInputOilrate2 == 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        answer2 = double.parse(storeInputKapas2.toStringAsFixed(2));
        dubanswer2 = storeInputKapas2;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputOilrate2 == 0 &&
        storeInputKapasia2 == 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        answer2 = double.parse(sum2.toStringAsFixed(2));
        dubanswer2 = sum2;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputOilrate2 != 0 &&
        storeInputKapasia2 == 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      double a3 = (storeInputOilrate2 / 10);

      setState(() {
        answer2 = double.parse(a3.toStringAsFixed(2));
        dubanswer2 = a3;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputOilrate2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      double a2 = sum2 * 5;
      double a3 = (storeInputOilrate2 / 10) * storeInputKapasia2;
      double a4 = a2 - a3;

      setState(() {
        answer2 = double.parse(a4.toStringAsFixed(2));
        dubanswer2 = a4;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputOilrate2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 == 0) {
      double a2 = sum2 * 5;
      double a3 = (storeInputOilrate2 / 10) * storeInputKapasia2;
      double a4 = a2 - a3;
      double f = (a4 / storeInputUtaro2);

      setState(() {
        answer2 = double.parse(f.toStringAsFixed(2));
        dubanswer2 = f;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputOilrate2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 != 0) {
      double a2 = sum2 * 5;
      double a3 = (storeInputOilrate2 / 10) * storeInputKapasia2;
      double a4 = a2 - a3;
      double f = (a4 / storeInputUtaro2) * storeInputGhati2;

      setState(() {
        answer2 = double.parse(f.toStringAsFixed(2));
        dubanswer2 = f;
        dubdiff = dubanswer - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    }
  }

  late bool _isForwardGinning;
  @override
  void initState() {
    _isForwardGinning = widget.forOrReverse;
    compare_forward_calulateMix = widget.compareForwardCalculatemix;

    // _isFirstButtonSelected1 = widget.for_or_reverse;
    // setState(() {
    //   if (_isFirstButtonSelected1) {
    //     _isForwardGinning = true;
    //   } else {
    //     _isForwardGinning = false;
    //   }
    // });
    super.initState();
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
          appBar: GlobalCustomAppBar(
            sliderText1: 'Forward Oil Mill',
            sliderText2: 'Reverse Oil Mill',
            appbarText: 'Oil Mill Compare Calculator',
            isFirstButtonSelected: _isForwardGinning,
            onButtonPressed: (bool isFirstButton) {
              setState(() {
                _isForwardGinning = isFirstButton;
              });
            },
          ),
          body: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  // Swiped from left to right
                  setState(() {
                    _isForwardGinning = true;
                  });
                } else if (details.primaryVelocity! < 0) {
                  // Swiped from right to left
                  setState(() {
                    _isForwardGinning = false;
                  });
                }
              },
              child: _isForwardGinning
                  ? Container(
                      child: compare_forward_calulateMix
                          ? ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Calculate Pure',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: compare_forward_calulateMix,
                                      // overlayColor: overlayColor,
                                      // trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          compare_forward_calulateMix = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Calculate Mix',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                  ],
                                ),
                                //Heading of Calculator
                                const GlobalRowCompareWidget2TEXT(
                                  title1: 'Calc1 ',
                                  title2: 'Calc2 ',
                                ),

                                //Content Of Calculator

                                // Kappas
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Cotton Seed',
                                    controller1: inputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapas2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Hull Rate',
                                    controller1: inputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapas2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Cotton Seed Qty.',
                                    controller1: inputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapas2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Hull Qty.',
                                    controller1: inputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapas2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Expense
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Expense',
                                    controller1: inputexpense1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputexpense2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Cotton Seed
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Rate',
                                    controller1: inputoilrate1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputoilrate2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //oil
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil',
                                    controller1: inputkapasia1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapasia2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //Out Turn / Utaro
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Shortage',
                                    controller1: inpututaro1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inpututaro2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //Shortage / Ghati
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Packaging Size',
                                    controller1: inputghati1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputghati2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Final Answer
                                GlobalRowCompareWidget2StreamBuilderWithAnswer(
                                  result1: answer,
                                  result2: answer2,
                                  subtext1: '₹',
                                  subtext2: '₹',
                                  title1: 'Oil Cake Coast',
                                  title2: 'Oil Cake Coast',
                                ),

                                GlobalRowCompareWidget2Button(
                                  onpressed1: () {
                                    inputkapas1.clear();
                                    inputexpense1.clear();
                                    inputoilrate1.clear();
                                    inputkapasia1.clear();
                                    inpututaro1.clear();
                                    inputghati1.clear();
                                    answer = 0;
                                  },
                                  onpressed2: () {
                                    inputkapas2.clear();
                                    inputexpense2.clear();
                                    inputoilrate2.clear();
                                    inputkapasia2.clear();
                                    inpututaro2.clear();
                                    inputghati2.clear();
                                    answer2 = 0;
                                  },
                                  text1: 'RESET 1',
                                  text2: 'RESET 2',
                                ),

                                SizedBox(height: 20.h),
                                GlobalResultBuilderForResults(
                                  substreamtext: '₹',
                                  streamtitletext: 'Oil Cake Difference',
                                  result: diff,
                                ),

                                // Reset All Button
                                SizedBox(
                                  height: 20.h,
                                ),

                                GlobalButtonSimpleText(
                                  onPressed: () {
                                    inputkapas1.clear();
                                    inputexpense1.clear();
                                    inputoilrate1.clear();
                                    inputkapasia1.clear();
                                    inpututaro1.clear();
                                    inputghati1.clear();
                                    inputkapas2.clear();
                                    inputexpense2.clear();
                                    inputoilrate2.clear();
                                    inputkapasia2.clear();
                                    inpututaro2.clear();
                                    inputghati2.clear();
                                    diff = 0;
                                    answer = 0;
                                    dubanswer = 0;
                                    answer2 = 0;
                                    dubanswer2 = 0;
                                    dubdiff = 0;
                                  },
                                  buttontext: 'Reset All',
                                  height: globalSingalResetButtonHeight,
                                  width: globalSingalResetButtonWidth,
                                ),
                              ],
                            )
                          : ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Calculate Pure',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: compare_forward_calulateMix,
                                      // overlayColor: overlayColor,
                                      // trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          compare_forward_calulateMix = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Calculate Mix',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                  ],
                                ),
                                //Heading of Calculator
                                const GlobalRowCompareWidget2TEXT(
                                  title1: 'Calc1 ',
                                  title2: 'Calc2 ',
                                ),

                                //Content Of Calculator

                                // Kappas
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Cotton Seed',
                                    controller1: inputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapas2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Expense
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Expense',
                                    controller1: inputexpense1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputexpense2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Cotton Seed
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Rate',
                                    controller1: inputoilrate1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputoilrate2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //oil
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil',
                                    controller1: inputkapasia1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputkapasia2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //Out Turn / Utaro
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Cake',
                                    controller1: inpututaro1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inpututaro2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                //Shortage / Ghati
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Packaging Size',
                                    controller1: inputghati1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: inputghati2,
                                    onchaned1: (string) {
                                      _updateValuesForCalculator1();
                                    },
                                    onchane2: (string) {
                                      _updateValuesForCalculator2();
                                    }),

                                // Final Answer
                                GlobalRowCompareWidget2StreamBuilderWithAnswer(
                                  result1: answer,
                                  result2: answer2,
                                  subtext1: '₹',
                                  subtext2: '₹',
                                  title1: 'Oil Cake Coast',
                                  title2: 'Oil Cake Coast',
                                ),

                                GlobalRowCompareWidget2Button(
                                  onpressed1: () {
                                    inputkapas1.clear();
                                    inputexpense1.clear();
                                    inputoilrate1.clear();
                                    inputkapasia1.clear();
                                    inpututaro1.clear();
                                    inputghati1.clear();
                                    answer = 0;
                                  },
                                  onpressed2: () {
                                    inputkapas2.clear();
                                    inputexpense2.clear();
                                    inputoilrate2.clear();
                                    inputkapasia2.clear();
                                    inpututaro2.clear();
                                    inputghati2.clear();
                                    answer2 = 0;
                                  },
                                  text1: 'RESET 1',
                                  text2: 'RESET 2',
                                ),

                                SizedBox(height: 20.h),
                                GlobalResultBuilderForResults(
                                  substreamtext: '₹',
                                  streamtitletext: 'Oil Cake Difference',
                                  result: diff,
                                ),

                                // Reset All Button
                                SizedBox(
                                  height: 20.h,
                                ),

                                GlobalButtonSimpleText(
                                  onPressed: () {
                                    inputkapas1.clear();
                                    inputexpense1.clear();
                                    inputoilrate1.clear();
                                    inputkapasia1.clear();
                                    inpututaro1.clear();
                                    inputghati1.clear();
                                    inputkapas2.clear();
                                    inputexpense2.clear();
                                    inputoilrate2.clear();
                                    inputkapasia2.clear();
                                    inpututaro2.clear();
                                    inputghati2.clear();
                                    diff = 0;
                                    answer = 0;
                                    dubanswer = 0;
                                    answer2 = 0;
                                    dubanswer2 = 0;
                                    dubdiff = 0;
                                  },
                                  buttontext: 'Reset All',
                                  height: globalSingalResetButtonHeight,
                                  width: globalSingalResetButtonWidth,
                                ),
                              ],
                            ))
                  : Container(
                      child: compare_reverse_calulateMix
                          ? ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Calculate Pure',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: compare_reverse_calulateMix,
                                      // overlayColor: overlayColor,
                                      // trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          compare_reverse_calulateMix = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Calculate Mix',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                  ],
                                ),
                                //Heading of Calculator
                                const GlobalRowCompareWidget2TEXT(
                                  title1: 'Calc1 ',
                                  title2: 'Calc2 ',
                                ),

                                //Content Of Calculator

                                // Kappas
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Cake Cost',
                                    controller1: reverseinputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapas2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Hull Rate',
                                    controller1: reverseinputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapas2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Cotton Seed Qty.',
                                    controller1: reverseinputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapas2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Nothing
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Hull Qty.',
                                    controller1: reverseinputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapas2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Expense
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Expense',
                                    controller1: reverseinputexpense1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputexpense2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Cotton Seed
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Rate',
                                    controller1: reverseinputoilrate1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputoilrate2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //oil
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil',
                                    controller1: reverseinputkapasia1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapasia2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //Out Turn / Utaro
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Shortage',
                                    controller1: reverseinpututaro1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinpututaro2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //Shortage / Ghati
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Packaging Size',
                                    controller1: reverseinputghati1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputghati2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Final Answer
                                GlobalRowCompareWidget2StreamBuilderWithAnswer(
                                  result1: reverseanswer,
                                  result2: reverseanswer2,
                                  subtext1: '₹',
                                  subtext2: '₹',
                                  title1: 'Cotton Seed',
                                  title2: 'Cotton Seed',
                                ),

                                GlobalRowCompareWidget2Button(
                                  onpressed1: () {
                                    reverseinputkapas1.clear();
                                    reverseinputexpense1.clear();
                                    reverseinputoilrate1.clear();
                                    reverseinputkapasia1.clear();
                                    reverseinpututaro1.clear();
                                    reverseinputghati1.clear();
                                    reverseanswer = 0;
                                  },
                                  onpressed2: () {
                                    reverseinputkapas2.clear();
                                    reverseinputexpense2.clear();
                                    reverseinputoilrate2.clear();
                                    reverseinputkapasia2.clear();
                                    reverseinpututaro2.clear();
                                    reverseinputghati2.clear();
                                    reverseanswer2 = 0;
                                  },
                                  text1: 'RESET 1',
                                  text2: 'RESET 2',
                                ),

                                // Khandi Diffrnce or Stram result
                                SizedBox(height: 20.h),
                                GlobalResultBuilderForResults(
                                  substreamtext: '₹',
                                  streamtitletext: 'Cotton Seed Difference',
                                  result: reversediff,
                                ),

                                // Reset All Button
                                SizedBox(
                                  height: 20.h,
                                ),
                                GlobalButtonSimpleText(
                                  onPressed: () {
                                    reverseinputkapas1.clear();
                                    reverseinputexpense1.clear();
                                    reverseinputoilrate1.clear();
                                    reverseinputkapasia1.clear();
                                    reverseinpututaro1.clear();
                                    reverseinputghati1.clear();
                                    reverseinputkapas2.clear();
                                    reverseinputexpense2.clear();
                                    reverseinputoilrate2.clear();
                                    reverseinputkapasia2.clear();
                                    reverseinpututaro2.clear();
                                    reverseinputghati2.clear();

                                    reversediff = 0;
                                    reverseanswer = 0;
                                    reversedubanswer = 0;
                                    reverseanswer2 = 0;
                                    reversedubanswer2 = 0;
                                    reversedubdiff = 0;
                                  },
                                  buttontext: 'Reset All',
                                  height: globalSingalResetButtonHeight,
                                  width: globalSingalResetButtonWidth,
                                ),
                              ],
                            )
                          : ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Calculate Pure',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: compare_reverse_calulateMix,
                                      // overlayColor: overlayColor,
                                      // trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.black),
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          compare_reverse_calulateMix = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Calculate Mix',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 70.sp),
                                    ),
                                  ],
                                ),
                                //Heading of Calculator
                                const GlobalRowCompareWidget2TEXT(
                                  title1: 'Calc1 ',
                                  title2: 'Calc2 ',
                                ),

                                //Content Of Calculator

                                // Kappas
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Cake Cost',
                                    controller1: reverseinputkapas1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapas2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Expense
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Expense',
                                    controller1: reverseinputexpense1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputexpense2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // // Answer of Kappas + Expense
                                // GlobalRowCompareWidget2StreamBuilder(
                                //   stream1: result_addition_inputkapas1_and_inputexpense1.stream,
                                //   stream2: result_addition_inputkapas2_and_inputexpense2.stream,
                                //   subtext1: '₹',
                                //   subtext2: '₹',
                                //   title1: 'Total',
                                //   title2: 'Total',
                                // ),

                                // Cotton Seed
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Rate',
                                    controller1: reverseinputoilrate1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputoilrate2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //oil
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil',
                                    controller1: reverseinputkapasia1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputkapasia2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //Out Turn / Utaro
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Oil Cake',
                                    controller1: reverseinpututaro1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinpututaro2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                //Shortage / Ghati
                                GlobalRowCompareWidget2textfielsWithOnchanges(
                                    title: 'Packaging Size',
                                    controller1: reverseinputghati1,
                                    subtitle: 'nothing',
                                    height: 0,
                                    width: 0,
                                    controller2: reverseinputghati2,
                                    onchaned1: (string) {
                                      _reverseupdateValues_for_calculator1();
                                    },
                                    onchane2: (string) {
                                      _reverseupdateValues_for_calculator2();
                                    }),

                                // Final Answer
                                GlobalRowCompareWidget2StreamBuilderWithAnswer(
                                  result1: reverseanswer,
                                  result2: reverseanswer2,
                                  subtext1: '₹',
                                  subtext2: '₹',
                                  title1: 'Cotton Seed',
                                  title2: 'Cotton Seed',
                                ),

                                GlobalRowCompareWidget2Button(
                                  onpressed1: () {
                                    reverseinputkapas1.clear();
                                    reverseinputexpense1.clear();
                                    reverseinputoilrate1.clear();
                                    reverseinputkapasia1.clear();
                                    reverseinpututaro1.clear();
                                    reverseinputghati1.clear();
                                    reverseanswer = 0;
                                  },
                                  onpressed2: () {
                                    reverseinputkapas2.clear();
                                    reverseinputexpense2.clear();
                                    reverseinputoilrate2.clear();
                                    reverseinputkapasia2.clear();
                                    reverseinpututaro2.clear();
                                    reverseinputghati2.clear();
                                    reverseanswer2 = 0;
                                  },
                                  text1: 'RESET 1',
                                  text2: 'RESET 2',
                                ),

                                // Khandi Diffrnce or Stram result
                                SizedBox(height: 20.h),
                                GlobalResultBuilderForResults(
                                  substreamtext: '₹',
                                  streamtitletext: 'Cotton Seed Difference',
                                  result: reversediff,
                                ),

                                // Reset All Button
                                SizedBox(
                                  height: 20.h,
                                ),
                                GlobalButtonSimpleText(
                                  onPressed: () {
                                    reverseinputkapas1.clear();
                                    reverseinputexpense1.clear();
                                    reverseinputoilrate1.clear();
                                    reverseinputkapasia1.clear();
                                    reverseinpututaro1.clear();
                                    reverseinputghati1.clear();
                                    reverseinputkapas2.clear();
                                    reverseinputexpense2.clear();
                                    reverseinputoilrate2.clear();
                                    reverseinputkapasia2.clear();
                                    reverseinpututaro2.clear();
                                    reverseinputghati2.clear();
                                    reversediff = 0;
                                    reverseanswer = 0;
                                    reversedubanswer = 0;
                                    reverseanswer2 = 0;
                                    reversedubanswer2 = 0;
                                    reversedubdiff = 0;
                                  },
                                  buttontext: 'Reset All',
                                  height: globalSingalResetButtonHeight,
                                  width: globalSingalResetButtonWidth,
                                ),
                              ],
                            ),
                    )),
          floatingActionButton: FloatingButton(
            screenshotController: screenshotController,
          )),
    );
  }
}
