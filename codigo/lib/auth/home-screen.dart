import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/signUp.dart';
import '../Client/events/client-homepage.dart';
import 'about-us.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/auth/login.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.fromLTRB(0 * fem, 142 * fem, 0 * fem, 0 * fem),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/logo.png',
                width: 200 * fem,
                height: 200 * fem,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    11 * fem, 56 * fem, 18 * fem, 100 * fem),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 11 * fem, 61 * fem),
                        child: Text(
                          'Uma nova maneira de curtir seus eventos.',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            letterSpacing: -0.4099999964 * fem,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: TextButton(
                          onPressed: () => {
                            if (FirebaseAuth.instance.currentUser != null)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ClientHomePage())))
                              }
                            else
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ClientHomePage())))
                              }
                          },
                          child: Center(
                            child: Center(
                              child: Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2 * ffem / fem,
                                  letterSpacing: -0.0099999998 * fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignUp())))
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 18 * fem,
                          child: Center(
                            child: Text(
                              'CADASTRE-SE',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2 * ffem / fem,
                                letterSpacing: -0.0099999998 * fem,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => About())))
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 30 * fem,
                          child: Center(
                            child: Text(
                              'SOBRE NÓS',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.1 * ffem / fem,
                                letterSpacing: -0.0099999998 * fem,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
