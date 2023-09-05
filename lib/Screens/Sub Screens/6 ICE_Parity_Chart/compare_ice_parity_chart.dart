import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import '../../../Constants/Global_Variables/Sizes/global_sizes.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Globaly Accesible/row_with_2_item.dart';

class CompareIceParityChart extends StatefulWidget {
  final int isMCX;
  const CompareIceParityChart({Key? key, required this.isMCX})
      : super(key: key);

  @override
  State<CompareIceParityChart> createState() => _CompareIceParityChartState();
}

class _CompareIceParityChartState extends State<CompareIceParityChart>
    with SingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return DefaultTabController(
      initialIndex: widget.isMCX,
      length: 2,
      child: Screenshot(
        controller: screenshotController,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(380.h),
              child: AppBar(
                title: Text(
                  'ICE Parity',
                  style: TextStyle(
                    fontSize: WidgetsSize.appbarWithSliderTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.grey[400],
                elevation: WidgetsSize.appbarWithSliderelevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                        WidgetsSize.appbarWithSliderBottomRadius),
                  ),
                ),
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(100.sp, 0, 100.sp, 30.sp),
                      padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
                      height: 140.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(
                            text: 'Physical Cotton',
                          ),
                          Tab(
                            text: 'MCX',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                PhysicalCotton(),
                MCX(),
              ],
            ),
            floatingActionButton: FloatingButton(
              screenshotController: screenshotController,
              isVisible: keyboardIsOpened,
            )),
      ),
    );
  }
}

class PhysicalCotton extends StatefulWidget {
  const PhysicalCotton({super.key});

  @override
  State<PhysicalCotton> createState() => _PhysicalCottonState();
}

class _PhysicalCottonState extends State<PhysicalCotton> {
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            subtitle: '₹/Candy',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {},
            onchane2: (string) {}),

        // Expense
        GlobalRowCompareWidget2textfielsWithOnchanges(
            title: 'ICE Future Rate',
            controller1: inputexpense1,
            subtitle: 'Cents/LB',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {},
            onchane2: (string) {}),

        // Cotton Seed
        GlobalRowCompareWidget2textfielsWithOnchanges(
            title: 'Exchange Rate',
            controller1: inputkapasia1,
            subtitle: 'Cents/LB',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {},
            onchane2: (string) {}),

        // Final Answer
        const GlobalRowCompareWidget2StreamBuilderWithAnswer(
          result1: 0,
          result2: 0,
          subtext1: 'Cents/LB',
          subtext2: 'Cents/LB',
          title1: 'Parity',
          title2: '',
        ),

        GlobalRowCompareWidget2Button(
          onpressed1: () {
            // reverseinputkapas1.clear();
            // reverseinputexpense1.clear();
            // reverseinputkapasia1.clear();
            // reverseinpututaro1.clear();
            // reverseinputghati1.clear();
            // reverseanswer1 = 0;
            // result_output_difference.add(0);
            // focusnodekapas1.requestFocus();
          },
          onpressed2: () {
            // reverseinputkapas2.clear();
            // reverseinputexpense2.clear();
            // reverseinputkapasia2.clear();
            // reverseinpututaro2.clear();
            // reverseinputghati2.clear();
            // reverseanswer2 = 0;
            // result_output_difference.add(0);
            // focusnodekapas2.requestFocus();
          },
          text1: 'RESET 1',
          text2: 'RESET 2',
        ),

        // Khandi Diffrnce or Stram result
        SizedBox(height: 20.h),
        const GlobalResultBuilderForResults(
          substreamtext: 'Cents/LB',
          streamtitletext: 'Parity Difference',
          result: 0,
        ),

        SizedBox(
          height: 20.h,
        ),

        // Reset All Button
        GlobalButtonSimpleText(
          onPressed: () {
            // reverseinputkapas1.clear();
            // reverseinputexpense1.clear();
            // reverseinputkapasia1.clear();
            // reverseinpututaro1.clear();
            // reverseinputghati1.clear();
            // reverseinputkapas2.clear();
            // reverseinputexpense2.clear();
            // reverseinputkapasia2.clear();
            // reverseinpututaro2.clear();
            // reverseinputghati2.clear();
            // reversediff = 0;
            // reverseanswer1 = 0;
            // reverseanswer2 = 0;
          },
          buttontext: 'Reset All',
          height: globalSingalResetButtonHeight,
          width: globalSingalResetButtonWidth,
        ),
      ],
    );
  }
}

class MCX extends StatefulWidget {
  const MCX({super.key});

  @override
  State<MCX> createState() => _MCXState();
}

class _MCXState extends State<MCX> {
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            subtitle: '₹/Bale',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {},
            onchane2: (string) {}),

        // Expense
        GlobalRowCompareWidget2textfielsWithOnchanges(
            title: 'ICE Future Rate',
            controller1: inputexpense1,
            subtitle: 'Cents/LB',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {},
            onchane2: (string) {}),

        // Cotton Seed
        GlobalRowCompareWidget2textfielsWithOnchanges(
            title: 'Exchange Rate',
            controller1: inputkapasia1,
            subtitle: 'USD/INR',
            height: 0,
            width: 0,
            controller2: inputkapas1,
            onchaned1: (string) {
              // _updateValuesForCalculator1();
            },
            onchane2: (string) {
              // _updateValuesForCalculator2();
            }),

        // Final Answer
        const GlobalRowCompareWidget2StreamBuilderWithAnswer(
          result1: 0,
          result2: 0,
          subtext1: 'Cents/LB',
          subtext2: 'Cents/LB',
          title1: 'Parity',
          title2: '',
        ),

        GlobalRowCompareWidget2Button(
          onpressed1: () {
            inputkapas1.clear();
            inputexpense1.clear();
            inputkapasia1.clear();
            inpututaro1.clear();
            inputghati1.clear();
            // answer1 = 0;
            // result_output_difference.add(0);
            // focusnodekapas1.requestFocus();
          },
          onpressed2: () {
            // inputkapas2.clear();
            // inputexpense2.clear();
            // inputkapasia2.clear();
            // inpututaro2.clear();
            // inputghati2.clear();
            // answer2 = 0;
            // result_output_difference.add(0);
            // focusnodekapas2.requestFocus();
          },
          text1: 'RESET 1',
          text2: 'RESET 2',
        ),
        //
        // // Khandi Diffrnce or Stram result
        SizedBox(height: 20.h),
        const GlobalResultBuilderForResults(
          substreamtext: 'Cents/LB',
          streamtitletext: 'Parity Difference',
          result: 0,
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
          },
          buttontext: 'Reset All',
          height: globalSingalResetButtonHeight,
          width: globalSingalResetButtonWidth,
        ),
      ],
    );
  }
}
