import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:myapp/utils/utils.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 94 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xfff6f5f5),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 338 * fem,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * ffem / fem,
                        letterSpacing: -0.4099999964 * fem,
                        color: const Color(0xff2d0c57),
                      ),
                      children: [
                        TextSpan(
                          text: 'Seja bem-vindo ao E-vento!',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.0625 * ffem / fem,
                            letterSpacing: -0.4099999964 * fem,
                            color: const Color(0xff2d0c57),
                          ),
                        ),
                        TextSpan(
                          text: ' \n',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.0625 * ffem / fem,
                            letterSpacing: -0.4099999964 * fem,
                            color: const Color(0xff2d0c57),
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            letterSpacing: -0.4099999964 * fem,
                            color: const Color(0xff2d0c57),
                          ),
                        ),
                        TextSpan(
                          text:
                              'Com nosso aplicativo fácil de usar, você pode descobrir as melhores festas que estão acontecendo na sua cidade e na região, e também pode criar suas próprias festas para compartilhar com seus amigos.\n\nNosso aplicativo permite que você explore eventos e festas de vários tipos e estilos, desde festas de aniversário e casamentos até festas temáticas, festivais e shows. Você pode acompanhar as atualizações dos eventos que você está interessado, incluindo informações sobre datas, horários, preços, localização e detalhes sobre a festa. Aproveite!',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 2 * ffem / fem,
                            letterSpacing: -0.4099999964 * fem,
                            color: const Color(0xff2d0c57),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
