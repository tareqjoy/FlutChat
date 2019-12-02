import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String pass = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = new GlobalKey<FormState>();

  void signInOrUp() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      try {
        await signIn(email, pass);
        Fluttertoast.showToast(
            msg: 'Signed In',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        try {
          await signUp(email, pass);
          Fluttertoast.showToast(
              msg: 'Signed Up',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } catch (e2) {
          Fluttertoast.showToast(
              msg: e2.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/images/back1.jpg"),
                fit: BoxFit.cover,

              ),

            ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Center(

          child: Form(
              key: _formKey,
              child: Container(
                  height: 280,
                  margin: const EdgeInsets.symmetric(horizontal: 10),

                  child: Card(
                    elevation: 4.0,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      //
                      // Invoke "debug painting" (press "p" in the console, choose the
                      // "Toggle Debug Paint" action from the Flutter Inspector in Android
                      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                      // to see the wireframe for each widget.
                      //
                      // Column has various properties to control how it sizes itself and
                      // how it positions its children. Here we use mainAxisAlignment to
                      // center the children vertically; the main axis here is the vertical
                      // axis because Columns are vertical (the cross axis would be
                      // horizontal).
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(

                          margin  : const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 25.0),
                            child: TextFormField(
                              validator: (value) => value.trim().isEmpty
                                  ? 'Email can\'t be empty'
                                  : null,
                              onChanged: (value) => email = value.trim(),
                              autofocus: false,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                  hintText: 'Email',
                                  icon: new Icon(
                                    Icons.mail,
                                    color: Colors.grey,
                                  )),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 25.0),
                          child: TextFormField(
                            obscureText: true,
                            autofocus: false,
                            onChanged: (value) => pass = value.trim(),
                            validator: (value) => value.trim().isEmpty
                                ? 'Password can\'t be empty'
                                : null,
                            maxLines: 1,
                            decoration: new InputDecoration(
                                hintText: 'Password',
                                icon: new Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 30),
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () => signInOrUp(),
                              textColor: Colors.white,
                              elevation: 5.0,
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF0D47A1),
                                        Color(0xFF1976D2),
                                        Color(0xFF42A5F5),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: FlatButton(
                                onPressed: () {},
                                textColor: Colors.black,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Not Registere? Sign Up",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ))),
                      ],
                    ),
                  ))),
        ) )// This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
