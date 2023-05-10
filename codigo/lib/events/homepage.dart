import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/events/addEvent.dart';
import 'package:myapp/events/listEvents.dart';

import '../auth/home-screen.dart';
import '../utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final TextEditingController _searchController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
            title: const Text("E-vento"),
            centerTitle: true,
            backgroundColor: const Color(0xff9586a8)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEvent(),
              ),
            );
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xfff6f5f5),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 30 * fem, 350 * fem, 0 * fem),
                  width: 40 * fem,
                  height: 40 * fem,
                  child: Image.asset(
                    'assets/page-2/images/menu-navigation.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(350 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: 40 * fem,
                  height: 40 * fem,
                  child: TextButton(
                    onPressed: () async => {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sair'),
                            content: const Text(
                                'Tem certeza que deseja desconctar sua conta?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Sair'),
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) {});
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Login())));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    },
                    child: Image.asset(
                      'assets/page-2/images/logout.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Bem Vindo ',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Montserrat',
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.7951389949 * ffem / fem,
                    letterSpacing: -0.8029167056 * fem,
                    color: const Color(0xff9586a8),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.fromLTRB(0 * fem, 16 * fem, 0 * fem, 8 * fem),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              18 * fem, 0 * fem, 49 * fem, 20 * fem),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged: (text) {},
                                        decoration: const InputDecoration(
                                            labelText: "Buscar eventos",
                                            hintText:
                                                "Informe o nome do evento",
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)))),
                                      ),
                                    ),
                                    const Divider(),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 34 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Esses são os seus eventos: ',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Montserrat',
                                              fontSize: 25 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.7951389949 * ffem / fem,
                                              letterSpacing:
                                                  -0.8029167056 * fem,
                                              color: const Color(0xff9586a8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListEvents()
              ],
            ),
          ),
        ));
  }
}
