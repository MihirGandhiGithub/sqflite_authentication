import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/gradient_text.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/singalerow_oneboxtext.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';
import 'compare_spinning.dart';

class HomeSpinningCalculator extends StatefulWidget {
  const HomeSpinningCalculator({Key? key}) : super(key: key);

  @override
  State<HomeSpinningCalculator> createState() => _HomeSpinningCalculatorState();
}

class _HomeSpinningCalculatorState extends State<HomeSpinningCalculator>
    with SingleTickerProviderStateMixin {
  // for focusing  a node
  FocusNode focusnodekapas1 = FocusNode();

  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  bool _isForwardGinning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalCustomAppBar(
        sliderText1: 'Loss Yarn',
        sliderText2: 'Profit Yarn',
        appbarText: 'Spinning Calculator',
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
                    // Yarn Count
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Yarn Count',
                      controller: inputghati1,
                      subtitle: '',
                      onchaned: (String) {},
                    ),

                    //Cotton Rate
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Cotton Rate',
                      controller: inputexpense1,
                      subtitle: '₹/Bale',
                      onchaned: (String) {},
                    ),

                    //  Result Cotton Rate
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Cotton Rate',
                      subtext: '',
                    ),

                    // Yield
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Yield',
                      controller: inputexpense1,
                      subtitle: 'Percentage %',
                      onchaned: (String) {},
                    ),

                    // Waste Recovery
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Waste Recovery',
                      controller: inputexpense1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    // Material Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Materail Coast',
                      subtext: '',
                    ),

                    // Coversation Coast
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Coversation Coast',
                      controller: inputexpense1,
                      subtitle: '₹/kg/Count',
                      onchaned: (String) {},
                    ),

                    // Commission
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Commission',
                      controller: inputexpense1,
                      subtitle: 'Percentage %',
                      onchaned: (String) {},
                    ),

                    // Other Expense
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Other Expense',
                      controller: inputghati1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    //Yarn Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Yarn Coast',
                      subtext: '',
                    ),

                    //Yarn Rate
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Yarn Rate',
                      controller: inputghati1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    //Loss
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Loss',
                      controller: inputghati1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    //  Result Cotton Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Cotton Coast',
                      subtext: '',
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
                            builder: (context) => compare_spinning(
                              forOrReverse: true,
                            ),
                          ),
                        );
                      },
                      buttontext: 'Compare',
                      height: globalSingalComareButtonHeight,
                      width: globalSingalComareButtonWidth,
                    ),

                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              : ListView(
                  children: [
                    // Yarn Count

                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Yarn Count',
                      controller: inputghati1,
                      subtitle: '',
                      onchaned: (String) {},
                    ),

                    //Cotton Rate
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Cotton Rate',
                      controller: inputexpense1,
                      subtitle: '₹/Bale',
                      onchaned: (String) {},
                    ),

                    //  Result Cotton Rate
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Cotton Rate',
                      subtext: '',
                    ),

                    // Yield
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Yield',
                      controller: inputexpense1,
                      subtitle: 'Percentage %',
                      onchaned: (String) {},
                    ),

                    // Waste Recovery
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Waste Recovery',
                      controller: inputexpense1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    // Material Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Materail Coast',
                      subtext: '',
                    ),

                    // Coversation Coast
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Coversation Coast',
                      controller: inputexpense1,
                      subtitle: '₹/kg/Count',
                      onchaned: (String) {},
                    ),

                    // Commission
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Commission',
                      controller: inputexpense1,
                      subtitle: 'Percentage %',
                      onchaned: (String) {},
                    ),

                    // Other Expense
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Other Expense',
                      controller: inputghati1,
                      subtitle: '₹/kg',
                      onchaned: (String) {},
                    ),

                    //Yarn Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Yarn Coast',
                      subtext: '',
                    ),

                    //Yarn Rate
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Loss',
                      controller: inputkapas1,
                      subtitle: 'Yarn Rate',
                      onchaned: (string) {
                        // _updateValuesForCalculator1();
                      },
                    ),

                    //Loss
                    GlobalRowWidgetWithOnchanged(
                      height: globalSingalTextfiedHeight,
                      width: globalSingalTextfiedWidth,
                      title: 'Loss',
                      controller: inputkapas1,
                      subtitle: '₹/kg',
                      onchaned: (string) {
                        // _updateValuesForCalculator1();
                      },
                    ),

                    //  Result Cotton Coast
                    const spinning_answer_With_Stream_Builder(
                      stream: '',
                      title: 'Cotton Coast',
                      subtext: '',
                    ),

                    // Reset Button
                    GlobalButtonSimpleText(
                      onPressed: () {
                        inputkapas1.clear();
                        inputexpense1.clear();
                        inputkapasia1.clear();
                        inpututaro1.clear();
                        inputghati1.clear();

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
                            builder: (context) => compare_spinning(
                              forOrReverse: false,
                            ),
                          ),
                        );
                      },
                      buttontext: 'Compare',
                      height: globalSingalComareButtonHeight,
                      width: globalSingalComareButtonWidth,
                    ),

                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )),
    );
  }
}
