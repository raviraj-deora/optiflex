//import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
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

class Data {
  String namepass;
  String birthdatepass;
  String idpass;
  String doctornamepass;
  String datepass;
  String eyepass;
  String flatk;
  String steepk;
  String preofsphpass;
  String preofcylpass;
  String corthkpass;
  String backvertaxpass;
  String wtwpass;
  String acdpass;
  String iolmodelpass;
  String firstvalueofspherepass,
      secondvalueofspherepass,
      middlevalueofspherepass,
      fourthvalueofspgerepass,
      fifthvalueofspherepass,
      selectedvalueofcylinderpass,
      firstvalueofresidualspherepass,
      secondvalueofresidualspherepass,
      middlevalueofresidualspherepass,
      fourthvalueofresidualspherepass,
      fifthvalueofresidualspherepass,
      valueofresidualcylinderpass,
      firstvalueofsphericalequivalentpass,
      secondvalueofsphericalequivalentpass,
      middlevalueofsphericalequivalentpass,
      fourthvalueofsphericalequivalentpass,
      fifthvalueofsphericalequivalentpass,
      axisofplacementpass;

  Data(
      {this.namepass,
      this.birthdatepass,
      this.idpass,
      this.doctornamepass,
      this.datepass,
      this.eyepass,
      this.flatk,
      this.steepk,
      this.preofsphpass,
      this.preofcylpass,
      this.corthkpass,
      this.backvertaxpass,
      this.wtwpass,
      this.acdpass,
      this.iolmodelpass,
      this.firstvalueofspherepass,
      this.selectedvalueofcylinderpass,
      this.secondvalueofspherepass,
      this.middlevalueofspherepass,
      this.fourthvalueofspgerepass,
      this.fifthvalueofspherepass,
      this.firstvalueofresidualspherepass,
      this.secondvalueofresidualspherepass,
      this.middlevalueofresidualspherepass,
      this.fourthvalueofresidualspherepass,
      this.fifthvalueofresidualspherepass,
      this.valueofresidualcylinderpass,
      this.firstvalueofsphericalequivalentpass,
      this.secondvalueofsphericalequivalentpass,
      this.middlevalueofsphericalequivalentpass,
      this.fourthvalueofsphericalequivalentpass,
      this.fifthvalueofsphericalequivalentpass,
      this.axisofplacementpass});
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: picked.toString().split(' ')[0]);
      });
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
        _date2.value = TextEditingValue(text: picked.toString().split(' ')[0]);
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
      rkref = k1float;
    }
    if (diffaxisofk2 < diffaxisofk1) {
      rkref = k2float;
    }
    if (SameRValues == true) {
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
        firstvalueofspherepass: firstvalueofspehere.toString(),
        secondvalueofspherepass: secondvalueofspehere.toString(),
        middlevalueofspherepass: middlevalueofspehere.toString(),
        fourthvalueofspgerepass: fourthvalueofspehere.toString(),
        fifthvalueofspherepass: fifthvalueofspehere.toString(),
        selectedvalueofcylinderpass: selectedvalueofcylinder.toString(),
        firstvalueofresidualspherepass: firstvalueofresidualsphere.toString(),
        secondvalueofresidualspherepass: secondvalueofresidualsphere.toString(),
        middlevalueofresidualspherepass: middlevalueofresidualsphere.toString(),
        fourthvalueofresidualspherepass: fourthvalueofresidualsphere.toString(),
        fifthvalueofresidualspherepass: fifthvalueofresidualsphere.toString(),
        valueofresidualcylinderpass: valueofresidualcylinder.toString(),
        firstvalueofsphericalequivalentpass:
            firstvalueofsphericalequivalent.toString(),
        secondvalueofsphericalequivalentpass:
            secondvalueofsphericalequivalent.toString(),
        middlevalueofsphericalequivalentpass:
            middlevalueofsphericalequivalent.toString(),
        fourthvalueofsphericalequivalentpass:
            fourthvalueofsphericalequivalent.toString(),
        fifthvalueofsphericalequivalentpass:
            fifthvalueofsphericalequivalent.toString(),
        axisofplacementpass: axisofplacement.toString());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalculationScreen(
                  data: data,
                )));
    //print(k2axisfloat);
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
                                    style: TextStyle(color: Colors.blue[900])),
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
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _date,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          hintText: 'Date of Birth',
                                          labelText: 'Date of Birth'),
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
                                TextFormField(
                                  controller: patientidController,
                                  decoration: InputDecoration(
                                      hintText: 'Please enter patient\'s id',
                                      labelText: 'Patient\'s ID'),
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
                                TextFormField(
                                  controller: doctornameController,
                                  decoration: InputDecoration(
                                      hintText: 'Please enter docotor\'s name',
                                      labelText: 'Docotor\'s Name'),
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
                                GestureDetector(
                                  onTap: () => _selectDate2(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _date2,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          hintText: 'Date', labelText: 'Date'),
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
                                    style: TextStyle(color: Colors.blue[900])),
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
                          flex: 10, // 80%
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: k1Controller,
                                  decoration: InputDecoration(
                                      hintText: 'Please enter value of K1',
                                      labelText: 'K1'),
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
                                TextFormField(
                                  controller: k1axisController,
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText: 'Axis of K1'),
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
                                TextFormField(
                                  controller: k2Controller,
                                  decoration: InputDecoration(
                                      hintText: 'Please enter value of K2',
                                      labelText: 'K2'),
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
                                TextFormField(
                                  controller: k2axisController,
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText: 'Axis of K2'),
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
                                TextFormField(
                                  controller: preopsphController,
                                  decoration: InputDecoration(
                                      hintText: '-1.0D to -25.0D',
                                      labelText: 'Pre-Operative Sphere'),
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
                                TextFormField(
                                  controller: preopcylController,
                                  decoration: InputDecoration(
                                      hintText: '-10.0D to +10.0D',
                                      labelText: 'Pre-Operative Cylinder'),
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
                                TextFormField(
                                  controller: preopcylaxisController,
                                  decoration: InputDecoration(
                                      hintText: '0° to 180°',
                                      labelText:
                                          'Axis Of Pre-Operative Cylinder'),
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
                                TextFormField(
                                  controller: corthkController,
                                  decoration: InputDecoration(
                                      hintText: '0.25mm to 0.70mm',
                                      labelText: 'Corneal Thickness'),
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
                                TextFormField(
                                  // controller: vertaxController,
                                  initialValue: '12',
                                  decoration: InputDecoration(
                                      hintText: '0.25mm to 0.70mm',
                                      labelText: 'Back Vertex Distance(in mm)'),
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
                                Text(
                                    'White to White Distance(10.5mm to 12.6mm)'),
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
                                TextFormField(
                                  controller: wtwmanualController,
                                  decoration: InputDecoration(
                                      hintText: '', labelText: 'Manual'),
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
                                TextFormField(
                                  controller: wtworbscanController,
                                  decoration: InputDecoration(
                                      hintText: '', labelText: 'ORBSCAN'),
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
                                TextFormField(
                                  controller: acdController,
                                  decoration: InputDecoration(
                                      hintText: '2.80mm to 4.50mm',
                                      labelText: 'Anterior Chamber Depth'),
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
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      if (_formKey.currentState.validate()) {
                                        // If the form is valid, display a Snackbar.
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Processing Data')));
                                        calculateData();
                                      }
                                    },
                                    child: Text('Calculate'),
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
}

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
                                                value:
                                                    '${data.firstvalueofspherepass}',
                                                groupValue: radioItem,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioItem = val;
                                                  });
                                                },
                                              ),
                                            )),
                                            DataCell(Text(
                                                '${data.firstvalueofspherepass}')),
                                            DataCell(Text(
                                                '${data.selectedvalueofcylinderpass}')),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(
                                              width: 10,
                                              child: Radio(
                                                value:
                                                    '${data.secondvalueofspherepass}',
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
                                                value:
                                                    '${data.middlevalueofspherepass}',
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
                                                value:
                                                    '${data.fourthvalueofspgerepass}',
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
                                                value:
                                                    '${data.fifthvalueofspherepass}',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 100%
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
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

  Future finalResults() async {
    print("Test called");
  }
}
