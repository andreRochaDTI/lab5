import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 94*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xfff6f5f5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(21*fem, 62*fem, 21*fem, 22*fem),
                width: double.infinity,
                height: 96*fem,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 6*fem,
                    height: 12*fem,
                    child: Image.asset(
                      'assets/page-3/images/vector-Dwh.png',
                      width: 6*fem,
                      height: 12*fem,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints (
                  maxWidth: 338*fem,
                ),
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont (
                      'Montserrat',
                      fontSize: 17*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5*ffem/fem,
                      letterSpacing: -0.4099999964*fem,
                      color: Color(0xff2d0c57),
                    ),
                    children: [
                      TextSpan(
                        text: 'Seja bem-vindo ao E-vento!',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 24*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.0625*ffem/fem,
                          letterSpacing: -0.4099999964*fem,
                          color: Color(0xff2d0c57),
                        ),
                      ),
                      TextSpan(
                        text: ' \n',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 24*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.0625*ffem/fem,
                          letterSpacing: -0.4099999964*fem,
                          color: Color(0xff2d0c57),
                        ),
                      ),
                      TextSpan(
                        text: '\n',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5*ffem/fem,
                          letterSpacing: -0.4099999964*fem,
                          color: Color(0xff2d0c57),
                        ),
                      ),
                      TextSpan(
                        text: 'Com nosso aplicativo fácil de usar, você pode descobrir as melhores festas que estão acontecendo na sua cidade e na região, e também pode criar suas próprias festas para compartilhar com seus amigos.\n\n\n\nNosso aplicativo permite que você explore eventos e festas de vários tipos e estilos, desde festas de aniversário e casamentos até festas temáticas, festivais e shows. \n\n\n\nCom o nosso aplicativo, você pode acompanhar as atualizações dos eventos que você está interessado, incluindo informações sobre datas, horários, preços, localização e detalhes sobre a festa. Aproveite!',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 17*ffem,
                          fontWeight: FontWeight.w400,
                          height: 2*ffem/fem,
                          letterSpacing: -0.4099999964*fem,
                          color: Color(0xff2d0c57),
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