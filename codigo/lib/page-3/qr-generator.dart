import 'package:flutter/material.dart';
import 'package:myapp/events/event-profile.dart';

class QrCodeGenerator extends StatelessWidget {
  const QrCodeGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff000000),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => EventProfile())))
                },
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 40 * fem, 0 * fem, 0 * fem),
                  width: 20 * fem,
                  height: 20 * fem,
                  child: Image.asset(
                    'assets/page-3/images/vector-white.png',
                    width: 20 * fem,
                    height: 20 * fem,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    50 * fem, 150 * fem, 50 * fem, 50 * fem),
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
