import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/Pages/Register.dart';
import 'package:telegram/Pages/chaqiruvlar.dart';
import 'package:telegram/Pages/hamyon.dart';
import 'package:telegram/Pages/kontaklar.dart';
import 'package:telegram/Pages/profile.dart';
import 'package:telegram/Pages/saqlangan_xabarlar.dart';
import 'package:telegram/Pages/search.dart';
import 'package:telegram/Pages/tanishlarni_taklif_qilish.dart';
import 'package:telegram/Pages/telegram_funksiyalari.dart';
import 'package:telegram/Pages/yangi_guruh.dart';
import 'package:telegram/auth_service.dart';
import 'package:telegram/chat_page.dart';
import 'package:telegram/chat_service.dart';
import 'package:telegram/my_usertile.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({
    super.key,
    required this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSwitcher();
  }

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  bool isSwitched = false;

  void changeSwitcher() async {
    final miya = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = miya.getBool("isLight") ?? false;
    });
  }

  void logout(){
    AuthService authService = AuthService();
    authService.logout();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDeHNu6C23GF0pYJyjZZk68H2PF3csWK95vrpp_xbSl1iYLVDeCNJaBc0&s"),
                    radius: 50,
                  ),
                    accountName: Text("Elshodbek"),
                    accountEmail: Text("elshodbek@gmail.com")
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_outline_outlined,
                  ),
                  title: Text(
                    "Profilim",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => ProfilePage())
                    );
                  }
                ),
                ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet_outlined,
                    ),
                    title: Text(
                      "Hamyon",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => Hamyon())
                      );
                    }
                ),
                Divider(),
                ListTile(
                    leading: Icon(
                      Icons.people_alt_outlined,
                    ),
                    title: Text(
                      "Yangi guruh yaratish",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => YangiGuruh())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.contact_page_outlined,
                    ),
                    title: const Text(
                      "Kontaktlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => Kontaklar())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.phone_outlined,
                    ),
                    title: Text(
                      "Chaqiruvlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => Chaqiruvlar())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.bookmark_border_rounded,
                    ),
                    title: Text(
                      "Saqlangan xabarlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => SaqlanganXabarlar())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.settings_outlined,
                    ),
                    title: const Text(
                      "Sozlamalar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    }
                ),
                Divider(),
                ListTile(
                    leading: Icon(
                      Icons.person_add_outlined,
                    ),
                    title: Text(
                      "Tanishlarni taklif qilish",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => TanishlarniTaklifQilish())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.question_mark_outlined,
                    ),
                    title: Text(
                      "Telegram funksiyalari",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => TelegramFunksiyalari())
                      );
                    }
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          title: Text(
              "Telegram"
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SearchPage())
                  );
                }, 
                label: Text(""),
              icon: Icon(Icons.search_outlined),
            )
          ],
        ),

        body: _usersList()

    );
  }

  Widget _usersList(){
    return StreamBuilder(
        stream: _chatService.getAllUsers(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Nimadir xatolik ketti");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading...");
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _userListItem(userData, context))
                .toList(),
          );
        }
    );
  }

  Widget _userListItem(Map<String, dynamic> userData, BuildContext context){

    bool isCurrentUser = userData["uid"] == _authService.getCurrentUser()!.uid;

    if(isCurrentUser == false){
      return MyUsertile(
          text: userData["email"],
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                      recieverEmail: userData["email"],
                      recieverID: userData["uid"],
                    )
                )
            );
          }
      );
    }
    return Container();
  }
}