import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Globaly Accesible/Row  widget with 2 items.dart';

class Home_Compare_Ice_Parity extends StatefulWidget {
  final bool forOrReverse;
  const Home_Compare_Ice_Parity({Key? key, required this.forOrReverse})
      : super(key: key);

  @override
  State<Home_Compare_Ice_Parity> createState() =>
      _Home_Compare_Ice_ParityState();
}

class _Home_Compare_Ice_ParityState extends State<Home_Compare_Ice_Parity>
    with SingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();
  late bool _isForwardGinning;

  // for calculator 1
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();

  //for calculator 2
  final inputkapas2 = TextEditingController();
  final inputexpense2 = TextEditingController();
  final inputkapasia2 = TextEditingController();
  final inpututaro2 = TextEditingController();
  final inputghati2 = TextEditingController();

  double answer1 = 0;
  double dubanswer1 = 0;
  double answer2 = 0;
  double dubanswer2 = 0;
  double diff = 0;
  double dubdiff = 0;

  void _updateValuesForCalculator1() {
    double storeInputKapas1 = double.tryParse(inputkapas1.text) ?? 0;
    double storeInputExpense1 = double.tryParse(inputexpense1.text) ?? 0;
    double storeInputKapasia1 = double.tryParse(inputkapasia1.text) ?? 0;
    double storeInputUtaro1 = double.tryParse(inpututaro1.text) ?? 0;
    double storeInputGhati1 = double.tryParse(inputghati1.text) ?? 0;
    double sum1 = (storeInputKapas1 + storeInputExpense1);

    if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 != 0) {
      double a = sum1 * 100;
      double b = 100 - storeInputUtaro1 - storeInputGhati1;
      double c = storeInputKapasia1 * b;
      double d = a - c;
      double e = d / storeInputUtaro1;
      double f = e * 17.78;

      setState(() {
        dubanswer1 = f;
        answer1 = double.parse(f.toStringAsFixed(2));
        dubdiff = dubanswer1 - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 == 0) {
      double a = sum1 * 100;
      double b = 100 - storeInputUtaro1;
      double c = storeInputKapasia1 * b;
      double d = a - c;
      double e = d / storeInputUtaro1;
      double f = e * 17.78;

      setState(() {
        answer1 = double.parse(f.toStringAsFixed(2));
        dubanswer1 = f;
        dubdiff = dubanswer1 - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        answer1 = double.parse(sum1.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        double temp = sum1 * 0.35;
        answer1 = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

  void _updateValuesForCalculator2() {
    double storeInputKapas2 = double.tryParse(inputkapas2.text) ?? 0;
    double storeInputExpense2 = double.tryParse(inputexpense2.text) ?? 0;
    double storeInputKapasia2 = double.tryParse(inputkapasia2.text) ?? 0;
    double storeInputUtaro2 = double.tryParse(inpututaro2.text) ?? 0;
    double storeInputGhati2 = double.tryParse(inputghati2.text) ?? 0;
    double sum2 = (storeInputKapas2 + storeInputExpense2);

    if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 != 0) {
      double a = sum2 * 100;
      double b = 100 - storeInputUtaro2 - storeInputGhati2;
      double c = storeInputKapasia2 * b;
      double d = a - c;
      double e = d / storeInputUtaro2;
      double f = e * 17.78;

      setState(() {
        answer2 = double.parse(f.toStringAsFixed(2));
        dubanswer2 = f;
        dubdiff = dubanswer1 - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 == 0) {
      double a = sum2 * 100;
      double b = 100 - storeInputUtaro2;
      double c = storeInputKapasia2 * b;
      double d = a - c;
      double e = d / storeInputUtaro2;
      double f = e * 17.78;

      setState(() {
        answer2 = double.parse(f.toStringAsFixed(2));
        dubanswer2 = f;
        dubdiff = dubanswer1 - dubanswer2;
        diff = double.parse(dubdiff.toStringAsFixed(2)).abs();
      });
    } else if (sum2 != 0 &&
        storeInputKapasia2 == 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        answer2 = double.parse(sum2.toStringAsFixed(2));
      });
    } else if (sum2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        double temp = sum2 * 0.35;
        answer2 = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

  // for calculator 1
  final reverseinputkapas1 = TextEditingController();
  final reverseinputexpense1 = TextEditingController();
  final reverseinputkapasia1 = TextEditingController();
  final reverseinpututaro1 = TextEditingController();
  final reverseinputghati1 = TextEditingController();

  //for calculator 2
  final reverseinputkapas2 = TextEditingController();
  final reverseinputexpense2 = TextEditingController();
  final reverseinputkapasia2 = TextEditingController();
  final reverseinpututaro2 = TextEditingController();
  final reverseinputghati2 = TextEditingController();

  double reverseanswer1 = 0;
  double reversedubanswer1 = 0;
  double reverseanswer2 = 0;
  double reversedubanswer2 = 0;
  double reversediff = 0;
  double reversedubdiff = 0;

  void _reverseUpdateValuesForCalculator1() {
    double storeInputKapas1 = double.tryParse(reverseinputkapas1.text) ?? 0;
    double storeInputExpense1 = double.tryParse(reverseinputexpense1.text) ?? 0;
    double storeInputKapasia1 = double.tryParse(reverseinputkapasia1.text) ?? 0;
    double storeInputUtaro1 = double.tryParse(reverseinpututaro1.text) ?? 0;
    double storeInputGhati1 = double.tryParse(reverseinputghati1.text) ?? 0;
    double sum1 = (storeInputKapas1 + storeInputExpense1);

    if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 != 0) {
      double a1 = (storeInputKapas1 * 0.2812 / 5);
      double a2 = a1 * storeInputUtaro1;
      double a3 = 100 - storeInputUtaro1 - storeInputGhati1;
      double a4 = a3 * storeInputKapasia1;
      double a5 = a4 + a2;
      double a6 = a5 / 100;
      double f = a6 - storeInputExpense1;

      setState(() {
        reversedubanswer1 = f;
        reverseanswer1 = double.parse(f.toStringAsFixed(2));
        reversedubdiff = reversedubanswer1 - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas1 != 0 &&
        storeInputExpense1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 != 0 &&
        storeInputGhati1 == 0) {
      double a1 = (storeInputKapas1 * 0.2812 / 5);
      double a2 = a1 * storeInputUtaro1;
      double a3 = 100 - storeInputUtaro1;
      double a4 = a3 * storeInputKapasia1;
      double a5 = a4 + a2;
      double a6 = a5 / 100;
      double f = a6 - storeInputExpense1;

      setState(() {
        reverseanswer1 = double.parse(f.toStringAsFixed(2));
        reversedubanswer1 = f;
        reversedubdiff = reversedubanswer1 - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer1 = double.parse(sum1.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        double temp = sum1 * 0.35;
        reverseanswer1 = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

  void _reverseUpdateValuesForCalculator2() {
    double storeInputKapas2 = double.tryParse(reverseinputkapas2.text) ?? 0;
    double storeInputExpense2 = double.tryParse(reverseinputexpense2.text) ?? 0;
    double storeInputKapasia2 = double.tryParse(reverseinputkapasia2.text) ?? 0;
    double storeInputUtaro2 = double.tryParse(reverseinpututaro2.text) ?? 0;
    double storeInputGhati2 = double.tryParse(reverseinputghati2.text) ?? 0;
    double sum2 = (storeInputKapas2 + storeInputExpense2);

    if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 != 0) {
      double a1 = (storeInputKapas2 * 0.2812 / 5);
      double a2 = a1 * storeInputUtaro2;
      double a3 = 100 - storeInputUtaro2 - storeInputGhati2;
      double a4 = a3 * storeInputKapasia2;
      double a5 = a4 + a2;
      double a6 = a5 / 100;
      double f = a6 - storeInputExpense2;

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer1 - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (storeInputKapas2 != 0 &&
        storeInputExpense2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 != 0 &&
        storeInputGhati2 == 0) {
      double a1 = (storeInputKapas2 * 0.2812 / 5);
      double a2 = a1 * storeInputUtaro2;
      double a3 = 100 - storeInputUtaro2;
      double a4 = a3 * storeInputKapasia2;
      double a5 = a4 + a2;
      double a6 = a5 / 100;
      double f = a6 - storeInputExpense2;

      setState(() {
        reverseanswer2 = double.parse(f.toStringAsFixed(2));
        reversedubanswer2 = f;
        reversedubdiff = reversedubanswer1 - reversedubanswer2;
        reversediff = double.parse(reversedubdiff.toStringAsFixed(2)).abs();
      });
    } else if (sum2 != 0 &&
        storeInputKapasia2 == 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        reverseanswer2 = double.parse(sum2.toStringAsFixed(2));
      });
    } else if (sum2 != 0 &&
        storeInputKapasia2 != 0 &&
        storeInputUtaro2 == 0 &&
        storeInputGhati2 == 0) {
      setState(() {
        double temp = sum2 * 0.35;
        reverseanswer2 = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

  @override
  void initState() {
    _isForwardGinning = widget.forOrReverse;
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

  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: screenshotController,
        child: Scaffold(
            appBar: GlobalCustomAppBar(
              sliderText1: 'Physical Cotton',
              sliderText2: 'MCX',
              appbarText: 'ICE Compare Calculator',
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
                    ? ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          //Heading of Calculator
                          const GlobalRowCompareWidget2TEXT(
                            title1: 'Calc1 ',
                            title2: 'Calc2 ',
                          ),

                          //Content Of Calculator
                          // Kappas

                          GlobalRowCompareWidget2textfielsWithOnchanges(
                              title: 'MCX Future Rate',
                              controller1: inputkapas1,
                              subtitle: 'Kappas',
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
                              title: 'ICE Future Rate',
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
                              title: 'Exchange Rate',
                              controller1: inputkapasia1,
                              subtitle: 'Cotton Seed',
                              height: 0,
                              width: 0,
                              controller2: inputkapasia2,
                              onchaned1: (string) {
                                _updateValuesForCalculator1();
                              },
                              onchane2: (string) {
                                _updateValuesForCalculator2();
                              }),

                          // Final Answer
                          GlobalRowCompareWidget2StreamBuilderWithAnswer(
                            result1: answer1,
                            result2: answer2,
                            subtext1: '₹',
                            subtext2: '₹',
                            title1: 'Cents/LB',
                            title2: 'Cents/LB',
                          ),

                          GlobalRowCompareWidget2Button(
                            onpressed1: () {
                              inputkapas1.clear();
                              inputexpense1.clear();
                              inputkapasia1.clear();
                              inpututaro1.clear();
                              inputghati1.clear();
                              answer1 = 0;
                              // result_output_difference.add(0);
                              // focusnodekapas1.requestFocus();
                            },
                            onpressed2: () {
                              inputkapas2.clear();
                              inputexpense2.clear();
                              inputkapasia2.clear();
                              inpututaro2.clear();
                              inputghati2.clear();
                              answer2 = 0;
                              // result_output_difference.add(0);
                              // focusnodekapas2.requestFocus();
                            },
                            text1: 'RESET 1',
                            text2: 'RESET 2',
                          ),
                          //
                          // // Khandi Diffrnce or Stram result
                          SizedBox(height: 20.h),
                          GlobalResultBuilderForResults(
                            substreamtext: 'Parity',
                            streamtitletext: 'Cents/LB Difference',
                            result: diff,
                          ),

                          SizedBox(height: 20.h),

                          // Rseet All Button
                          GlobalButtonSimpleText(
                            onPressed: () {
                              inputkapas1.clear();
                              inputexpense1.clear();
                              inputkapasia1.clear();
                              inpututaro1.clear();
                              inputghati1.clear();
                              inputkapas2.clear();
                              inputexpense2.clear();
                              inputkapasia2.clear();
                              inpututaro2.clear();
                              inputghati2.clear();
                              diff = 0;
                              answer1 = 0;
                              answer2 = 0;
                            },
                            buttontext: 'Reset All',
                            height: globalSingalResetButtonHeight,
                            width: globalSingalResetButtonWidth,
                          ),
                        ],
                      )
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          //Heading of Calculator
                          const GlobalRowCompareWidget2TEXT(
                            title1: 'Calc1 ',
                            title2: 'Calc2 ',
                          ),

                          //Content Of Calculator

                          GlobalRowCompareWidget2textfielsWithOnchanges(
                              title: 'Cotton Rate',
                              controller1: inputkapas1,
                              subtitle: 'Kappas',
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
                              title: 'ICE Future Rate',
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
                              title: 'Exchange Rate',
                              controller1: inputkapasia1,
                              subtitle: 'Cotton Seed',
                              height: 0,
                              width: 0,
                              controller2: inputkapasia2,
                              onchaned1: (string) {
                                _updateValuesForCalculator1();
                              },
                              onchane2: (string) {
                                _updateValuesForCalculator2();
                              }),

                          // Final Answer
                          GlobalRowCompareWidget2StreamBuilderWithAnswer(
                            result1: answer1,
                            result2: answer2,
                            subtext1: '₹',
                            subtext2: '₹',
                            title1: 'Cents/LB',
                            title2: 'Cents/LB',
                          ),

                          GlobalRowCompareWidget2Button(
                            onpressed1: () {
                              reverseinputkapas1.clear();
                              reverseinputexpense1.clear();
                              reverseinputkapasia1.clear();
                              reverseinpututaro1.clear();
                              reverseinputghati1.clear();
                              reverseanswer1 = 0;
                              // result_output_difference.add(0);
                              // focusnodekapas1.requestFocus();
                            },
                            onpressed2: () {
                              reverseinputkapas2.clear();
                              reverseinputexpense2.clear();
                              reverseinputkapasia2.clear();
                              reverseinpututaro2.clear();
                              reverseinputghati2.clear();
                              reverseanswer2 = 0;
                              // result_output_difference.add(0);
                              // focusnodekapas2.requestFocus();
                            },
                            text1: 'RESET 1',
                            text2: 'RESET 2',
                          ),

                          // Khandi Diffrnce or Stram result
                          SizedBox(height: 20.h),
                          GlobalResultBuilderForResults(
                            substreamtext: 'Parity',
                            streamtitletext: 'Cents/LB Difference',
                            result: reversediff,
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          // Reset All Button
                          GlobalButtonSimpleText(
                            onPressed: () {
                              reverseinputkapas1.clear();
                              reverseinputexpense1.clear();
                              reverseinputkapasia1.clear();
                              reverseinpututaro1.clear();
                              reverseinputghati1.clear();
                              reverseinputkapas2.clear();
                              reverseinputexpense2.clear();
                              reverseinputkapasia2.clear();
                              reverseinpututaro2.clear();
                              reverseinputghati2.clear();
                              reversediff = 0;
                              reverseanswer1 = 0;
                              reverseanswer2 = 0;
                            },
                            buttontext: 'Reset All',
                            height: globalSingalResetButtonHeight,
                            width: globalSingalResetButtonWidth,
                          ),
                        ],
                      )),
            floatingActionButton: FloatingButton(
              screenshotController: screenshotController,
            )));
  }
}
