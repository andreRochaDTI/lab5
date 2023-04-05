import 'package:flutter/material.dart';
import 'package:myapp/utils.dart' show SafeGoogleFont;
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/register.dart';

import 'about-us.dart';

class Homepage extends StatelessWidget {
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
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff000000)),
          color: const Color(0xffa259ff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3f000000),
              offset: Offset(0 * fem, 4 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 107 * fem),
                width: 63 * fem,
                height: 63 * fem,
                child: Image.asset(
                  'assets/page-1/images/logo.png',
                  width: 63 * fem,
                  height: 63 * fem,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    11 * fem, 56 * fem, 18 * fem, 100 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfff6f5f5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30 * fem),
                    topRight: Radius.circular(30 * fem),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              11 * fem, 0 * fem, 0 * fem, 48 * fem),
                          child: Text(
                            'E-vento',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Montserrat',
                              fontSize: 34 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2058823529 * ffem / fem,
                              letterSpacing: 0.4099999964 * fem,
                              color: const Color(0xff2d0c57),
                            ),
                          ),
                        ),
                      ),
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
                            color: const Color(0xff9586a8),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff0bce83),
                          borderRadius: BorderRadius.circular(8 * fem),
                        ),
                        child: TextButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Login())))
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
                                  builder: ((context) => Register())))
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
                                color: const Color(0xff9586a8),
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
                                  builder: ((context) => About())))
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 18 * fem,
                          child: Center(
                            child: Text(
                              'SOBRE NÓS',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.1 * ffem / fem,
                                letterSpacing: -0.0099999998 * fem,
                                color: const Color(0xff9586a8),
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
