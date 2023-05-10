import 'package:flutter/material.dart';
import 'package:myapp/events/homePage.dart';
import 'package:myapp/page-3/qr-generator.dart';
import 'package:myapp/utils.dart';

class EventProfile extends StatelessWidget {
  const EventProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            width: double.infinity,
            height: 896 * fem,
            decoration: const BoxDecoration(
              color: Color(0xfff6f5f5),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0 * fem,
                  top: 2 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 421 * fem,
                      height: 420 * fem,
                      child: Image.asset(
                        'assets/page-2/images/image-3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 187 * fem,
                  top: 258 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 40 * fem,
                      height: 8 * fem,
                      child: Image.asset(
                        'assets/page-2/images/dots.png',
                        width: 40 * fem,
                        height: 8 * fem,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0 * fem,
                  top: 281 * fem,
                  child: Container(
                    width: 414 * fem,
                    height: 615 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xfff6f5f5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30 * fem),
                        topRight: Radius.circular(30 * fem),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20 * fem,
                          top: 16 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 318 * fem,
                              height: 82 * fem,
                              child: Text(
                                'Buteco do Gusttavo Lima',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 30 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3666666667 * ffem / fem,
                                  letterSpacing: 0.4099999964 * fem,
                                  color: const Color(0xff2d0c57),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24 * fem,
                          top: 100 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 146 * fem,
                              height: 22 * fem,
                              child: Text(
                                'Informações:',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1 * ffem / fem,
                                  letterSpacing: -0.4099999964 * fem,
                                  color: const Color(0xff2d0c57),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 37 * fem,
                          top: 378 * fem,
                          child: SizedBox(
                            width: 359 * fem,
                            height: 33 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 60 * fem, 1 * fem),
                                  child: Text(
                                    'Situação do evento:',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Disponível',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff05be77),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 29 * fem,
                          top: 159 * fem,
                          child: SizedBox(
                            width: 359 * fem,
                            height: 26 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 8 * fem, 9 * fem, 7 * fem),
                                  width: 12 * fem,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffc4c4c4),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 11 * fem,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xffc4c4c4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 207 * fem, 0 * fem),
                                  child: Text(
                                    'Data',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w300,
                                      height: 1.2222222222 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                                Text(
                                  '01/04/2023',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff05be77),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 29 * fem,
                          top: 198 * fem,
                          child: SizedBox(
                            width: 363 * fem,
                            height: 26 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 9 * fem, 5 * fem),
                                  width: 12 * fem,
                                  height: 11 * fem,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffc4c4c4),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 186 * fem, 4 * fem),
                                  child: Text(
                                    'Horário',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w300,
                                      height: 1.2222222222 * ffem / fem,
                                      letterSpacing: -0.4099999964 * fem,
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xff2d0c57),
                                    ),
                                  ),
                                ),
                                Text(
                                  '17:00 Horas',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    color: const Color(0xff05be77),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 35 * fem,
                          top: 270 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 357 * fem,
                              height: 51 * fem,
                              child: Text(
                                'Av. Antônio Abrahão Caram, 1001 - São José, Belo Horizonte',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 17 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * ffem / fem,
                                  letterSpacing: -0.4099999964 * fem,
                                  color: const Color(0xff05be77),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 29 * fem,
                          top: 234 * fem,
                          child: SizedBox(
                            width: 104 * fem,
                            height: 22 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 1 * fem, 9 * fem, 0 * fem),
                                  width: 12 * fem,
                                  height: 11 * fem,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffc4c4c4),
                                  ),
                                ),
                                Text(
                                  'Endereço',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2222222222 * ffem / fem,
                                    letterSpacing: -0.4099999964 * fem,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xff2d0c57),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 70 * fem,
                          top: 437 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 273 * fem,
                              height: 20 * fem,
                              child: Text(
                                'O QR Code lido perderá o valor após ser validado.',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 13 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  letterSpacing: -0.4099999964 * fem,
                                  color: const Color(0xffa88686),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 175 * fem,
                          top: 551 * fem,
                          child: Align(
                            child: TextButton(
                              onPressed: () => {
                                /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => HomePage())));*/
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: SizedBox(
                                width: 63 * fem,
                                height: 18 * fem,
                                child: Text(
                                  'VOLTAR',
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
                        Positioned(
                          left: 20 * fem,
                          top: 474 * fem,
                          child: Container(
                            width: 374 * fem,
                            height: 56 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xff0acf83),
                              borderRadius: BorderRadius.circular(8 * fem),
                            ),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            QrCodeGenerator())))
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Center(
                                child: Text(
                                  'LER QR CODE',
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 29 * fem,
                  top: 53 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 6 * fem,
                      height: 12 * fem,
                      child: Image.asset(
                        'assets/page-2/images/vector.png',
                        width: 6 * fem,
                        height: 12 * fem,
                      ),
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
