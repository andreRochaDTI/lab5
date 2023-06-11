import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/main.dart';
import 'package:page_transition/page_transition.dart';

import 'package:myapp/utils.dart' show SafeGoogleFont;

class ListEvents extends StatefulWidget {
  const ListEvents({Key? key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<ListEvents> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? deletedEvent;

    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return StreamBuilder<QuerySnapshot>(
      stream: studentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map item = document.data() as Map<String, dynamic>;
          storedocs.add(item);
          item['id'] = document.id;
        }).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Table(
            border: TableBorder.all(color: Colors.transparent),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(child: Container()),
                ],
              ),
              for (var i = 0; i < storedocs.length; i++) ...[
                TableRow(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventP(
                              id: storedocs[i]['id'],
                              indice: i,
                              storedocs: storedocs,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 8 * fem),
                        padding: EdgeInsets.fromLTRB(
                            10 * fem, 16 * fem, 10 * fem, 16 * fem),
                        height: 160 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 10 * fem, 0 * fem),
                              width: 180 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffdbd8dd),
                                borderRadius: BorderRadius.circular(8 * fem),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8 * fem),
                                child: Image.network(
                                  storedocs[i]['image'] ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 10 * fem, 0 * fem),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 15 * fem),
                                width: 153 * fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 380 * fem,
                                      ),
                                      child: Text(
                                        storedocs[i]['name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: SafeGoogleFont(
                                          'Montserrat',
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 0.9166666667 * ffem / fem,
                                          letterSpacing: -0.4099999964 * fem,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 5 * fem, 0 * fem, 0 * fem),
                                        child: Text(
                                          storedocs[i]['address'],
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.375 * ffem / fem,
                                            letterSpacing: -0.4099999964 * fem,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 380 * fem,
                                      ),
                                      child: Text(
                                        storedocs[i]['date'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: SafeGoogleFont(
                                          'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          height: 0.9166666667 * ffem / fem,
                                          letterSpacing: 1 * fem,
                                          color: Colors.deepPurple,
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
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
