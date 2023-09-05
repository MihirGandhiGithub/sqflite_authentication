import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Constants/Global_Variables/colors/colors.dart';
import '../../../Constants/Global_Widgets/Appbar/appbar_with_text.dart';

class CottonQualityChart extends StatefulWidget {
  const CottonQualityChart({super.key});

  @override
  State<CottonQualityChart> createState() => _CottonQualityChartState();
}

class _CottonQualityChartState extends State<CottonQualityChart> {
  bool setcolor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWithText(
        appbarText: 'Cotton Quality',
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Heading with 4 Name
          Container(
            margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
            height: 150.h,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 250.sp,
                  child: Text(
                    'CAI\nGrading',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                        color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 400.sp,

                  // width: 350.w,
                  child: Text(
                    'Quality Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                        color: Colors.black),
                  ),
                ),
                Container(
                  width: 250.sp,
                  alignment: Alignment.center,

                  // width: 300.w,
                  child: Text(
                    'Length',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                        color: Colors.black),
                  ),
                ),
                Container(
                  width: 250.sp,
                  alignment: Alignment.center,
                  child: Text(
                    'Mic.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                        color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 250.sp,
                  child: Text(
                    'Strength\nGTex.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.sp, bottom: 30.sp),
                alignment: Alignment.center,
                child: Text(
                  'COTTON QUALITIES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      color: Colors.blue),
                ),
              ),
              const CCFExpanstionList(
                one: 'ICS-101',
                two: 'Bengal Desi',
                three: '>22mm',
                four: '5.0 - 7.0',
                five: '15',
              ),
              const CCFExpanstionList(
                one: 'ICS-201',
                two: 'Bengal Desi',
                three: '>22mm',
                four: '5.0 - 7.0',
                five: '15',
              ),
              const CCFExpanstionList(
                one: 'ICS-102',
                two: 'V797',
                three: '22mm',
                four: '4.0 - 6.0',
                five: '20',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'MECH',
                three: '27mm',
                four: '3.5 - 4.9',
                five: '26',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'J34 Hybrid',
                three: '28mm',
                four: '3.5 - 4.9',
                five: '27',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'Mech',
                three: '28mm',
                four: '	3.5 - 4.9',
                five: '27',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'Shanker 6',
                three: '28mm',
                four: '	3.5 - 4.9',
                five: '27',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'Bunny Brahma',
                three: '29mm',
                four: '3.5 - 4.9',
                five: '28',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'Shanker 6',
                three: '29mm',
                four: '3.5 - 4.9',
                five: '28',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'Bunny Brahma',
                three: '30mm',
                four: '3.5 - 4.9',
                five: '29',
              ),
              const CCFExpanstionList(
                one: 'ICS-105',
                two: 'MCU-5',
                three: '31mm',
                four: '3.5 - 4.9',
                five: '30',
              ),
              const CCFExpanstionList(
                one: 'ICS-106',
                two: 'MCU-5',
                three: '32mm',
                four: '3.5 - 4.9',
                five: '31',
              ),
              const CCFExpanstionList(
                one: 'ICS-107',
                two: 'DCH-32',
                three: '34mm',
                four: '3.0 - 3.8',
                five: '33',
              ),
              Container(
                margin: EdgeInsets.only(top: 50.sp, bottom: 10.sp),
                alignment: Alignment.center,
                child: Text(
                  'COTTON WASTE QUALITIES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      color: Colors.blue),
                ),
              ),
              const CCFExpanstionList(
                one: 'Comber Noil',
                two: '-',
                three: '20mm',
                four: '3.2-3.9',
                five: '23',
              ),
              const CCFExpanstionList(
                one: 'Yarn Waste',
                two: '-',
                three: 'NA',
                four: 'NA',
                five: 'NA',
              ),
              const CCFExpanstionList(
                one: 'Roving',
                two: '-',
                three: 'NA',
                four: 'NA',
                five: 'NA',
              ),
              const CCFExpanstionList(
                one: 'Flat Waste',
                two: '-',
                three: '27mm',
                four: '	3.5-4.0',
                five: '28',
              ),
              const CCFExpanstionList(
                one: 'Likerine Dropping',
                two: '-',
                three: '25mm',
                four: '3.5-4.2',
                five: '28',
              ),
              const CCFExpanstionList(
                one: 'Sweeping Waste',
                two: '-',
                three: 'NA',
                four: 'NA',
                five: 'NA',
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
  final String five;

  const CCFExpanstionList(
      {super.key,
      required this.one,
      required this.two,
      required this.three,
      required this.four,
      required this.five});

  @override
  State<CCFExpanstionList> createState() => _CCFExpanstionListtState();
}

class _CCFExpanstionListtState extends State<CCFExpanstionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      margin: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 30.h),
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
            width: 250.sp,
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
            width: 400.sp,
            child: Text(
              widget.two,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 250.w,
            child: Text(
              widget.three,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 250.sp,
            child: Text(
              widget.four,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
          Container(
            width: 250.sp,
            alignment: Alignment.center,
            child: Text(
              widget.five,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
