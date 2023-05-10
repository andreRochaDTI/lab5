import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/events/update-event-list.dart';

import '../utils.dart';

class ListEvents extends StatefulWidget {
  ListEvents({Key? key}) : super(key: key);

  set _filteredEvents(List<ListEvents> _filteredEvents) {}

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<ListEvents> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  // For Deleting User
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  Future<void> deleteEvent(id) {
    // print("User Deleted $id");
    return events
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

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
          print('Something went Wrong');
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

        void undoDeleteEvent() {
          if (deletedEvent != null) {
            events
                .doc(deletedEvent!['id'])
                .set(deletedEvent!)
                .then((value) => print('Event Restored'))
                .catchError(
                    (error) => print('Failed to Restore event: $error'));
            deletedEvent = null;
          }
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 444),
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
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 16 * fem, 54 * fem, 16 * fem),
                          height: 160 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TableCell(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                  width: 180 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffdbd8dd),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 177 * fem,
                                      height: 128 * fem,
                                      child: SizedBox(
                                        width: 177 * fem,
                                        height: 128 * fem,
                                        child: Image.network(
                                          storedocs[i]['image'] ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 30 * fem, 0 * fem),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 15 * fem),
                                    width: 153 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              fontWeight: FontWeight.w300,
                                              height: 0.9166666667 * ffem / fem,
                                              letterSpacing:
                                                  -0.4099999964 * fem,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0 * fem,
                                                5 * fem,
                                                0 * fem,
                                                0 * fem),
                                            child: Text(
                                              storedocs[i]['address'],
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: SafeGoogleFont(
                                                'Montserrat',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.375 * ffem / fem,
                                                letterSpacing:
                                                    -0.4099999964 * fem,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  width: 31 * fem,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.green,
                                        iconSize: 30 * ffem,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateEvent(
                                                id: storedocs[i]['id'],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        iconSize: 30 * ffem,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Deletar evento'),
                                                content: const Text(
                                                    'Tem certeza que deseja deletar este evento?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text('Cancelar'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text('Deletar'),
                                                    onPressed: () {
                                                      deletedEvent =
                                                          storedocs[i];
                                                      deleteEvent(
                                                          storedocs[i]['id']);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
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
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
