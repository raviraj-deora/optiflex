import 'package:flutter/material.dart';
import 'package:optiflexcalculator/utils/app_colors.dart';

import 'data_model.dart';

class CalculationScreen extends StatefulWidget {
  final Data data;

  CalculationScreen({this.data});
  @override
  CalculationScreenState createState() {
    return CalculationScreenState(
      data: data,
    );
  }
}

class CalculationScreenState extends State<CalculationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String radioValue1;
  final Data data;
  String radioItem = '';
  CalculationScreenState({this.data});
  bool isPhacikLens = false;
  int expectedCylinderIndex = 0;

  List<PowerOfLens> powerOfLensList = [];
  List<ExpectedSpherical> expectedSphericalList = [];
  double cylinderValue = 0.5;
  List<double> expectedCylinder = [8.83,8.43,8.02,7.62,7.21,6.81,6.40,6.00,5.59,5.19];
  List<PhakicToricLense> phakicToricLenseList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetList();
  }
  resetList(){
    phakicToricLenseList.clear();
    phakicToricLenseList.add(new PhakicToricLense(false,0.5));
    phakicToricLenseList.add(new PhakicToricLense(false,1.0));
    phakicToricLenseList.add(new PhakicToricLense(false,1.5));
    phakicToricLenseList.add(new PhakicToricLense(false,2.0));
    phakicToricLenseList.add(new PhakicToricLense(false,2.5));
    phakicToricLenseList.add(new PhakicToricLense(false,3.0));
    phakicToricLenseList.add(new PhakicToricLense(false,3.5));
    phakicToricLenseList.add(new PhakicToricLense(false,4.0));
    phakicToricLenseList.add(new PhakicToricLense(false,4.5));
    phakicToricLenseList.add(new PhakicToricLense(false,5.0));

    expectedSphericalList.clear();
    expectedSphericalList.add(new ExpectedSpherical(4.03,4.42,4.83,5.24,5.64 ));
    expectedSphericalList.add(new ExpectedSpherical(3.82,4.22,4.63,5.04,5.45 ));
    expectedSphericalList.add(new ExpectedSpherical(3.62,4.02,4.43 ,4.83 ,5.24 ));
    expectedSphericalList.add(new ExpectedSpherical(3.42,3.82 ,4.23 ,4.63 ,5.04 ));
    expectedSphericalList.add(new ExpectedSpherical(3.21,3.61,4.03,4.42,4.83 ));
    expectedSphericalList.add(new ExpectedSpherical(3.01,3.41,3.82,4.22,4.63));
    expectedSphericalList.add(new ExpectedSpherical(2.81,3.21,3.62,4.02,4.43));
    expectedSphericalList.add(new ExpectedSpherical(2.61,3.01,3.42,3.82,4.23));
    expectedSphericalList.add(new ExpectedSpherical(2.40,2.80,3.21,3.61,4.03));
    expectedSphericalList.add(new ExpectedSpherical(2.21,2.60,3.0,3.42,3.83));

    powerOfLensList.clear();
    powerOfLensList.add(new PowerOfLens(false,-3, cylinderValue,-0.39 ,expectedCylinder[expectedCylinderIndex] ,expectedSphericalList[expectedCylinderIndex].value1 ,40 ));
    powerOfLensList.add(new PowerOfLens(false,-3.5,cylinderValue,0.01 ,expectedCylinder[expectedCylinderIndex] ,expectedSphericalList[expectedCylinderIndex].value2 ,40 ));
    powerOfLensList.add(new PowerOfLens(false,-4,cylinderValue,0.42 ,expectedCylinder[expectedCylinderIndex] , expectedSphericalList[expectedCylinderIndex].value3,40 ));
    powerOfLensList.add(new PowerOfLens(false,-4.5,cylinderValue ,0.82 , expectedCylinder[expectedCylinderIndex],expectedSphericalList[expectedCylinderIndex].value4 ,40 ));
    powerOfLensList.add(new PowerOfLens(false,-5, cylinderValue,1.23 , expectedCylinder[expectedCylinderIndex],expectedSphericalList[expectedCylinderIndex].value5 ,40 ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Optiflex Calculators')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[350],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Patient Details".toUpperCase(),
                                      style:
                                      TextStyle(color: Colors.blue[900])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Patient's Name:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.namepass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Patient's Birthdate:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.birthdatepass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Patient´s Case No. / ID No.:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.idpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Doctor's Name:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.doctornamepass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Date:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.datepass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Eye:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.eyepass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 100%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.grey[350],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Pre-operative Data".toUpperCase(),
                                      style:
                                      TextStyle(color: Colors.blue[900])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Flat K:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.flatk}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Steep K:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.steepk}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Pre-Operative Sphere:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.preofsphpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Pre-Operative Cylinder:",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.preofcylpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Corneal Thickness(in mm):",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.corthkpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Back Vertex Distance(in mm):",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.backvertaxpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("White to White Distance(in mm):",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.wtwpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Anterior Chamber Depth(in mm):",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.acdpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 100%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.grey[350],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Calculation Details".toUpperCase(),
                                      style:
                                      TextStyle(color: Colors.blue[900])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("IOL Model Size(in mm):",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5, // 50%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${data.iolmodelpass}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 100%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.grey[350],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Select Power Of Lens".toUpperCase(),
                                      style:
                                      TextStyle(color: Colors.blue[900])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      powerLensWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(isPhacikLens?Icons.check_box:Icons.check_box_outline_blank,color: AppColors.themeColor,),
                            onPressed: () {
                              setState(() {
                                isPhacikLens = !isPhacikLens;
                              });
                              if(isPhacikLens){
                                cylinderValue=0;
                                resetList();
                              }
                            },
                          ),
                          Text("Phakic Lens")
                        ],
                      ),

                      Container(
                        color: Color(0xffCEEDC4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Select cylinder of phakic lens".toUpperCase()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      grid(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 80%
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false
                                        // otherwise.

                                        // If the form is valid, display a Snackbar.
                                        _scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                                content:
                                                Text('Processing Data')));
                                        finalResults();
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
  Widget _oldRadioSelection(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 315,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Center(
                            child: Text(
                              'Select Power Of Lens'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('SPHERE')),
                            DataColumn(label: Text('CYLINDER')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.firstvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
//                                            DataCell(Text(
//                                                '${data.firstvalueofspherepass}')),
                              DataCell(Text(
                                  '100')),
                              DataCell(Text(
                                  '100')),
//                                            DataCell(Text(
//                                                '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.secondvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.secondvalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.middlevalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.middlevalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.fourthvalueofspgerepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.fourthvalueofspgerepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.fifthvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.fifthvalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Center(
                            child: Text(
                              'Expected Post-Op Residual'
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(label: Text('SPHERE')),
                            DataColumn(label: Text('CYLINDER')),
                            DataColumn(
                                label:
                                Text('SPHERICAL EQUIVALENT')),
                            DataColumn(label: Text('AXIS')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.firstvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.firstvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.secondvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.secondvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.middlevalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.middlevalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.fourthvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.fourthvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.fifthvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.fifthvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ),

        Container(
          color: Colors.grey[350],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Select Cylinder of Glaze Axis Lens"
                            .toUpperCase(),
                        style:
                        TextStyle(color: Colors.blue[900])),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('0.5'),
                leading: Radio(
                  value: '0.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('3.0'),
                leading: Radio(
                  value: '3.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('1.0'),
                leading: Radio(
                  value: '1.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('3.5'),
                leading: Radio(
                  value: '3.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('1.5'),
                leading: Radio(
                  value: '1.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('4.0'),
                leading: Radio(
                  value: '4.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('2.0'),
                leading: Radio(
                  value: '2.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('4.5'),
                leading: Radio(
                  value: '4.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('2.5'),
                leading: Radio(
                  value: '2.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('5.0'),
                leading: Radio(
                  value: '5.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 315,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Center(
                            child: Text(
                              'Select Power Of Lens'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('SPHERE')),
                            DataColumn(label: Text('CYLINDER')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.firstvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
//                                            DataCell(Text(
//                                                '${data.firstvalueofspherepass}')),
                              DataCell(Text(
                                  '100')),
                              DataCell(Text(
                                  '100')),
//                                            DataCell(Text(
//                                                '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.secondvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.secondvalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.middlevalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.middlevalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.fourthvalueofspgerepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.fourthvalueofspgerepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                width: 10,
                                child: Radio(
//                                                value:
//                                                '${data.fifthvalueofspherepass}',
                                  value: radioItem,
                                  groupValue: radioItem,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val;
                                    });
                                  },
                                ),
                              )),
                              DataCell(Text(
                                  '${data.fifthvalueofspherepass}')),
                              DataCell(Text(
                                  '${data.selectedvalueofcylinderpass}')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Center(
                            child: Text(
                              'Expected Post-Op Residual'
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(label: Text('SPHERE')),
                            DataColumn(label: Text('CYLINDER')),
                            DataColumn(
                                label:
                                Text('SPHERICAL EQUIVALENT')),
                            DataColumn(label: Text('AXIS')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.firstvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.firstvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.secondvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.secondvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.middlevalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.middlevalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.fourthvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.fourthvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  '${data.fifthvalueofresidualspherepass}')),
                              DataCell(Text(
                                  '${data.valueofresidualcylinderpass}')),
                              DataCell(Text(
                                  '${data.fifthvalueofsphericalequivalentpass}')),
                              DataCell(Text(
                                  '${data.axisofplacementpass}')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ),

        Container(
          color: Colors.grey[350],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Select Cylinder of Glaze Axis Lens"
                            .toUpperCase(),
                        style:
                        TextStyle(color: Colors.blue[900])),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('0.5'),
                leading: Radio(
                  value: '0.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('3.0'),
                leading: Radio(
                  value: '3.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('1.0'),
                leading: Radio(
                  value: '1.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('3.5'),
                leading: Radio(
                  value: '3.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('1.5'),
                leading: Radio(
                  value: '1.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('4.0'),
                leading: Radio(
                  value: '4.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('2.0'),
                leading: Radio(
                  value: '2.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('4.5'),
                leading: Radio(
                  value: '4.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('2.5'),
                leading: Radio(
                  value: '2.5',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: const Text('5.0'),
                leading: Radio(
                  value: '5.0',
                  groupValue: radioValue1,
                  onChanged: (val) {
                    setState(() {
                      radioValue1 = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
  Widget powerLensWidget(){
    return Container(
      height: 331,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
              color: Color(0xffCEEDC4),
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text("SELECTED POWER OF LENS"),
                    Container(width: 2,height: 40,color: Colors.white,),
                    Container(),
                    Text("EXPECTED POST_OP RESIDUAL"),
                    Container(),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[350],
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(),
                    Text("SPHERE"),
                    Container(),
                    Container(),
                    Text("CYLINDER"),
                    Container(),
                    Text("SPHERE"),
                    Text("CYLINDER"),
                    Text("SPHERICAL"),
                    Text("AXIS"),
                    Container(),
                    //Container(width: 2,height: 40,color: Colors.white,),

                  ],
                ),
              ),
            ),
            Container(
              width: 600,
              child: _list(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(){
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      //scrollDirection: Axis.vertical,
      itemCount: powerOfLensList.length,
      itemBuilder: (context,index){
        PowerOfLens powerOfLens = powerOfLensList[index];
        return Container(
          child: Column(
            children: [
              Container(
                color: Colors.grey[200],
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(powerOfLens.isSelected?Icons.brightness_1:Icons.panorama_fish_eye,color: AppColors.themeColor,),
                      onPressed: () {
                        for(int i=0;i<powerOfLensList.length;i++){
                          powerOfLensList[i].isSelected = false;
                        }
                        setState(() {
                          powerOfLens.isSelected = true;
                        });
                      },
                    ),
                    SizedBox(width: 10,),
                    Text(powerOfLens.sphere1.toString()),
                    SizedBox(width: 110,),
                    Text(powerOfLens.cylinder1.toString()),
                    SizedBox(width: 80,),
                    Text(powerOfLens.sphere2.toString()),
                    SizedBox(width: 45,),
                    Text(powerOfLens.cylinder2.toString()),
                    SizedBox(width: 65,),
                    Text(powerOfLens.spherical.toString()),
                    SizedBox(width: 50,),
                    Text(powerOfLens.axis.toString()),
                  ],
                ),
              ),
              Divider(color: Colors.white,height: 3,)
            ],
          ),
        );
      },
    );
  }
  Future finalResults() async {
    print("Test called");
  }
  Widget grid(){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: phakicToricLenseList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 6),),
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          color: Colors.grey[200],
          child: new Row(
            children: [
          IconButton(
          icon: Icon(phakicToricLenseList[index].isSelected?Icons.brightness_1:Icons.panorama_fish_eye,color: AppColors.themeColor,),
          onPressed: () {
            for(int i=0;i<phakicToricLenseList.length;i++){
              phakicToricLenseList[i].isSelected = false;
            }
            setState(() {
              cylinderValue = phakicToricLenseList[index].value;
              expectedCylinderIndex = index;
              isPhacikLens = false;
              resetList();
              phakicToricLenseList[index].isSelected = true;
            });
          },
        ),
              new Text(phakicToricLenseList[index].value.toString())
            ],
          ),
        );
      },
    );
  }
}
class PowerOfLens{
  bool isSelected;
  double sphere1;
  double cylinder1;
  double sphere2;
  double cylinder2;
  double spherical;
  double axis;
  PowerOfLens(this.isSelected,this.sphere1,this.cylinder1,this.sphere2,this.cylinder2,this.spherical,this.axis);
}
class ExpectedSpherical{
  double value1;
  double value2;
  double value3;
  double value4;
  double value5;
  ExpectedSpherical(this.value1,this.value2,this.value3,this.value4,this.value5,);
}
class PhakicToricLense{
  bool isSelected;
  double value;
  PhakicToricLense(this.isSelected,this.value);
}