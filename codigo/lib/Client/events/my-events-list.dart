import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Client/events/client-event-profile.dart';
import 'package:myapp/utils/utils.dart' show SafeGoogleFont;

class ClientMyEventList extends StatefulWidget {
  const ClientMyEventList({Key? key}) : super(key: key);

  @override
  _ClientMyEventListState createState() => _ClientMyEventListState();
}

late final String eventId;

class _ClientMyEventListState extends State<ClientMyEventList> {
  Future<List<Map<String, dynamic>>> getMyEvents() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    String userId = user.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('comprados')
        .get();

    List<String> myEvents = [];
    querySnapshot.docs.forEach((document) {
      myEvents.add(document.id);
    });

    List<Map<String, dynamic>> storedocs = [];
    for (var i = 0; i < myEvents.length; i++) {
      DocumentSnapshot eventSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(myEvents[i])
          .get();

      if (eventSnapshot.exists) {
        Map<String, dynamic> eventData =
            eventSnapshot.data() as Map<String, dynamic>;
        eventData['id'] = myEvents[i];
        storedocs.add(eventData);
      }
    }

    return storedocs;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getMyEvents(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Map<String, dynamic>> storedocs = snapshot.data ?? [];

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
                            builder: (context) => ClientEventProfile(
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
                                          'Roboto',
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
                                            'Roboto',
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
                                          'Roboto',
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
