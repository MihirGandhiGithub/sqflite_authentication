import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/Global_Variables/colors/colors.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_with_text.dart';

class ConversationFactor extends StatefulWidget {
  const ConversationFactor({super.key});

  @override
  State<ConversationFactor> createState() => _ConversationFactorState();
}

class _ConversationFactorState extends State<ConversationFactor> {
  bool setcolor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWithText(
        appbarText: 'Conversation Factor',
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Heading with 4 Name
          Container(
            margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
            height: 150.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 380.w,
                  child: Text(
                    'Particulars',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.sp,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 350.w,
                  child: Text(
                    'Kilograms',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.sp,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 300.w,
                  child: Text(
                    'Pound',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.sp,
                        color: Colors.black),
                  ),
                ),
                Text(
                  '480 lb Bales',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      color: Colors.black),
                ),
              ],
            ),
          ),

          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              CCFExpanstionList(
                one: 'Ton (Metric)',
                two: '1.000',
                three: '2204.6',
                four: '4.593',
              ),
              CCFExpanstionList(
                one: 'Pound',
                two: '0.4536',
                three: '1',
                four: '480',
              ),
              CCFExpanstionList(
                one: 'Kilogram',
                two: '1',
                three: '2.2046',
                four: '0.004593',
              ),
              CCFExpanstionList(
                one: 'Arroba (Brazil)',
                two: '15',
                three: '33.069',
                four: '0.0689',
              ),
              CCFExpanstionList(
                one: 'Candy (India)',
                two: '355.62',
                three: '784',
                four: '1.6333',
              ),
              CCFExpanstionList(
                one: 'Cantar, Metric (Egypt)',
                two: '50',
                three: '110.23',
                four: '0.2296',
              ),
              CCFExpanstionList(
                one: 'Cantar (Sudan)',
                two: '44.93',
                three: '99.05',
                four: '0.20635',
              ),
              CCFExpanstionList(
                one: 'Centner (Soviet Union)',
                two: '100',
                three: '220.46',
                four: '0.4593',
              ),
              CCFExpanstionList(
                one: 'Dan (China)',
                two: '50',
                three: '110.23',
                four: '0.2296',
              ),
              CCFExpanstionList(
                one: 'Quintal (Argentina)',
                two: '45.95',
                three: '101.3',
                four: '0.211',
              ),
              CCFExpanstionList(
                one: 'Quintal (India)',
                two: '100',
                three: '220.46',
                four: '0.4593',
              ),
              CCFExpanstionList(
                one: 'Quintal (Mexico)',
                two: '46.026',
                three: '101.47',
                four: '0.2114',
              ),
              CCFExpanstionList(
                one: 'Quintal (Peru, Spain)',
                two: '46',
                three: '101.41',
                four: '0.2113',
              ),
              CCFExpanstionList(
                one: 'Long Ton',
                two: '1.016',
                three: '2.240',
                four: '4.666',
              ),
              CCFExpanstionList(
                one: 'Maund (Pakistan)',
                two: '37.3242',
                three: '82.286',
                four: '0.1714',
              ),
              CCFExpanstionList(
                one: 'picul (China)',
                two: '50',
                three: '110.23',
                four: '0.2296',
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class CCFExpanstionList extends StatefulWidget {
  final String one;
  final String two;
  final String three;
  final String four;

  const CCFExpanstionList(
      {super.key,
      required this.one,
      required this.two,
      required this.three,
      required this.four});

  @override
  State<CCFExpanstionList> createState() => _CCFExpanstionListtState();
}

class _CCFExpanstionListtState extends State<CCFExpanstionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: universalGray,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 350.w,
            child: Text(
              widget.one,
              style: TextStyle(
                  fontSize: 50.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 350.w,
            child: Text(
              widget.two,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 280.w,
            child: Text(
              widget.three,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              widget.four,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
