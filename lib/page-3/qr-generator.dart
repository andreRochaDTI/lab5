import 'package:flutter/material.dart';

class QrCodeGenerator extends StatelessWidget {
  const QrCodeGenerator({super.key});

  @override

  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.fromLTRB(32 * fem, 48 * fem, 32 * fem, 311 * fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff000000),
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 210 * fem),
                  width: 27 * fem,
                  height: 54 * fem,
                  child: Image.asset(
                    'assets/page-3/images/vector-white.png',
                    width: 27 * fem,
                    height: 54 * fem,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(52 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: 247 * fem,
                  height: 273 * fem,
                  child: Image.asset(
                    'assets/page-3/images/image-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
