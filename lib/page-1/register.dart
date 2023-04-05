import 'package:flutter/material.dart';
import 'package:myapp/page-1/homepage.dart';
import 'package:myapp/utils.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration (
          color: Color(0xfff6f5f5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                padding: EdgeInsets.fromLTRB(21*fem, 62*fem, 21*fem, 22*fem),
                width: double.infinity,
                decoration: BoxDecoration (
                  color: const Color(0xfff6f5f5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x02000000),
                      offset: Offset(0*fem, 4*fem),
                      blurRadius: 9*fem,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 6*fem,
                    height: 12*fem,
                    child: Image.asset(
                      'assets/page-1/images/vector-qNb.png',
                      width: 6*fem,
                      height: 12*fem,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 229*fem, 44*fem),
                child: Text(
                  'Cadastro',
                  style: SafeGoogleFont (
                    'Montserrat',
                    fontSize: 30*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3666666667*ffem/fem,
                    letterSpacing: 0.4099999964*fem,
                    color: const Color(0xff2d0c57),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                width: 34*fem,
                height: 29*fem,
                child: Image.asset(
                  'assets/page-1/images/take-a-photo-icon.png',
                  width: 34*fem,
                  height: 29*fem,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(14*fem, 34*fem, 20*fem, 105*fem),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 0*fem, 34*fem),
                        width: 374*fem,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 0*fem, 0*fem),
                                width: 45*fem,
                                height: 22*fem,
                                child: Center(
                                  child: Text(
                                    'NOME',
                                    style: SafeGoogleFont (
                                      'Montserrat',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5714285714*ffem/fem,
                                      letterSpacing: -0.4099999964*fem,
                                      color: const Color(0xff9586a8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(13*fem, 13*fem, 13*fem, 13*fem),
                                width: double.infinity,
                                height: 48*fem,
                                decoration: BoxDecoration (
                                  border: Border.all(color: const Color(0xffd8d0e3)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8*fem),
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 296*fem, 0*fem),
                                  width: 52*fem,
                                  height: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'Nome',
                                      style: SafeGoogleFont (
                                        'Montserrat',
                                        fontSize: 17*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2941176471*ffem/fem,
                                        letterSpacing: -0.4099999964*fem,
                                        color: const Color(0xff2d0c57),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(4*fem, 0*fem, 0*fem, 16*fem),
                        width: 374*fem,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 0*fem, 0*fem),
                                width: 44*fem,
                                height: 22*fem,
                                child: Center(
                                  child: Text(
                                    'EMAIL',
                                    style: SafeGoogleFont (
                                      'Montserrat',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5714285714*ffem/fem,
                                      letterSpacing: -0.4099999964*fem,
                                      color: const Color(0xff9586a8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(13*fem, 13*fem, 13*fem, 13*fem),
                                width: double.infinity,
                                height: 48*fem,
                                decoration: BoxDecoration (
                                  border: Border.all(color: const Color(0xffd8d0e3)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(8*fem),
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 179*fem, 0*fem),
                                  width: 169*fem,
                                  height: double.infinity,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'email@email.com.br',
                                        style: SafeGoogleFont (
                                          'Montserrat',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2941176471*ffem/fem,
                                          letterSpacing: -0.4099999964*fem,
                                          color: const Color(0xff2d0c57),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(9*fem, 0*fem, 0*fem, 23*fem),
                        width: 369*fem,
                        height: 69*fem,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0*fem,
                              top: 21*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 369*fem,
                                  height: 48*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(8*fem),
                                      border: Border.all(color: const Color(0xffd8d0e3)),
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 13*fem,
                              top: 35*fem,
                              child: SizedBox(
                                width: 46*fem,
                                height: 22*fem,
                                child: Center(
                                  child: Text(
                                    '*******',
                                    style: SafeGoogleFont (
                                      'Montserrat',
                                      fontSize: 17*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2941176471*ffem/fem,
                                      letterSpacing: -0.4099999964*fem,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14*fem,
                              top: 0*fem,
                              child: SizedBox(
                                width: 50*fem,
                                height: 22*fem,
                                child: Center(
                                  child: Text(
                                    'SENHA',
                                    style: SafeGoogleFont (
                                      'Montserrat',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5714285714*ffem/fem,
                                      letterSpacing: -0.4099999964*fem,
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
                        margin: EdgeInsets.fromLTRB(9*fem, 0*fem, 0*fem, 34*fem),
                        width: 369*fem,
                        height: 70*fem,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0*fem,
                              top: 11*fem,
                              child: SizedBox(
                                width: 369*fem,
                                height: 59*fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0*fem,
                                      top: 11*fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 369*fem,
                                          height: 48*fem,
                                          child: Container(
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(8*fem),
                                              border: Border.all(color: const Color(0xffd8d0e3)),
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 14*fem,
                                      top: 24*fem,
                                      child: SizedBox(
                                        width: 46*fem,
                                        height: 22*fem,
                                        child: Center(
                                          child: Text(
                                            '*******',
                                            style: SafeGoogleFont (
                                              'Montserrat',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2941176471*ffem/fem,
                                              letterSpacing: -0.4099999964*fem,
                                              color: const Color(0xff2d0c57),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 14*fem,
                                      top: 0*fem,
                                      child: SizedBox(
                                        width: 160*fem,
                                        height: 22*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 160*fem,
                                  height: 22*fem,
                                  child: Text(
                                    'CONFIRME SUA SENHA',
                                    style: SafeGoogleFont (
                                      'Montserrat',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5714285714*ffem/fem,
                                      letterSpacing: -0.4099999964*fem,
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
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 86*fem),
                        width: 374*fem,
                        height: 56*fem,
                        decoration: BoxDecoration (
                          color: const Color(0xff0acf83),
                          borderRadius: BorderRadius.circular(8*fem),
                        ),
                        child: Center(
                          child: Text(
                            'CONFIRMAR',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Montserrat',
                              fontSize: 15*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2*ffem/fem,
                              letterSpacing: -0.0099999998*fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 0*fem, 0*fem),
                                              child: TextButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Homepage())))
                            },
                        child: Text(
                          'VOLTAR',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Montserrat',
                            fontSize: 15*ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2*ffem/fem,
                            letterSpacing: -0.0099999998*fem,
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
          );
  }
}