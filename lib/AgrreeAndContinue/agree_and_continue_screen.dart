import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optiflexcalculator/utils/app_colors.dart';

class AgreeAndContinueScreen extends StatefulWidget {
  @override
  _AgreeAndContinueScreenState createState() => _AgreeAndContinueScreenState();
}

class _AgreeAndContinueScreenState extends State<AgreeAndContinueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biotech Calculators"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/biotech_title.png"),),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10),
              height: MediaQuery.of(context).size.height*0.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("OVERVIEW",style: TextStyle(color: Colors.grey,fontSize: 18),),
                    SizedBox(height: 5,),
                    Text("Biotech web sites are owned and operated by Biotech Europe Meditech Inc. Ltd., "
                        "a Irish company incorporated under the provisions of the Ireland Companies Act "
                        "1962-2012 having its registered office at AF 2, IDA Business & Technology Park, "
                        "Gallowstown, Co Roscommon, F42 P862. This website is designed to provide general "
                        "information about Biotech and its products and services. Nothing contained on this "
                        "website is intended to offer medical advice for the treatment of illness or disease,"
                        " or to be a substitute for professional medical advice, diagnosis or treatment. "
                        "Should you have a medical condition, promptly see your physician. Specific questions"
                        " pertaining to your medical condition and appropriate treatment should be directed "
                        "to your physician. Before using any product or service discussed on the web site, "
                        "please consult your physician.",style: TextStyle(fontSize: 16),),
                    Text("In addition, nothing presented here is intended to provide instructions "
                        "on the use of the products supplied by Biotech. For specific information "
                        "and instruction relative to Biotech's products and services, please refer "
                        "to the product labeling supplied with all Biotech products. "
                        "The intraocular lens is currently available for sale in the global markets "
                        "excluding North America (\"the Territory\"). All users are requested to read "
                    "and understand this Biotech intraocular lens web-based calculator license agreement "
                    "(\"this Agreement\").",style: TextStyle(fontSize: 16),),
                    Text("This Agreement is a legal, valid and binding agreement between "
                        "you (\"Licensee\") and Biotech. By choosing to click on the \"accept\" tab, "
                        "the Licensee agrees to abide the terms and conditions set out herein as well "
                        "as amendments to the same if any. Licensee's access to and use of the intraocular "
                        "lens web-based calculator provided by Biotech to the Licensee (the \"Calculator\") "
                        "is covered by the terms and conditions of this Agreement. The Licensee has the right "
                        "to decline by choosing the \"cancel\" button.",style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.themeColor,
              height: MediaQuery.of(context).size.height*0.198,
              child: Column(
                children: [
                  Text("Please read the License agreement - terms and conditions of use completely.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text("If you agree, click on Agree & Continue button to proceed.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {

                            },
                            child: Text("CANCEL",style: TextStyle(fontSize: 12),),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {

                            },
                            child: Text("AGREE & CONTINUE",style: TextStyle(fontSize: 12),),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}