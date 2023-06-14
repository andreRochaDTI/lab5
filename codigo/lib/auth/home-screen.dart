import 'package:flutter/material.dart';
import 'package:myapp/auth/signUp.dart';
import 'about-us.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/auth/login.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 142, 0, 0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/logo.png',
                width: 200,
                height: 200,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(11, 56, 18, 100),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 11, 61),
                        child: Text(
                          'Uma nova maneira de curtir seus eventos.',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            letterSpacing: -0.4099999964,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
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
                                  'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: -0.0099999998,
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
                          height: 30,
                          child: Center(
                            child: Text(
                              'CADASTRE-SE',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: -0.0099999998,
                                color: Colors.deepPurple,
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
                          height: 30,
                          child: Center(
                            child: Text(
                              'SOBRE NÓS',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                letterSpacing: -0.0099999998,
                                color: Colors.deepPurple,
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
