import 'package:flutter/material.dart';
import 'package:myapp/page-1/register.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-2/event-list.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.fromLTRB(0 * fem, 9 * fem, 0 * fem, 0 * fem),
        width: double.infinity,
        height: 896 * fem,
        child: Container(
          padding: EdgeInsets.fromLTRB(0 * fem, 142 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          height: 896 * fem,
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
                      22 * fem, 56 * fem, 18 * fem, 100 * fem),
                  width: double.infinity,
                  height: 584 * fem,
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
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                2 * fem, 0 * fem, 3 * fem, 18 * fem),
                            width: double.infinity,
                            height: 125 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 22 * fem,
                                  top: 0 * fem,
                                  child: Center(
                                    child: Align(
                                      child: SizedBox(
                                        width: 326 * fem,
                                        height: 80 * fem,
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
                                  ),
                                ),
                                Positioned(
                                  left: 0 * fem,
                                  top: 56 * fem,
                                  child: SizedBox(
                                    width: 369 * fem,
                                    height: 69 * fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0 * fem,
                                          top: 21 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 369 * fem,
                                              height: 48 * fem,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8 * fem),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffd8d0e3)),
                                                  color: const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 13 * fem,
                                          top: 35 * fem,
                                          child: SizedBox(
                                            width: 46 * fem,
                                            height: 22 * fem,
                                            child: Center(
                                              child: Text(
                                                '*******',
                                                style: SafeGoogleFont(
                                                  'Montserrat',
                                                  fontSize: 17 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.2941176471 * ffem / fem,
                                                  letterSpacing:
                                                      -0.4099999964 * fem,
                                                  color: const Color(0xff2d0c57),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 14 * fem,
                                          top: 0 * fem,
                                          child: SizedBox(
                                            width: 41 * fem,
                                            height: 22 * fem,
                                            child: Center(
                                              child: Text(
                                                'Login:',
                                                style: SafeGoogleFont(
                                                  'Montserrat',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.5714285714 * ffem / fem,
                                                  letterSpacing:
                                                      -0.4099999964 * fem,
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
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5 * fem, 56 * fem),
                            width: 369 * fem,
                            height: 69 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0 * fem,
                                  top: 21 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 369 * fem,
                                      height: 48 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          border: Border.all(
                                              color: const Color(0xffd8d0e3)),
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13 * fem,
                                  top: 35 * fem,
                                  child: SizedBox(
                                    width: 46 * fem,
                                    height: 22 * fem,
                                    child: Center(
                                      child: Text(
                                        '*******',
                                        style: SafeGoogleFont(
                                          'Montserrat',
                                          fontSize: 17 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2941176471 * ffem / fem,
                                          letterSpacing: -0.4099999964 * fem,
                                          color: const Color(0xff2d0c57),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 14 * fem,
                                  top: 0 * fem,
                                  child: SizedBox(
                                    width: 46 * fem,
                                    height: 22 * fem,
                                    child: Center(
                                      child: Text(
                                        'Senha:',
                                        style: SafeGoogleFont(
                                          'Montserrat',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5714285714 * ffem / fem,
                                          letterSpacing: -0.4099999964 * fem,
                                          color: const Color(0xff9586a8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 86 * fem),
                            width: double.infinity,
                            height: 56 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xff0bce83),
                              borderRadius: BorderRadius.circular(8 * fem),
                            ),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const EventList())))
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
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                121 * fem, 0 * fem, 142 * fem, 0 * fem),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 18 * fem,
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Register())))
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
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
      ),
    );
  }
}
