import 'package:flutter/material.dart';
import 'package:telegram/Pages/Home.dart';
import 'package:telegram/Pages/Register.dart';
import 'package:telegram/auth_service.dart';
import 'package:telegram/my_button.dart';
import 'package:telegram/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber, color: Colors.red),
        title: const Text("Xatolik"),
        content: Text(message),
      ),
    );
  }


  void login() async {
    try {
      AuthService authService = AuthService();
      final credential = await authService.login(
        _emailController.text.trim(),
        _pwController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
              user: credential.user!
          ),
        ),
      );
    } catch (e) {
      showError(context, e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // logo
          Icon(
            Icons.restart_alt_outlined,
            size: 100,
            color: Colors.blueAccent
          ),

          SizedBox(height: 50,),
          Text(
            "Qaytib kelganingizdan xursandmiz",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25,),
          MyTextfield(
            hinText: 'Email kiriting...',
            controller: _emailController,
            isObscure: false,
            prefixIcon: Icon(Icons.email_outlined),
          ),
          MyTextfield(
            hinText: 'Parol kiriting...',
            controller: _pwController,
            isObscure: true,
            prefixIcon: Icon(Icons.lock_outline_rounded),
          ),
          SizedBox(height: 20,),
          MyButton(
            text: "Kirish",
            onTap: login,
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Account yo'qmi?",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage()
                      )
                  );
                },
                child: Text(
                  "Yangi hisob yarating",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}