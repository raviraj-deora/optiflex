//import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:optiflexcalculator/utils/app_colors.dart';
import 'package:optiflexcalculator/utils/common_utils.dart';
import 'package:optiflexcalculator/utils/validation_utils.dart';

import 'calculation_screen.dart';
import 'model/data_model.dart';
//import 'package:horizontal_data_table/horizontal_data_table.dart';
//import 'package:http/http.dart' as http;

//void main() => runApp(Calculaute());

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Optiflex Glaze Calculators';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        automaticallyImplyLeading: true,
      ),
      body: MyCustomForm(),
    );
  }
}



// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  TextEditingController _date2 = new TextEditingController();
  final nameController = TextEditingController();
  final patientidController = TextEditingController();
  final doctornameController = TextEditingController();
  final k1Controller = TextEditingController();
  final k1axisController = TextEditingController();
  final k2Controller = TextEditingController();
  final k2axisController = TextEditingController();
  final preopsphController = TextEditingController();
  final preopcylController = TextEditingController();
  final preopcylaxisController = TextEditingController();
  final corthkController = TextEditingController();
  final vertaxController = TextEditingController();
  final wtwmanualController = TextEditingController();
  final wtworbscanController = TextEditingController();
  final acdController = TextEditingController();
  // final dobController = TextEditingController();
  String radioItem = '';
  bool isLeftSelect = false;

  String dateMessage = "Age of this patient is outside our recommended age group.Click Continue to Proceddd.";

  int popCount = 0;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    int yearDiff = DateTime.now().year - selectedDate.year;
    print("yearDiff = $yearDiff");
    if(yearDiff<28 || yearDiff>45){
      datePopup();
    }

    if (picked != null && picked != selectedDate)
      {
        print("submit....");
        setState(() {
          selectedDate = picked;
          //print(formatDate(selectedDate, [dd, '/', mm, '/', yyyy]));
          _date.value = TextEditingValue(text: formatDate(selectedDate, [dd, '/', mm, '/', yyyy]));
        });
      }
  }
  datePopup(){
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext subContext) {
          return AlertDialog(
            content:Text(dateMessage),
            actions: <Widget>[
              FlatButton(child: Text('CONTINUE'),
                  onPressed: () {
                    Navigator.pop(subContext);
                  }),

            ],
          );
        });
  }
  submitPOpup1(){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext subContext) {
          return AlertDialog(
            content:Text("The corneal cylinder and refractive cylinder do not match. Click Continue to Confirm or Cancel to change values."),
            actions: <Widget>[
              FlatButton(child: Text('CONTINUE'),
                  onPressed: () {
                    Navigator.pop(subContext);
                  }),
              FlatButton(child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(subContext);
                  }),
            ],
          );
        });
  }
  k1k2Popup2(){
    popCount++;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext subContext) {
          return AlertDialog(
            content:Text("The axis of K1 and k2 are not 90 degrees apart. Click Continue to Confirm or Cancel to change values."),
            actions: <Widget>[
              FlatButton(child: Text('CONTINUE'),
                  onPressed: () {
                    popHide(subContext);
                  }),
              FlatButton(child: Text('CANCEL'),
                  onPressed: () {
                    popHide(subContext);
                  }),
            ],
          );
        });
  }
  AnteriorChamberPopup(){
    popCount++;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext subContext) {
          return AlertDialog(
            content:Text("The entered value for Anterior Chamber Depth is >3.5mm."),
            actions: <Widget>[
              FlatButton(child: Text('CONTINUE'),
                  onPressed: () {
                    popHide(subContext);
                  }),
              FlatButton(child: Text('CANCEL'),
                  onPressed: () {
                    popHide(subContext);
                  }),
            ],
          );
        });
  }
  popHide(BuildContext subContext){
    Navigator.pop(subContext);
    popCount--;
    print("popCount = $popCount");
    if(popCount==0){
      calculateData();
      Scaffold.of(context).showSnackBar(
          SnackBar(
              content:
              Text('Processing Data')));
    }
  }
  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date2.value = TextEditingValue(text: formatDate(selectedDate, [dd, '/', mm, '/', yyyy]));
      });
  }

  final _formKey = GlobalKey<FormState>();

  double getClosest(double search, List arr) {
    double closest;
    arr.forEach((element) {
      if (closest == null ||
          (search - closest).abs() > (element - search).abs()) {
        closest = element;
      }
    });
    return closest;
  }

  Future calculateData() async {
    // Getting value from Controller
    String name = nameController.text;
    String dob = _date.text;
    String date2 = _date2.text;
    String eye = _date2.text;
    String patientid = patientidController.text;
    String doctorname = doctornameController.text;
    String k1 = k1Controller.text.replaceAll(",", ".");
    double k1axis = double.parse(k1axisController.text);
    String k2 = k2Controller.text.replaceAll(",", ".");
    double k2axis = double.parse(k2axisController.text);
    String preopsph = preopsphController.text.replaceAll(",", ".");
    String preopcyl = preopcylController.text;
    String preopcylaxis = preopcylaxisController.text;
    String corthk = corthkController.text.replaceAll(",", ".");
    double corthktmp = double.parse(corthk);
    double corthkfloat = double.parse((corthktmp).toStringAsFixed(2));
    double vertax = 12;
    String wtwmanual = wtwmanualController.text.replaceAll(",", ".");
    String wtworbscan = wtworbscanController.text.replaceAll(",", ".");
    String acd = acdController.text.replaceAll(",", ".");
    double acdtmp = double.parse(acd);
    double acdfloat = double.parse((acdtmp).toStringAsFixed(2));
    double preopsphtmp = double.parse(preopsph);
    double preopsphfloat = double.parse((preopsphtmp).toStringAsFixed(2));
    double preopcyltmp = double.parse(preopcyl);
    double preopcyfloat = double.parse((preopcyltmp).toStringAsFixed(2));
    double preopcylaxisfloat = double.parse(preopcylaxis);
    bool SameRValues = false;
    // String ;
    double refractivePower,
        axisofRefractivePower,
        kaxisofRefractivePower,
        rkref;

    double PostOpSphere = 0.01;
    // $rprerx = preopsphfloat
    // $rdpostrx = preopcyfloat
    // $axisofrdpostrx = preopcylaxisfloat
    // $axisofRefractivePower = axisofRefractivePower
    // $refractivePower = refractivePower
    if (preopsphfloat > (preopsphfloat + preopcyfloat)) {
      refractivePower = preopsphfloat + preopcyfloat;
      axisofRefractivePower = preopcylaxisfloat;
    } else if (preopsphfloat < (preopsphfloat + preopcyfloat)) {
      refractivePower = preopsphfloat;
      if (preopcylaxisfloat >= 90) {
        axisofRefractivePower = preopcylaxisfloat - 90;
      } else {
        axisofRefractivePower = preopcylaxisfloat + 90;
      }
    } else if (preopsphfloat == (preopsphfloat + preopcyfloat)) {
      refractivePower = preopsphfloat;
      if (preopcylaxisfloat >= 90) {
        axisofRefractivePower = preopcylaxisfloat;
      } else {
        axisofRefractivePower = preopcylaxisfloat + 90;
      }
      SameRValues = true;
    }
    // $k1 = k1float
    // $k2 = k2float
    // $axisofk1 =  k1axisfloat
    // $axisofk2 = k2axisfloat
    // $kaxisofRefractivePower = kaxisofRefractivePower
    // $raxisofk1 = k1axis
    // $raxisofk2 = k2axis
    // $rk1 = k1
    // $rk2 = k2
    // $txtAnteriorChamberDepth = acdfloat
    double k1tmp = double.parse(k1);
    double k1float = double.parse((k1tmp).toStringAsFixed(2));
    double k2tmp = double.parse(k2);
    double k2float = double.parse((k2tmp).toStringAsFixed(2));
    double k1axisfloat = double.parse((k1axis).toStringAsFixed(2));
    double k2axisfloat = double.parse((k2axis).toStringAsFixed(2));

    if (axisofRefractivePower >= 90) {
      kaxisofRefractivePower = axisofRefractivePower - 90;
    } else {
      kaxisofRefractivePower = axisofRefractivePower + 90;
    }
    if (k1axis > 90) {
      k1axis = k1axis - 180;
    }
    if (k2axis > 90) {
      k2axis = k2axis - 180;
    }
    if (kaxisofRefractivePower > 90) {
      kaxisofRefractivePower = kaxisofRefractivePower - 180;
    }

    double diffaxisofk1 = (kaxisofRefractivePower - k1axis).abs();
    double diffaxisofk2 = (kaxisofRefractivePower - k2axis).abs();
    if (diffaxisofk1 < diffaxisofk2) {
      print("1....");
      rkref = k1float;
    }
    if (diffaxisofk2 < diffaxisofk1) {
      print("2....");
      rkref = k2float;
    }
    if (SameRValues == true) {
      print("3....");
      rkref = [k1float, k2float].reduce(max);
    }
// $kref = kref
    double kref = double.parse((rkref).toStringAsFixed(2));
    double effectivelenseposition = acdfloat + corthkfloat - 0.3;
    double rleftbottomvalue1 = (1000 / refractivePower) - vertax;
    double leftbottomvalue1 =
        double.parse((rleftbottomvalue1).toStringAsFixed(2));
    double rleftbottomvalue2 = (1000 / rleftbottomvalue1) + rkref;
    double leftbottomvalue2 =
        double.parse((rleftbottomvalue2).toStringAsFixed(2));
    double rleftbottomtotalvalue =
        (1336 / rleftbottomvalue2) - effectivelenseposition;
    double leftbottomtotalvalue =
        double.parse((rleftbottomtotalvalue).toStringAsFixed(2));
    double rleftiolpower = (1336 / rleftbottomtotalvalue);
    double leftiolpower = double.parse((rleftiolpower).toStringAsFixed(2));
    double rrightbottomvalue1 = (1000 / PostOpSphere) - vertax;
    double rightbottomvalue1 =
        double.parse((rrightbottomvalue1).toStringAsFixed(2));
    double rrightbottomvalue2 = (1000 / rrightbottomvalue1) + rkref;
    double rightbottomvalue2 =
        double.parse((rrightbottomvalue2).toStringAsFixed(2));
    double rrightbottomtotalvalue =
        (1336 / rrightbottomvalue2) - effectivelenseposition;
    double rightbottomtotalvalue =
        double.parse((rrightbottomtotalvalue).toStringAsFixed(2));
    double rrightiolpower = (1336 / rrightbottomtotalvalue);
    double rightiolpower = double.parse((rrightiolpower).toStringAsFixed(2));

//	$rsize_of_phakic = (1.043 * $wtw) + 0.377;
//	$rsize_of_phakic = (1.043 * 11.9) + 0.377;
    double rmy_totalphakiciolpower =
        rleftiolpower - rrightiolpower; //Toatal Phakic IOL Power
    double my_totalphakiciolpower =
        double.parse((rmy_totalphakiciolpower).toStringAsFixed(2));
    double totalphakiciolpower =
        double.parse((rmy_totalphakiciolpower).toStringAsFixed(2));

    double wtw;
    if (wtwmanual == '') {
      wtw = double.parse(wtworbscan) - 0.15;
    } else {
      wtw = double.parse(wtwmanual);
    }
    //$rsize_of_phakic = (1.043*$wtw) + 0.377;
    double rsize_of_phakic = (1.043 * wtw) + 0.377;

    if (acdfloat <= 3.19)
      rsize_of_phakic = rsize_of_phakic + 0.17;
    else if (acdfloat >= 3.2 && acdfloat <= 3.4)
      rsize_of_phakic = rsize_of_phakic + 0.2;
    else if (acdfloat > 3.4) rsize_of_phakic = rsize_of_phakic + 0.4;

    if (totalphakiciolpower < -22) {
      totalphakiciolpower = -22;
    }
    double rFirstMinusSizeOfPhakic = rmy_totalphakiciolpower - 0.5;
    double FirstMinusSizeOfPhakic = totalphakiciolpower - 0.5;
    double rSecondMinusSizeOfPhakic = rFirstMinusSizeOfPhakic - 0.5;
    double SecondMinusSizeOfPhakic = FirstMinusSizeOfPhakic - 0.5;
    double rFirstPlusSizeOfPhakic = rmy_totalphakiciolpower + 0.5;
    double FirstPlusSizeOfPhakic = totalphakiciolpower + 0.5;
    double rSecondPlusSizeOfPhakic = rFirstPlusSizeOfPhakic + 0.5;
    double SecondPlusSizeOfPhakic = FirstPlusSizeOfPhakic + 0.5;
    double PredictableSizeOfPhakic = double.parse(
        (0.81 * (rmy_totalphakiciolpower - totalphakiciolpower))
            .toStringAsFixed(2));
    double PredictableFirstMinusSizeOfPhakic = double.parse(
        (0.81 * (rmy_totalphakiciolpower - FirstMinusSizeOfPhakic))
            .toStringAsFixed(2));
    double PredictableSecondMinusSizeOfPhakic = double.parse(
        (0.81 * (rmy_totalphakiciolpower - SecondMinusSizeOfPhakic))
            .toStringAsFixed(2));
    double PredictableFirstPlusSizeOfPhakic = double.parse(
        (0.81 * (rmy_totalphakiciolpower - FirstPlusSizeOfPhakic))
            .toStringAsFixed(2));
    double PredictableSecondPlusSizeOfPhakic = double.parse(
        (0.81 * (rmy_totalphakiciolpower - SecondPlusSizeOfPhakic))
            .toStringAsFixed(2));

    double X = acdfloat + corthkfloat - 0.3;
    String porone =
        preopsphfloat.toString() + "@" + preopcylaxisfloat.toString();
    double porperval = preopsphfloat + preopcyfloat;
    int aD;
    if (preopcylaxisfloat >= 90) {
      aD = -90;
    } else {
      aD = 90;
    }
    double porperdeg = preopcylaxisfloat + aD;
    String porper = porperval.toString() + "@" + porperdeg.toString();
    String rH, rL, kH, kL;
    double higherRefractivePower,
        lowerRefractivePower,
        rHd,
        rLd,
        kHv,
        kLv,
        kHd,
        kLd,
        rLd4ka,
        kLd4ka,
        rHd4ka;

    if (preopsphfloat > porperval) {
      rH = porone;
      higherRefractivePower = preopsphfloat;
      lowerRefractivePower = porperval;
      rHd = preopcylaxisfloat;
      rL = porper;
      rLd = porperdeg;
    } else {
      rH = porper;
      higherRefractivePower = porperval;
      lowerRefractivePower = preopsphfloat;
      rHd = porperdeg;
      rL = porone;
      rLd = preopcylaxisfloat;
    }

    if (k1float > k2float) {
      kHv = k1float;
      kLv = k2float;
      kHd = k1axisfloat;
      kLd = k2axisfloat;
      kH = k1float.toString() + "@" + k1axisfloat.toString();
      kL = k2float.toString() + "@" + k2axisfloat.toString();
    } else {
      kHv = k2float;
      kLv = k1float;
      kHd = k2axisfloat;
      kLd = k1axisfloat;
      kH = k2float.toString() + "@" + k2axisfloat.toString();
      kL = k1float.toString() + "@" + k1axisfloat.toString();
    }

    if (rLd == 0) {
      rLd4ka = 180;
    } else {
      rLd4ka = rLd;
    }
    if (kLd == 0) {
      kLd4ka = 180;
    } else {
      kLd4ka = kLd;
    }

    if (higherRefractivePower == 0) {
      higherRefractivePower = 0.001;
    }
    if (lowerRefractivePower == 0) {
      lowerRefractivePower = 0.001;
    }

    double kA =
        kLv + ((kHv - kLv) * (pow(sin((rLd4ka - kLd4ka) * 3.14 / 180), 2)));
    double aL = (1000 / lowerRefractivePower) - vertax;
    double bL = (1000 / PostOpSphere) - vertax;
    double cL = (1000 / aL) + kA;
    double dL = (1000 / bL) + kA;
    double eL = (1336 / cL) - X;
    double fL = (1336 / dL) - X;
    double gL = (1336 / eL);
    double hL = (1336 / fL);

    if (rHd == 0) {
      rHd4ka = 180;
    } else {
      rHd4ka = rHd;
    }
    if (kLd == 0) {
      kLd4ka = 180;
    } else {
      kLd4ka = kLd;
    }
    double kB =
        kLv + ((kHv - kLv) * (pow(sin((rHd4ka - kLd4ka) * 3.14 / 180), 2)));
    double aH = (1000 / higherRefractivePower) - vertax;
    double bH = (1000 / PostOpSphere) - vertax;
    double cH = (1000 / aH) + kB;
    double dH = (1000 / bH) + kB;
    double eH = (1336 / cH) - X;
    double fH = (1336 / dH) - X;
    double gH = (1336 / eH);
    double hH = (1336 / fH);
    double lowerlenspower = double.parse((gL - hL).toStringAsFixed(5));
    double higherlenspower = double.parse((gH - hH).toStringAsFixed(5));

    List selectedSphericalPowerArr = [
      -3.0,
      -3.5,
      -4.0,
      -4.5,
      -5.0,
      -5.5,
      -6.0,
      -6.5,
      -7.0,
      -7.5,
      -8.0,
      -8.5,
      -9.0,
      -9.5,
      -10.0,
      -10.5,
      -11.0,
      -11.5,
      -12.0,
      -12.5,
      -13.0,
      -13.5,
      -14.0,
      -14.5,
      -15.0,
      -15.5,
      -16.0,
      -16.5,
      -17.0,
      -17.5,
      -18.0,
      -18.5,
      -19.0,
      -19.5,
      -20.0,
      -20.5,
      -21.0,
      -21.5,
      -22.0,
      -22.5,
      -23.0
    ];

    double middlevalueofspehere =
        getClosest(lowerlenspower, selectedSphericalPowerArr);

    if ((lowerlenspower - middlevalueofspehere) >= 0) {
      while ((lowerlenspower - middlevalueofspehere) >= 0) {
        middlevalueofspehere = middlevalueofspehere + 0.5;
      }
    }

    if (middlevalueofspehere < -22) {
      middlevalueofspehere = -22;
    }
    if (middlevalueofspehere > -4) {
      middlevalueofspehere = -4;
    }

    double firstvalueofspehere = middlevalueofspehere + 1;
    double secondvalueofspehere = middlevalueofspehere + 0.5;
    double fourthvalueofspehere = middlevalueofspehere - 0.5;
    double fifthvalueofspehere = middlevalueofspehere - 1;
    List selectedCylinderPowerArr = [
      0.0,
      0.5,
      1.0,
      1.5,
      2.0,
      2.5,
      3.0,
      3.5,
      4.0,
      4.5,
      5.0
    ];
    double valueofcylinder = higherlenspower - lowerlenspower;
    double selectedvalueofcylinder =
        getClosest(valueofcylinder, selectedCylinderPowerArr);

    if (selectedvalueofcylinder > valueofcylinder) {
      while (selectedvalueofcylinder > valueofcylinder) {
        selectedvalueofcylinder = selectedvalueofcylinder - 0.5;
      }
    }

    double axisofplacement = rLd;
    double middlevalueofresidualsphere =
        0.81 * (lowerlenspower - middlevalueofspehere);
    middlevalueofresidualsphere =
        double.parse((middlevalueofresidualsphere).toStringAsFixed(2));
    double firstvalueofresidualsphere =
        0.81 * (lowerlenspower - firstvalueofspehere);
    firstvalueofresidualsphere =
        double.parse((firstvalueofresidualsphere).toStringAsFixed(2));
    double secondvalueofresidualsphere =
        0.81 * (lowerlenspower - secondvalueofspehere);
    secondvalueofresidualsphere =
        double.parse((secondvalueofresidualsphere).toStringAsFixed(2));
    double fourthvalueofresidualsphere =
        0.81 * (lowerlenspower - fourthvalueofspehere);
    fourthvalueofresidualsphere =
        double.parse((fourthvalueofresidualsphere).toStringAsFixed(2));
    double fifthvalueofresidualsphere =
        0.81 * (lowerlenspower - fifthvalueofspehere);
    fifthvalueofresidualsphere =
        double.parse((fifthvalueofresidualsphere).toStringAsFixed(2));
    double valueofresidualcylinder,
        middlevalueofsphericalequivalent,
        firstvalueofsphericalequivalent,
        secondvalueofsphericalequivalent,
        fourthvalueofsphericalequivalent,
        fifthvalueofsphericalequivalent;
    if (selectedvalueofcylinder == 0) {
      valueofresidualcylinder = valueofcylinder;
    } else
      valueofresidualcylinder =
          0.81 * (valueofcylinder - selectedvalueofcylinder);
    valueofresidualcylinder =
        double.parse((valueofresidualcylinder).toStringAsFixed(2));
    if (selectedvalueofcylinder != 0) {
      middlevalueofsphericalequivalent =
          middlevalueofresidualsphere + (valueofresidualcylinder / 2);
      firstvalueofsphericalequivalent =
          firstvalueofresidualsphere + (valueofresidualcylinder / 2);
      secondvalueofsphericalequivalent =
          secondvalueofresidualsphere + (valueofresidualcylinder / 2);
      fourthvalueofsphericalequivalent =
          fourthvalueofresidualsphere + (valueofresidualcylinder / 2);
      fifthvalueofsphericalequivalent =
          fifthvalueofresidualsphere + (valueofresidualcylinder / 2);
    } else /* if phakic lens ($selectedvalueofcylinder==0)*/
    {
      if (selectedvalueofcylinder < valueofcylinder) {
        middlevalueofsphericalequivalent =
            middlevalueofresidualsphere + (valueofresidualcylinder / 2);
        firstvalueofsphericalequivalent =
            firstvalueofresidualsphere + (valueofresidualcylinder / 2);
        secondvalueofsphericalequivalent =
            secondvalueofresidualsphere + (valueofresidualcylinder / 2);
        fourthvalueofsphericalequivalent =
            fourthvalueofresidualsphere + (valueofresidualcylinder / 2);
        fifthvalueofsphericalequivalent =
            fifthvalueofresidualsphere + (valueofresidualcylinder / 2);
      } else {
        firstvalueofresidualsphere =
            firstvalueofresidualsphere + valueofresidualcylinder;

        secondvalueofresidualsphere =
            secondvalueofresidualsphere + valueofresidualcylinder;

        middlevalueofresidualsphere =
            middlevalueofresidualsphere + valueofresidualcylinder;

        fourthvalueofresidualsphere =
            fourthvalueofresidualsphere + valueofresidualcylinder;

        fifthvalueofresidualsphere =
            fifthvalueofresidualsphere + valueofresidualcylinder;

        valueofresidualcylinder = -(valueofresidualcylinder);

        middlevalueofsphericalequivalent =
            middlevalueofresidualsphere + (valueofresidualcylinder / 2);

        firstvalueofsphericalequivalent =
            firstvalueofresidualsphere + (valueofresidualcylinder / 2);

        secondvalueofsphericalequivalent =
            secondvalueofresidualsphere + (valueofresidualcylinder / 2);

        fourthvalueofsphericalequivalent =
            fourthvalueofresidualsphere + (valueofresidualcylinder / 2);

        fifthvalueofsphericalequivalent =
            fifthvalueofresidualsphere + (valueofresidualcylinder / 2);

        if (axisofplacement < 90)
          axisofplacement = axisofplacement + 90;
        else
          axisofplacement = axisofplacement - 90;
      }
    }

    //  print(diffaxisofk1);
    //  print(kaxisofRefractivePower);
    //  print(diffaxisofk2);
    //  print(rkref);
    String size_of_phakic;
    if (rsize_of_phakic < 12.26) {
      size_of_phakic = "12.0";
    }
    if (rsize_of_phakic >= 12.26 && rsize_of_phakic < 12.76) {
      size_of_phakic = "12.5";
    }
    if (rsize_of_phakic >= 12.76 && rsize_of_phakic < 13.26) {
      size_of_phakic = "13.0";
    }
    if (rsize_of_phakic >= 13.26) {
      size_of_phakic = "13.5";
    }

    middlevalueofsphericalequivalent =
        double.parse(middlevalueofsphericalequivalent.toStringAsFixed(2));
    firstvalueofsphericalequivalent =
        double.parse(firstvalueofsphericalequivalent.toStringAsFixed(2));
    secondvalueofsphericalequivalent =
        double.parse(secondvalueofsphericalequivalent.toStringAsFixed(2));
    fourthvalueofsphericalequivalent =
        double.parse(fourthvalueofsphericalequivalent.toStringAsFixed(2));
    fifthvalueofsphericalequivalent =
        double.parse(fifthvalueofsphericalequivalent.toStringAsFixed(2));

    final data = Data(
        namepass: name,
        birthdatepass: dob,
        idpass: patientid,
        doctornamepass: doctorname,
        datepass: date2,
        eyepass: radioItem,
        flatk: kLv.toString() +
            " @ " +
            kLd.toString() +
            String.fromCharCode(0x00B0),
        steepk: kHv.toString() +
            " @ " +
            kHd.toString() +
            String.fromCharCode(0x00B0),
        preofsphpass: preopsphfloat.toString(),
        preofcylpass: preopcyfloat.toString() +
            " @ " +
            preopcylaxisfloat.toString() +
            String.fromCharCode(0x00B0),
        corthkpass: corthkfloat.toString(),
        backvertaxpass: vertax.toString(),
        wtwpass: wtw.toString(),
        acdpass: acdfloat.toString(),
        iolmodelpass: size_of_phakic,
        firstvalueofspherepass: firstvalueofspehere,
        secondvalueofspherepass: secondvalueofspehere,
        middlevalueofspherepass: middlevalueofspehere,
        fourthvalueofspgerepass: fourthvalueofspehere,
        fifthvalueofspherepass: fifthvalueofspehere,
        selectedvalueofcylinderpass: selectedvalueofcylinder,
        firstvalueofresidualspherepass: firstvalueofresidualsphere,
        secondvalueofresidualspherepass: secondvalueofresidualsphere,
        middlevalueofresidualspherepass: middlevalueofresidualsphere,
        fourthvalueofresidualspherepass: fourthvalueofresidualsphere,
        fifthvalueofresidualspherepass: fifthvalueofresidualsphere,
        valueofresidualcylinderpass: valueofresidualcylinder,
        firstvalueofsphericalequivalentpass:
            firstvalueofsphericalequivalent,
        secondvalueofsphericalequivalentpass:
            secondvalueofsphericalequivalent,
        middlevalueofsphericalequivalentpass:
            middlevalueofsphericalequivalent,
        fourthvalueofsphericalequivalentpass:
            fourthvalueofsphericalequivalent,
        fifthvalueofsphericalequivalentpass:
            fifthvalueofsphericalequivalent,
        axisofplacementpass: axisofplacement);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalculationScreen(data,)));
    //print(k2axisfloat);
  }

  TextStyle headingStyle = TextStyle(fontSize: 16);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doctornameController.text = "Anirudh";
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 10, // 20%
                child: Column(
                  children: <Widget>[
                    Common.headingWidget("Patient Details"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 2, // 20%
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButtonFormField(
                                  value: 'Mr',
                                  items: ['Mr', 'Miss', 'Mrs']
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      //_ratingController = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: nameController,
                                  validator: ValidationUtils.validateName,
                                  decoration: InputDecoration(
                                      hintText: 'Please enter your name',
                                      labelText: 'Name'),
                                ),
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
                          flex: 100, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Text("Date Of Birth",style: headingStyle,),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _date,
                                      validator: (value){
                                        return ValidationUtils.validateEmpty(value, "Date Of Birth");
                                      },
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          hintText: 'DD/MM/YYYY',
                                          labelText: 'DD/MM/YYYY'),
                                    ),
                                  ),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Text("Patient\'s ID",style: headingStyle,),
                                TextFormField(
                                  controller: patientidController,
                                  validator: (value){
                                    return ValidationUtils.validateEmpty(value, "Patient\'s ID");
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Please enter patient\'s id',
                                      labelText: 'Patient Case No.'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Text("Docotor\'s Name",style: headingStyle,),
                                TextFormField(
                                  controller: doctornameController,
                                  validator: (value){
                                    return ValidationUtils.validateEmpty(value, "Docotor\'s Name");
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Please enter docotor\'s name',
                                      labelText: 'Anirudh'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Text("Date",style: headingStyle,),
                                GestureDetector(
                                  onTap: () => _selectDate2(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _date2,
                                      validator: (value){
                                        return ValidationUtils.validateEmpty(value, "Date");
                                      },
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          hintText: 'Date', labelText: 'DD/MM/YYYY'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isLeftSelect = !isLeftSelect;
                              });
                            },
                            icon: Icon(isLeftSelect?Icons.brightness_1:Icons.panorama_fish_eye,color: AppColors.themeColor,),
                          ),
                          Text("Right eye-OD"),
                          Expanded(child: Container(),),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isLeftSelect = !isLeftSelect;
                              });
                            },
                            icon: Icon(!isLeftSelect?Icons.brightness_1:Icons.panorama_fish_eye,color: AppColors.themeColor,),
                          ),
                          Text("Left eye-OS"),

                        ],
                      ),
                    ),
                    Common.headingWidget("pre-operative data"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                    children: [
                                      Text("K1",style: headingStyle,),
                                      Text("*",style:TextStyle(color: Colors.red),),
                                    ],
                                ),
                                TextFormField(
                                  controller: k1Controller,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validatePosField(35, 60,value, "k1");
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Please enter value of K1',
                                      labelText: '(35.00 D to 60.00 D)'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Axis of K1",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: k1axisController,
                                  validator: (value){
                                    print("value= $value");
                                    return ValidationUtils.validateDigree(k1axisController.text, "Axis of k1");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText: '(0° to 180°)'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("K2",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: k2Controller,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validatePosField(35, 60,value, "k2");
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Please enter value of K2',
                                      labelText: '(35.00 D to 60.00 D)'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Axis of K2",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: k2axisController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateDigree(value, "Axis of k2");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText: '(0° to 180)'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Pre-Operative Sphere",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: preopsphController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateField(-1,-25,value, "Pre-Operative Sphere");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '-1.0D to -25.0D',
                                      labelText: '-1.0D to -25.0D'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Pre-Operative Cylinder",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: preopcylController,
                                  validator: (value){
                                    return ValidationUtils.validateCylinder(value, "Pre-Perative Cylinder");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '-10.0D to +10.0D',
                                      labelText: '-10.0D to +10.0D'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Axis Of Pre-Operative Cylinder",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: preopcylaxisController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateDigree(value, "Axis Of Pre-Operative Cylinder");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText:
                                          '(0° to 180)'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Corneal Thickness",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: corthkController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateDoubleField(0.25,0.70,value, "Axis Of Pre-Operative Cylinder");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '0.25mm to 0.70mm',
                                      labelText: '0.25mm to 0.70mm'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Back Vertex Distance(in mm)",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  // controller: vertaxController,
                                  initialValue: '12',
                                  decoration: InputDecoration(
                                      hintText: '0.25mm to 0.70mm',
                                      //labelText: 'Back Vertex Distance(in mm)'
                                  ),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("White to White Distance",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                  ],
                                ),
                                TextFormField(
                                  controller: wtwmanualController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateDoubleField(10.5,12.6,value, "White to White Distance");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '',
                                      labelText: '10.5mm to 12.6mm'),
                                ),

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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Anterior Chamber Depth",style: headingStyle,),
                                    Text("*",style:TextStyle(color: Colors.red),),
                                    Text("(From Endothelium)",style: TextStyle(fontSize: 12,color: AppColors.themeGreyColor),),
                                  ],
                                ),
                                TextFormField(
                                  controller: acdController,
                                  validator: (value){
                                    print("value = $value");
                                    return ValidationUtils.validateDoubleField(2.80,4.5,value, "Anterior Chamber Depth");
                                  },
                                  decoration: InputDecoration(
                                      hintText: '2.80mm to 4.50mm',
                                      labelText: '2.80mm to 4.50mm'),
                                ),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: RaisedButton(
                                    color: AppColors.themeColor,
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      if (_formKey.currentState.validate()) {
                                        print("form validate");
                                        // If the form is valid, display a Snackbar.
                                        //submitPOpup1();

                                        double k2Val = double.parse(k2Controller.text.trim());
                                        double k1Val = double.parse(k1Controller.text.trim());
                                        double k1k2Diff = k2Val - k1Val;
                                        if(k1k2Diff!=90){
                                          k1k2Popup2();
                                        }

                                        double acdValue = double.parse(acdController.text.trim());
                                        if(acdValue>3.5){
                                          AnteriorChamberPopup();
                                        }
                                      }
                                    },
                                    child: Text('Calculate',style: TextStyle(color: Colors.white),),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _oldRadioWidget(){
    return Expanded(
      flex: 10, // 80%
      child: Padding(
        padding:
        const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile(
              groupValue: radioItem,
              title: Text('Right-eye OD',
                  style: TextStyle(fontSize: 15.0)),
              value: 'right-eye',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),
            RadioListTile(
              groupValue: radioItem,
              title: Text('Left-eye OD'),
              value: 'left-eye',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


