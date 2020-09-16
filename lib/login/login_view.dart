import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:optiflexcalculator/utils/preferences.dart';
import 'package:optiflexcalculator/utils/validation_utils.dart';
import '../home_screen.dart';
import '../main.dart';
import 'login_presenter.dart';
import 'model/login_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginScreenContract{

  BuildContext _ctx;

  bool visible = false;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  LoginScreenPresenter _presenter;

  _LoginViewState() {
    _presenter = new LoginScreenPresenter(this);
  }

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onLoginError(String errorTxt) {
    print("onLoginError ");
    //_onHideLoading();
    setState(() {
      visible = false;
    });
    _showSnackBar(errorTxt);
  }

  @override
  void onLoginSuccess(LoginResponse response) async {
    setState(() => _isLoading = false);
    // _onHideLoading();
    _showSnackBar("Login successful!");
    Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  @override
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
  void _submit() {
    setState(() {
      visible = true;
    });
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    _presenter.doLogin(email, password);
  }

  Future userLogin() async {
    if (!formKey.currentState.validate()) {
    }
    else
    {
      _submit();
    }
  }

  void autoLogIn() async {
    await Preferences.getString(Preferences.PF_USER_LOGIN).then((data)
    {
      if (data != null) {
        LoginResponse loginResponse = LoginResponse.fromJson(json.decode(data));
        user = loginResponse.r;

        if (loginResponse != null) {
          setState(() {
          });
          Navigator.of(_ctx).pushReplacementNamed("/home");
          return;
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
  }
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      key: scaffoldKey,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('User Login Form', style: TextStyle(fontSize: 21))),

                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: ValidationUtils.validateUsername,
                      autocorrect: true,
                      decoration:
                      InputDecoration(hintText: 'Enter Your User Name Here'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: ValidationUtils.validatePassword,
                      autocorrect: true,
                      obscureText: true,
                      decoration:
                      InputDecoration(hintText: 'Enter Your Password Here'),
                    )),
                RaisedButton(
                  onPressed: userLogin,
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                  child: Text('Click Here To Login'),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator())),
              ],
            ),
          ),
        ));
  }

}
class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String username = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url =
        'https://www.optiflexcalculators.com/optiflexapp/api/login_user.php';

    // Store all data with Param Name.
    var data = {'username': username, 'password': password};

    // Starting Web API Call.
    print("json.encode(data) = ${json.encode(data)}");
    //var response = await http.post(url, body: json.encode(data));


    var response;
    print("response = $response");
    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('User Login Form', style: TextStyle(fontSize: 21))),
                  Divider(),
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: emailController,
                        autocorrect: true,
                        decoration:
                        InputDecoration(hintText: 'Enter Your User Name Here'),
                      )),
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration:
                        InputDecoration(hintText: 'Enter Your Password Here'),
                      )),
                  RaisedButton(
                    onPressed: userLogin,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    child: Text('Click Here To Login'),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator())),
                ],
              ),
            )));
  }
}