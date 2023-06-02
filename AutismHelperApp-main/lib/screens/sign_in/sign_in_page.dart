import 'package:autism_helper_project/Services/auth.dart';
import 'package:autism_helper_project/screens/sign_in/forget_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_widgets/buttons/raised_button.dart';
import '../common_widgets/show_alert_dialog.dart';
import 'sign_up_page.dart';
import 'validator.dart';

class SignInPage extends StatefulWidget with EmailAndPasswordValidators {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset('images/title.jpg', scale: 18)),
        elevation: 10.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              logoBox(),
              const SizedBox(height: 15),
              welcomeBackText(),
              const SizedBox(height: 10),
              logInToYourAccountText(),
              const SizedBox(height: 10),
              buildEmailCard(context),
              const SizedBox(height: 10),
              buildPasswordCard(),
              const SizedBox(height: 15),
              CustomRaisedButton(
                child: signInButtonLabel(),
                onPressed: () {
                  _signInButton(context);
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              forgetPassword(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: signUpRowChildren(context),
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }

  SizedBox logoBox() {
    return SizedBox(
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Text welcomeBackText() {
    return const Text(
      'Welcome Back!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 25.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Text logInToYourAccountText() {
    return const Text(
      'Login to your account',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  void _emailEditingComplete(BuildContext context) {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  Card buildEmailCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextField(
          controller: _emailController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          onEditingComplete: () {
            _emailEditingComplete(context);
          },
        ),
      ),
    );
  }

  Card buildPasswordCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextField(
          controller: _passwordController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
          ),
          obscureText: true,
          focusNode: _passwordFocusNode,
        ),
      ),
    );
  }

  Text signInButtonLabel() {
    return const Text(
      'Sign in',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Future<void> _signInButton(BuildContext context) async {
    final AuthBase? auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth?.signInWithEmailAndPassword(_email, _password);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context,
        content: e.message,
        title: "Sign in failed",
        cancelActionText: "",
        defaultActionText: "OK",
      );
    }
  }

  List<Widget> signUpRowChildren(BuildContext context) {
    return [
      const Text(
        'Don\'t have an account? ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      GestureDetector(
          onTap: () => _signUpButton(context),
          child: const Text(
            ' Sign Up here',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline),
          )),
    ];
  }





  void _signUpButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => SignUpPage(),
      ),
    );
  }

  GestureDetector forgetPassword() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const ForgetPasswordPage()));
        },
        child: const Text(
          'Forget Password?',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.underline),
        ));
  }
}
