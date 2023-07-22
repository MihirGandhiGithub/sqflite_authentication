import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/gradient_text.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';
import 'compare_IceParityChart.dart';

class HomeICEParityChart extends StatefulWidget {
  const HomeICEParityChart({Key? key}) : super(key: key);

  @override
  State<HomeICEParityChart> createState() => _HomeICEParityChartState();
}

class _HomeICEParityChartState extends State<HomeICEParityChart>
    with SingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();
  bool calulateLB = false;
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  void _updateValuesForCalculator() {}
  bool _isForwardGinning = true;

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
          appBar: GlobalCustomAppBar(
            sliderText1: 'Physical Cotton',
            sliderText2: 'MCX',
            appbarText: 'ICE Parity',
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
                      children: [
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'MCX Future Rate',
                          controller: inputkapas1,
                          subtitle: '₹/Bale',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Expenses
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'ICE Future Rate',
                          controller: inputkapas1,
                          subtitle: 'Cents/LB',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Cotton Seed
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Exchange Rate',
                          controller: inputkapas1,
                          subtitle: 'USD/INR',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Stram result Export Rate 1
                        const GlobalResultBuilderForResults(
                          substreamtext: 'Parity',
                          streamtitletext: 'Cents/LB',
                          result: 0,
                        ),

                        // Reset Button
                        GlobalButtonSimpleText(
                          onPressed: () {
                            inputkapas1.clear();
                            inputexpense1.clear();
                            inputkapasia1.clear();
                            inpututaro1.clear();
                            inputghati1.clear();
                            // answer = 0;
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
                                builder: (context) => Home_Compare_Ice_Parity(
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
                      children: [
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Cotton Rate',
                          controller: inputkapas1,
                          subtitle: '₹/Candy',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Expenses
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'ICE Future Rate',
                          controller: inputkapas1,
                          subtitle: 'Cents?LB',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Cotton Seed
                        GlobalRowWidgetWithOnchanged(
                          height: globalSingalTextfiedHeight,
                          width: globalSingalTextfiedWidth,
                          title: 'Exchange Rate',
                          controller: inputkapas1,
                          subtitle: 'Cents/LB',
                          onchaned: (string) {
                            _updateValuesForCalculator();
                          },
                        ),

                        // Stram result Export Rate 1
                        const GlobalResultBuilderForResults(
                          substreamtext: 'Parity',
                          streamtitletext: 'Cents/LB',
                          result: 0,
                        ),

                        // Reset Button
                        GlobalButtonSimpleText(
                          onPressed: () {
                            inputkapas1.clear();
                            inputexpense1.clear();
                            inputkapasia1.clear();
                            inpututaro1.clear();
                            inputghati1.clear();
                            // answer = 0;
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
                                builder: (context) => Home_Compare_Ice_Parity(
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
                    )),
          floatingActionButton: FloatingButton(
            screenshotController: screenshotController,
          )),
    );
  }
}
