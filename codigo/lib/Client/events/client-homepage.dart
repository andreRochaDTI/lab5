import 'package:flutter/material.dart';
import 'package:myapp/Client/events/my-events.dart';
import 'package:myapp/Client/profile/client-profile.dart';
import 'package:myapp/Client/events/listEvents.dart';
import 'package:myapp/Client/utils/maps.dart';
import 'package:myapp/utils/utils.dart';

class ClientHomePage extends StatefulWidget {
  ClientHomePage({Key? key}) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

final TextEditingController _searchController = TextEditingController();

class _ClientHomePageState extends State<ClientHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientHomePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.map, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClientMapPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientProfilePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.event, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyEvents()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfff6f5f5),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(18, 0, 49, 20),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 40.0,
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 1.0,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (text) {},
                                  decoration: const InputDecoration(
                                    hintText: "Informe o nome do evento",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                    icon:
                                        Icon(Icons.search, color: Colors.white),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                width: double.infinity,
                                height: 34,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Eventos disponíveis: ',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        height: 1.7,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
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
              const ClientEventList(),
            ],
          ),
        ),
      ),
    );
  }
}
