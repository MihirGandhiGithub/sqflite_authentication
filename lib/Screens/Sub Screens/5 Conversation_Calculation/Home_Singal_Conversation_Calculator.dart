import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/Global_Variables/Sizes/Sizes.dart';
import '../../../Constants/Global_Variables/colors/colors.dart';
import '../../../Constants/Global_Widgets/Result_Text/bigresult_text.dart';
import '../../../Constants/Global_Widgets/Row/three_content.dart';

class HomeSingalConversationCalulator extends StatefulWidget {
  const HomeSingalConversationCalulator({Key? key}) : super(key: key);

  @override
  State<HomeSingalConversationCalulator> createState() =>
      _HomeSingalConversationCalulator();
}

class _HomeSingalConversationCalulator
    extends State<HomeSingalConversationCalulator>
    with SingleTickerProviderStateMixin {
  bool calulateLB = false;

  //cents to indian
  bool centstoindian = true;
  bool reversecentstoindian = false;

  //chinese to indian
  bool chinesetoindina = false;
  bool reversechinesetoindina = false;

  //pakistan to indian
  bool pakistantoindian = false;
  bool reversepakistantoindian = false;

  //punjab to candy rate
  bool punjabtocandy = false;
  bool reversepanjabtocandy = false;

  //170 kgs to candy rate
  bool kgstocandy = false;
  bool reversekgstocandy = false;

  final inputkapas1 = TextEditingController();
  final inputexpense1 = TextEditingController();
  final inputoilrate1 = TextEditingController();
  final inputkapasia1 = TextEditingController();
  final inpututaro1 = TextEditingController();
  final inputghati1 = TextEditingController();
  void _updateValuesForCalculator1() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Conversation',
              style: TextStyle(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(150.sp),
            ),
          ),
          backgroundColor: universalGray,
          elevation: 2,
        ),
        body: ListView(
          children: [
            // Cents/LB to Indain Rate
            Container(
              margin: EdgeInsets.only(top: 40.h, left: 40.w, right: 40.w),
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  boxShadow: [
                    centstoindian
                        ? const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              2,
                              2,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        : const BoxShadow()
                  ],
                  color: centstoindian ? Colors.grey[200] : Colors.grey[300]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cents/LB To Indian Rate',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: centstoindian,
                        // overlayColor: overlayColor,
                        // trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            centstoindian = value;
                          });
                        },
                      ),
                    ],
                  ),
                  centstoindian
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cents/LB -> Indian Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: reversecentstoindian,
                                  // overlayColor: overlayColor,
                                  // trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      reversecentstoindian = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Indian Rate -> Cents/LB',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                              ],
                            ),
                            reversecentstoindian
                                ? Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Candy',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (USD/INR)',
                                        controller: inputkapas1,
                                        subtitle: 'Cents/LB',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'US Cents/LB',
                                        result: 0,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'US Cents/LB',
                                        controller: inputkapas1,
                                        subtitle: 'Cents/LB',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (USD/INR)',
                                        controller: inputkapas1,
                                        subtitle: 'Cents/LB',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: 'Rs.'
                                            '',
                                        streamtitletext: 'INR/Candy',
                                        result: 0,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : Container()
                ],
              ),
            ),

            //Chiense Rate to indian rate
            Container(
              margin: EdgeInsets.only(top: 40.h, left: 40.w, right: 40.w),
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  boxShadow: [
                    chinesetoindina
                        ? const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              2,
                              2,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        : const BoxShadow()
                  ],
                  color: chinesetoindina ? Colors.grey[200] : Colors.grey[300]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chinese To Indian Rate',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: chinesetoindina,
                        // overlayColor: overlayColor,
                        // trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            chinesetoindina = value;
                          });
                        },
                      ),
                    ],
                  ),
                  chinesetoindina
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chinese Rate -> Indian Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: reversechinesetoindina,
                                  // overlayColor: overlayColor,
                                  // trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      reversechinesetoindina = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Indian Rate -> Chinese Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                              ],
                            ),
                            reversechinesetoindina
                                ? Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Candy',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (CNY/INR)',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.'
                                            '',
                                        streamtitletext: 'CNY/Ton',
                                        result: 0,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'CNY/Ton',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (CNY/INR)',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Candy',
                                        result: 0,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : Container()
                ],
              ),
            ),

            // Pakistan rate to indian rate
            Container(
              margin: EdgeInsets.only(top: 40.h, left: 40.w, right: 40.w),
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  boxShadow: [
                    pakistantoindian
                        ? const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              2,
                              2,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        : const BoxShadow()
                  ],
                  color:
                      pakistantoindian ? Colors.grey[200] : Colors.grey[300]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pakistan Rate To Indian Rate',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: pakistantoindian,
                        // overlayColor: overlayColor,
                        // trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            pakistantoindian = value;
                          });
                        },
                      ),
                    ],
                  ),
                  pakistantoindian
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pakistan Rate -> Indian Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: reversepakistantoindian,
                                  // overlayColor: overlayColor,
                                  // trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      reversepakistantoindian = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Indian Rate -> Pakistan Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                              ],
                            ),
                            reversepakistantoindian
                                ? Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Candy',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (PKR/INR)',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'PKR/INR',
                                        result: 0,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'PKR/Maund',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'Exchange Rate (PKR/INR)',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Candy',
                                        result: 0,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : Container()
                ],
              ),
            ),

            //punjab rate to candy rate
            Container(
              margin: EdgeInsets.only(top: 40.h, left: 40.w, right: 40.w),
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  boxShadow: [
                    punjabtocandy
                        ? const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              2,
                              2,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        : const BoxShadow()
                  ],
                  color: punjabtocandy ? Colors.grey[200] : Colors.grey[300]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Punjab Rate To Candy Rate',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: punjabtocandy,
                        // overlayColor: overlayColor,
                        // trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            punjabtocandy = value;
                          });
                        },
                      ),
                    ],
                  ),
                  punjabtocandy
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Punjab Rate -> Candy Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: reversepanjabtocandy,
                                  // overlayColor: overlayColor,
                                  // trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      reversepanjabtocandy = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Candy Rate -> Punjab Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                              ],
                            ),
                            reversepanjabtocandy
                                ? Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Candy',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/170Kgs',
                                        result: 0,
                                      ),
                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Maund',
                                        result: 0,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Maund',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/170Kgs',
                                        result: 0,
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Candy',
                                        result: 0,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : Container()
                ],
              ),
            ),

            // 170 Kgs Rate To Candy Rate
            Container(
              margin: EdgeInsets.only(top: 40.h, left: 40.w, right: 40.w),
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  boxShadow: [
                    kgstocandy
                        ? const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              2,
                              2,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        : const BoxShadow()
                  ],
                  color: kgstocandy ? Colors.grey[200] : Colors.grey[300]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '170 Kgs Rate To Candy Rate',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: kgstocandy,
                        // overlayColor: overlayColor,
                        // trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            kgstocandy = value;
                          });
                        },
                      ),
                    ],
                  ),
                  kgstocandy
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '170Kgs Rate -> Candy Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: reversekgstocandy,
                                  // overlayColor: overlayColor,
                                  // trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      reversekgstocandy = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Candy Rate -> 170Kgs Rate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 40.sp),
                                ),
                              ],
                            ),
                            reversekgstocandy
                                ? Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/Candy',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Maund',
                                        result: 0,
                                      ),
                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/170Kgs',
                                        result: 0,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      GlobalRowWidgetWithOnchanged(
                                        height: globalSingalTextfiedHeight,
                                        width: globalSingalTextfiedWidth,
                                        title: 'INR/170Kgs',
                                        controller: inputkapas1,
                                        subtitle: '',
                                        onchaned: (string) {
                                          _updateValuesForCalculator1();
                                        },
                                      ),
                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Maund',
                                        result: 0,
                                      ),

                                      //result
                                      const GlobalResultBuilderForResults(
                                        substreamtext: '.',
                                        streamtitletext: 'INR/Candy',
                                        result: 0,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          ],
          // children: [
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Cents/LB',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //       Switch(
          //         // This bool value toggles the switch.
          //         value: calulateLB,
          //         // overlayColor: overlayColor,
          //         // trackColor: trackColor,
          //         thumbColor:
          //             const MaterialStatePropertyAll<Color>(Colors.black),
          //         onChanged: (bool value) {
          //           // This is called when the user toggles the switch.
          //           setState(() {
          //             calulateLB = value;
          //           });
          //         },
          //       ),
          //       Text(
          //         'USD/Kg',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //     ],
          //   ),
          //   centstoindian
          //       ? GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'USD/Kg',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         )
          //       : GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'Cents/LB',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Cents/LB',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //       Switch(
          //         // This bool value toggles the switch.
          //         value: calulateLB,
          //         // overlayColor: overlayColor,
          //         // trackColor: trackColor,
          //         thumbColor:
          //             const MaterialStatePropertyAll<Color>(Colors.black),
          //         onChanged: (bool value) {
          //           // This is called when the user toggles the switch.
          //           setState(() {
          //             calulateLB = value;
          //           });
          //         },
          //       ),
          //       Text(
          //         'USD/Kg',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //     ],
          //   ),
          //   calulateLB
          //       ? GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'USD/Kg',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         )
          //       : GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'Cents/LB',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Cents/LB',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //       Switch(
          //         // This bool value toggles the switch.
          //         value: calulateLB,
          //         // overlayColor: overlayColor,
          //         // trackColor: trackColor,
          //         thumbColor:
          //             const MaterialStatePropertyAll<Color>(Colors.black),
          //         onChanged: (bool value) {
          //           // This is called when the user toggles the switch.
          //           setState(() {
          //             calulateLB = value;
          //           });
          //         },
          //       ),
          //       Text(
          //         'USD/Kg',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //     ],
          //   ),
          //   calulateLB
          //       ? GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'USD/Kg',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         )
          //       : GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'Cents/LB',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Cents/LB',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //       Switch(
          //         // This bool value toggles the switch.
          //         value: calulateLB,
          //         // overlayColor: overlayColor,
          //         // trackColor: trackColor,
          //         thumbColor:
          //             const MaterialStatePropertyAll<Color>(Colors.black),
          //         onChanged: (bool value) {
          //           // This is called when the user toggles the switch.
          //           setState(() {
          //             calulateLB = value;
          //           });
          //         },
          //       ),
          //       Text(
          //         'USD/Kg',
          //         style: TextStyle(color: Colors.black, fontSize: 70.sp),
          //       ),
          //     ],
          //   ),
          //   calulateLB
          //       ? GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'USD/Kg',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         )
          //       : GlobalRowWidgetWithOnchanged(
          //           height: Global_Singal_Textfied_Height,
          //           width: Global_Singal_Textfied_Width,
          //           title: 'Export Rate',
          //           controller: inputkapas1,
          //           subtitle: 'Cents/LB',
          //           onchaned: (string) {
          //             _updateValues_for_calculator1();
          //           },
          //         ),
          //
          //   // Expenses
          //   GlobalRowWidgetWithOnchanged(
          //     height: Global_Singal_Textfied_Height,
          //     width: Global_Singal_Textfied_Width,
          //     title: 'Expenses',
          //     controller: inputkapas1,
          //     subtitle: '₹/Bale',
          //     onchaned: (string) {
          //       _updateValues_for_calculator1();
          //     },
          //   ),
          //
          //   // Cotton Seed
          //   GlobalRowWidgetWithOnchanged(
          //     height: Global_Singal_Textfied_Height,
          //     width: Global_Singal_Textfied_Width,
          //     title: 'Exchange Rate',
          //     controller: inputkapas1,
          //     subtitle: 'USD/INR',
          //     onchaned: (string) {
          //       _updateValues_for_calculator1();
          //     },
          //   ),
          //
          //   // Stram result Export Rate 1
          //   Global_Result_Builder_For_Results(
          //     substreamtext: 'Rs./Candy',
          //     streamtitletext: 'Realisation',
          //     result: 0,
          //   ),
          //
          //   // Reset Button
          //   Global_Button_Simple_Text(
          //     onPressed: () {
          //       inputkapas1.clear();
          //       inputexpense1.clear();
          //       inputkapasia1.clear();
          //       inpututaro1.clear();
          //       inputghati1.clear();
          //       // answer = 0;
          //     },
          //     buttontext: 'Reset',
          //     height: Global_Singal_Reset_Button_Height,
          //     width: Global_Singal_Reset_Button_Width,
          //   ),
          //
          //   //Compare Button
          //   Global_Button_Gradient_Text(
          //     onPressed: () {
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //     builder: (context) =>
          //       //         Home_Compare_Oil_Mill_Calculator(
          //       //           for_or_reverse: true,
          //       //         ),
          //       //   ),
          //       // );
          //     },
          //     buttontext: 'Compare',
          //     height: Global_Singal_Comare_Button_Height,
          //     width: Global_Singal_Comare_Button_Width,
          //   ),
          // ],
        ));
  }
}
