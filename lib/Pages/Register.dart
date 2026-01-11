import 'package:flutter/material.dart';
import 'package:telegram/Pages/Home.dart';
import 'package:telegram/auth_service.dart';
import 'package:telegram/login_page.dart';
import 'package:telegram/my_button.dart';
import 'package:telegram/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmController = TextEditingController();

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


  void register() async {
    if (_pwController.text != _pwConfirmController.text) {
      showError(context, "Parollar mos kelmadi");
      return;
    }

    try {
      AuthService authService = AuthService();
      final credential = await authService.register(
        _emailController.text.trim(),
        _pwController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: credential.user!,
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
          Icon(
            Icons.telegram_outlined,
            size: 100,
            color: Colors.blueAccent
          ),

          SizedBox(height: 50,),

          Text(
            "Telegramga xush kelibsiz",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 25,),

          // email - TextField
          MyTextfield(
            hinText: 'Email kiriting...',
            controller: _emailController,
            isObscure: false,
            prefixIcon: Icon(Icons.email_outlined),
          ),
          MyTextfield(
            hinText: 'Parol yarating...',
            controller: _pwController,
            isObscure: true,
            prefixIcon: Icon(Icons.lock_outline_rounded),
          ),

          MyTextfield(
            hinText: 'Parolni qayta kiriting...',
            controller: _pwConfirmController,
            isObscure: true,
            prefixIcon: Icon(Icons.lock_outline_rounded),
          ),

          SizedBox(height: 20,),

          // login -> Elevated Button
          MyButton(
            text: "Hisob Yaratish",
            onTap: register,
          ),

          SizedBox(height: 25,),

          // register qiling -> Elevated Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Account bormi?",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      )
                  );
                },
                child: Text(
                  "Login'ga o'ting",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
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