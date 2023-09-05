import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constants/Global_Variables/Sizes/global_sizes.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_slider.dart';
import '../../../Constants/Global_Widgets/Buttons/floating_share.dart';
import '../../../Constants/Global_Widgets/Buttons/gradient_text.dart';
import '../../../Constants/Global_Widgets/Buttons/simple_text.dart';
import '../../../Constants/Global_Widgets/navigate_page_with_animation.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';
import 'compare_ice_parity_chart.dart';

class HomeICEParityChart extends StatefulWidget {
  const HomeICEParityChart({Key? key}) : super(key: key);

  @override
  State<HomeICEParityChart> createState() => _HomeICEParityChartState();
}

class _HomeICEParityChartState extends State<HomeICEParityChart>
    with SingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Screenshot(
        controller: screenshotController,
        child: Scaffold(
            appBar: const AppBarWithSlider(
              titleText: 'ICE Parity',
              sliderText1: 'Physical Cotton',
              sliderText2: 'MCX',
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
  State<PhysicalCotton> createState() => PhysicalCottonState();
}

class PhysicalCottonState extends State<PhysicalCotton> {
  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'Cotton Rate',
          controller: inputkapas1,
          subtitle: '₹/Candy',
          onchaned: (string) {},
        ),

        // Expenses
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'ICE Future Rate',
          controller: inputkapas1,
          subtitle: 'Cents/LB',
          onchaned: (string) {},
        ),

        // Cotton Seed
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'Exchange Rate',
          controller: inputkapas1,
          subtitle: 'Cents/LB',
          onchaned: (string) {},
        ),

        // Stram result Export Rate 1
        const GlobalResultBuilderForResults(
          substreamtext: 'Cents/LB',
          streamtitletext: 'Parity',
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
          onPressed: () => CustomNavigator().navigateToPage(
            context,
            const CompareIceParityChart(
              isMCX: 0,
            ),
          ),
          buttontext: 'Compare',
          height: globalSingalComareButtonHeight,
          width: globalSingalComareButtonWidth,
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
      children: [
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'MCX Future Rate',
          controller: inputkapas1,
          subtitle: '₹/Bale',
          onchaned: (string) {},
        ),

        // Expenses
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'ICE Future Rate',
          controller: inputkapas1,
          subtitle: 'Cents/LB',
          onchaned: (string) {},
        ),

        // Cotton Seed
        GlobalRowWidgetWithOnchanged(
          height: globalSingalTextfiedHeight,
          width: globalSingalTextfiedWidth,
          title: 'Exchange Rate',
          controller: inputkapas1,
          subtitle: 'USD/INR',
          onchaned: (string) {},
        ),

        // Stram result Export Rate 1
        const GlobalResultBuilderForResults(
          substreamtext: 'Cents/LB',
          streamtitletext: 'Parity',
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
          onPressed: () => CustomNavigator().navigateToPage(
            context,
            const CompareIceParityChart(
              isMCX: 1,
            ),
          ),
          buttontext: 'Compare',
          height: globalSingalComareButtonHeight,
          width: globalSingalComareButtonWidth,
        ),
      ],
    );
  }
}
