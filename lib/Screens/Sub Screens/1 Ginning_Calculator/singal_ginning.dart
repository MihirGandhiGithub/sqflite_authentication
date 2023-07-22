import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/gradient_text.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';
import 'compare_ginning.dart';

class HomeSingalGinningCalculator extends StatefulWidget {
  const HomeSingalGinningCalculator({Key? key}) : super(key: key);

  @override
  State<HomeSingalGinningCalculator> createState() =>
      _HomeSingalGinningCalculatorState();
}

class _HomeSingalGinningCalculatorState
    extends State<HomeSingalGinningCalculator> {
  bool _isForwardGinning = true;
  double answer = 0;
  double reverseanswer = 0;
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
        answer = double.parse(f.toStringAsFixed(2));
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
        answer = double.parse(f.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        answer = double.parse(sum1.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        double temp = sum1 * 100;
        answer = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

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
        reverseanswer = double.parse(f.toStringAsFixed(2));
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
        reverseanswer = double.parse(f.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 == 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        reverseanswer = double.parse(sum1.toStringAsFixed(2));
      });
    } else if (sum1 != 0 &&
        storeInputKapasia1 != 0 &&
        storeInputUtaro1 == 0 &&
        storeInputGhati1 == 0) {
      setState(() {
        double temp = sum1 * 0.2812 / 5;
        reverseanswer = double.parse(temp.toStringAsFixed(2));
      });
    }
  }

  // for focusing  a node
  FocusNode focusnodekapas1 = FocusNode();

  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();

  final reverseinputkapas1 = TextEditingController();
  final reverseinputexpense1 = TextEditingController();
  final reverseinputkapasia1 = TextEditingController();
  final reverseinpututaro1 = TextEditingController();
  final reverseinputghati1 = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: screenshotController,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: GlobalCustomAppBar(
              sliderText1: 'Forward Ginning',
              sliderText2: 'Reverse Ginning',
              appbarText: 'Ginning Calculator',
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
                        // Page Main Content
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Kappas',
                          controller: inputkapas1,
                          subtitle: '₹/20kg',
                          onchaned: (string) {
                            _updateValuesForCalculator1();
                          },
                        ),

                        // Expense
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Expense',
                          controller: inputexpense1,
                          subtitle: '₹/20kg',
                          onchaned: (string) {
                            _updateValuesForCalculator1();
                          },
                        ),

                        // Cotton Seed
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Cotton Seed',
                          controller: inputkapasia1,
                          subtitle: '₹/20kg',
                          onchaned: (string) {
                            _updateValuesForCalculator1();
                          },
                        ),

                        // Out Turn / Utaro
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Out Turn / Utaro',
                          controller: inpututaro1,
                          subtitle: 'Percentage %',
                          onchaned: (string) {
                            _updateValuesForCalculator1();
                          },
                        ),

                        // Shortage / Ghati
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Shortage / Ghati',
                          controller: inputghati1,
                          subtitle: 'Percentage %',
                          onchaned: (string) {
                            _updateValuesForCalculator1();
                          },
                        ),

                        SizedBox(height: 30.h),

                        // Stram result
                        GlobalResultBuilderForResults(
                          substreamtext: '₹/Khandi',
                          streamtitletext: 'Cotton Cost',
                          result: answer,
                        ),

                        // Reset Button
                        GlobalButtonSimpleText(
                          onPressed: () {
                            inputkapas1.clear();
                            inputexpense1.clear();
                            inputkapasia1.clear();
                            inpututaro1.clear();
                            inputghati1.clear();
                            answer = 0;

                            focusnodekapas1.requestFocus();
                          },
                          buttontext: 'Reset',
                          height: globalSingalResetButtonHeight,
                          width: globalSingalResetButtonWidth,
                        ),

                        //Compare Button
                        GlobalButtonGradientText(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Home_Compare_Ginning_Calculator(
                                  forOrReverse: true,
                                ),
                              ),
                            );
                          },
                          buttontext: 'Compare',
                          height: globalSingalComareButtonHeight,
                          width: globalSingalComareButtonWidth,
                        ),
                      ],
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Cotton Rate',
                          controller: reverseinputkapas1,
                          subtitle: '₹/Bale',
                          onchaned: (string) {
                            _reverseUpdateValuesForCalculator1();
                          },
                        ),

                        // Expense
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Expense',
                          controller: reverseinputexpense1,
                          subtitle: '₹/20kg',
                          onchaned: (string) {
                            _reverseUpdateValuesForCalculator1();
                          },
                        ),

                        // Cotton Seed
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Cotton Seed',
                          controller: reverseinputkapasia1,
                          subtitle: '₹/20kg',
                          onchaned: (string) {
                            _reverseUpdateValuesForCalculator1();
                          },
                        ),

                        // Out Turn / Utaro
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Out Turn / Utaro',
                          controller: reverseinpututaro1,
                          subtitle: 'Percentage %',
                          onchaned: (string) {
                            _reverseUpdateValuesForCalculator1();
                          },
                        ),

                        // Shortage / Ghati
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Shortage / Ghati',
                          controller: reverseinputghati1,
                          subtitle: 'Percentage %',
                          onchaned: (string) {
                            _reverseUpdateValuesForCalculator1();
                          },
                        ),

                        SizedBox(height: 30.h),

                        // Stram result
                        GlobalResultBuilderForResults(
                          substreamtext: '₹/20Kg',
                          streamtitletext: 'Kappas Coast',
                          result: reverseanswer,
                        ),

                        // Reset Button
                        GlobalButtonSimpleText(
                          onPressed: () {
                            inputkapas1.clear();
                            inputexpense1.clear();
                            inputkapasia1.clear();
                            inpututaro1.clear();
                            inputghati1.clear();
                          },
                          buttontext: 'Reset',
                          height: globalSingalResetButtonHeight,
                          width: globalSingalResetButtonWidth,
                        ),

                        //Compare Button
                        GlobalButtonGradientText(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Home_Compare_Ginning_Calculator(
                                  forOrReverse: false,
                                ),
                              ),
                            );
                          },
                          buttontext: 'Compare',
                          height: globalSingalComareButtonHeight,
                          width: globalSingalComareButtonWidth,
                        ),
                      ],
                    ),
            ),
            floatingActionButton: FloatingButton(
              screenshotController: screenshotController,
            )));
  }
}
