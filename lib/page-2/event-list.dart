import 'package:flutter/material.dart';
import 'package:myapp/page-2/event-profile.dart';
import 'package:myapp/utils.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xfff6f5f5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 20 * fem),
                                width: 6 * fem,
                                height: 12 * fem,
                                child: Image.asset(
                                  'assets/page-2/images/vector.png',
                                  width: 6 * fem,
                                  height: 12 * fem,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    32 * fem, 0 * fem, 0 * fem, 0 * fem),
                                padding: EdgeInsets.fromLTRB(21.06 * fem,
                                    9 * fem, 125.78 * fem, 5 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffd8d0e3)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(
                                      27.0000038147 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 16 * fem, 4 * fem),
                                      width: 15.16 * fem,
                                      height: 13.5 * fem,
                                      child: Image.asset(
                                        'assets/page-2/images/icon-search.png',
                                        width: 15.16 * fem,
                                        height: 13.5 * fem,
                                      ),
                                    ),
                                    Text(
                                      'Procurar eventos\n',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 17 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2941176471 * ffem / fem,
                                        letterSpacing: -0.4099999964 * fem,
                                        color: const Color(0xff9586a8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 1 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            29.26 * fem, 0 * fem, 42 * fem, 0 * fem),
                        width: double.infinity,
                        height: 29 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 3.74 * fem, 0 * fem),
                              child: Text(
                                'Esses são os seus eventos: ',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.7951389949 * ffem / fem,
                                  letterSpacing: -0.8029167056 * fem,
                                  color: const Color(0xff9586a8),
                                ),
                              ),
                            ),
                            Text(
                              '(4)',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 32 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3463542461 * ffem / fem,
                                letterSpacing: -0.8029167056 * fem,
                                color: const Color(0xff2d0c57),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 16 * fem, 54 * fem, 16 * fem),
                width: double.infinity,
                height: 160 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 10 * fem, 0 * fem),
                      width: 177 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffdbd8dd),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 177 * fem,
                          height: 128 * fem,
                          child: Image.asset(
                            'assets/page-2/images/image-2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 23 * fem),
                      width: 153 * fem,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 153 * fem,
                              ),
                              child: Text(
                                'Calourada de medicina',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w300,
                                  height: 0.9166666667 * ffem / fem,
                                  letterSpacing: -0.4099999964 * fem,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xff2d0c57),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 23 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Av. Brasil, 3000',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.375 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff9586a8),
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
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                padding: EdgeInsets.fromLTRB(
                    20 * fem, 16 * fem, 32.5 * fem, 16 * fem),
                width: double.infinity,
                height: 160 * fem,
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EventProfile())))
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        width: 177 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffdbd8dd),
                          borderRadius: BorderRadius.circular(8 * fem),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 177 * fem,
                            height: 128 * fem,
                            child: Image.asset(
                              'assets/page-2/images/image-3.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 42 * fem),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                constraints: BoxConstraints(
                                  maxWidth: 167 * fem,
                                ),
                                child: Text(
                                  'Buteco do Gusttavo Lima',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 0.9166666667 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xff2d0c57),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0.5 * fem, 0 * fem, 0 * fem, 0 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    0 * fem, 11 * fem, 0 * fem, 0 * fem),
                                width: 174 * fem,
                                child: Center(
                                  child: Text(
                                    'Esplanada do Mineirão',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.375 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      color: const Color(0xff9586a8),
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
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 16 * fem, 31 * fem, 16 * fem),
                width: double.infinity,
                height: 160 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 7 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 1 * fem, 0 * fem, 2 * fem),
                      width: 177 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffdbd8dd),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 174 * fem,
                          height: 125 * fem,
                          child: Image.asset(
                            'assets/page-2/images/image-4.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 7 * fem, 0 * fem, 13 * fem),
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 24 * fem),
                              child: Text(
                                'Tardezinha',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w300,
                                  height: 0.9166666667 * ffem / fem,
                                  letterSpacing: -0.4099999964 * fem,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xff2d0c57),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 13 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 5 * fem, 0 * fem, 0 * fem),
                              child: Center(
                                child: Text(
                                  'Esplanada do mineirão',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.375 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff9586a8),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  34 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 36 * fem,
                              height: 22 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 16 * fem, 52 * fem, 12 * fem),
                width: double.infinity,
                height: 160 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 7 * fem, 0 * fem),
                      width: 177 * fem,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 177 * fem,
                                height: 128 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                    color: const Color(0xffdbd8dd),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 3 * fem,
                            top: 2 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 173 * fem,
                                height: 130 * fem,
                                child: Image.asset(
                                  'assets/page-2/images/image-5.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 34 * fem),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hackatruck',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w300,
                                height: 0.9166666667 * ffem / fem,
                                letterSpacing: -0.4099999964 * fem,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xff2d0c57),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 155 * fem,
                              height: 62 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 13 * fem,
                                    top: 0 * fem,
                                    child: SizedBox(
                                      width: 36 * fem,
                                      height: 29 * fem,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0 * fem,
                                    top: 18 * fem,
                                    child: Center(
                                      child: Align(
                                        child: SizedBox(
                                          width: 155 * fem,
                                          height: 44 * fem,
                                          child: Text(
                                            'Puc Minas - Coração Eucarístico',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Montserrat',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.375 * ffem / fem,
                                              letterSpacing:
                                                  -0.4099999964 * fem,
                                              color: const Color(0xff9586a8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
