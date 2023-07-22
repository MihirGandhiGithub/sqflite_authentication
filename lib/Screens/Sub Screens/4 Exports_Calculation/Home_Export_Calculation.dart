import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/gradient_text.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';
import 'compare_export.dart';

class HomeExportCalculation extends StatefulWidget {
  const HomeExportCalculation({Key? key}) : super(key: key);

  @override
  State<HomeExportCalculation> createState() => _HomeExportCalculationState();
}

class _HomeExportCalculationState extends State<HomeExportCalculation>
    with SingleTickerProviderStateMixin {
  bool calulateLB = false;
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  void _updateValues_for_calculator1() {}
  bool _isForwardGinning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalCustomAppBar(
        sliderText1: 'Export Forward',
        sliderText2: 'Reverse Export',
        appbarText: 'Export Calculator',
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
                      title: 'Cotton Rate',
                      controller: inputkapas1,
                      subtitle: '₹/Bale',
                      onchaned: (string) {
                        _updateValues_for_calculator1();
                      },
                    ),

                    // Expenses
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Expenses',
                      controller: inputkapas1,
                      subtitle: '₹/Bale',
                      onchaned: (string) {
                        _updateValues_for_calculator1();
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
                        _updateValues_for_calculator1();
                      },
                    ),

                    // Stram result Export Rate 1
                    const GlobalResultBuilderForResults(
                      substreamtext: 'Cents/LB',
                      streamtitletext: 'Export Rate',
                      result: 0,
                    ),

                    // Stram result Export Rate 2
                    const GlobalResultBuilderForResults(
                      substreamtext: 'USD/Kg',
                      streamtitletext: 'Export Rate',
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
                            builder: (context) =>
                                Home_Compare_export_Calculator(
                              forOrReverse: true,
                              compareReverseCalculateUSD: calulateLB,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cents/LB',
                          style:
                              TextStyle(color: Colors.black, fontSize: 70.sp),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: calulateLB,
                          // overlayColor: overlayColor,
                          // trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(
                              Colors.black),
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              calulateLB = value;
                            });
                          },
                        ),
                        Text(
                          'USD/Kg',
                          style:
                              TextStyle(color: Colors.black, fontSize: 70.sp),
                        ),
                      ],
                    ),
                    calulateLB
                        ? GlobalRowWidgetWithOnchanged(
                            height: globalSingalTextfiedHeight,
                            width: globalSingalTextfiedWidth,
                            title: 'Export Rate',
                            controller: inputkapas1,
                            subtitle: 'USD/Kg',
                            onchaned: (string) {
                              _updateValues_for_calculator1();
                            },
                          )
                        : GlobalRowWidgetWithOnchanged(
                            height: globalSingalTextfiedHeight,
                            width: globalSingalTextfiedWidth,
                            title: 'Export Rate',
                            controller: inputkapas1,
                            subtitle: 'Cents/LB',
                            onchaned: (string) {
                              _updateValues_for_calculator1();
                            },
                          ),

                    // Expenses
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Expenses',
                      controller: inputkapas1,
                      subtitle: '₹/Bale',
                      onchaned: (string) {
                        _updateValues_for_calculator1();
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
                        _updateValues_for_calculator1();
                      },
                    ),

                    // Stram result Export Rate 1
                    const GlobalResultBuilderForResults(
                      substreamtext: 'Rs./Candy',
                      streamtitletext: 'Realisation',
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
                            builder: (context) =>
                                Home_Compare_export_Calculator(
                              forOrReverse: false,
                              compareReverseCalculateUSD: calulateLB,
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
    );
  }
}
