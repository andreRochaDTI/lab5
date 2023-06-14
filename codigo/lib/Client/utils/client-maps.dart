import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:myapp/Admin/events/admin-homepage.dart';
import 'package:myapp/Admin/profile/profile.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/Client/events/my-events.dart';
import 'package:myapp/Client/profile/client-profile.dart';

class ClientMapPage extends StatefulWidget {
  final String? targetAddress;

  const ClientMapPage({Key? key, this.targetAddress}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<ClientMapPage> {
  location.LocationData? _currentLocation;
  final location.Location _location = location.Location();
  String? _targetAddress;

  @override
  void initState() {
    super.initState();
    _targetAddress = widget.targetAddress;
    _getLocation();
  }

  Future<void> _getLocation() async {
    if (_targetAddress == null) {
      location.LocationData? locationData;
      try {
        locationData = await _location.getLocation();
      } catch (e) {
        locationData = null;
      }

      if (!mounted) return;

      setState(() {
        _currentLocation = locationData;
      });
    } else {
      List<Location> locations = await locationFromAddress(_targetAddress!);
      if (locations.isNotEmpty) {
        final latitude = locations.first.latitude;
        final longitude = locations.first.longitude;
        setState(() {
          _currentLocation = location.LocationData.fromMap({
            'latitude': latitude,
            'longitude': longitude,
          });
        });
      }
    }
  }

  Future<BitmapDescriptor> _createCustomIcon() async {
    final ByteData byteData =
        await rootBundle.load('assets/page-1/images/maps.png');
    final Uint8List byteList = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(byteList, size: const Size(200, 200));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BitmapDescriptor>(
      future: _createCustomIcon(),
      builder:
          (BuildContext context, AsyncSnapshot<BitmapDescriptor> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4527A0)));
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading custom icon'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No custom icon data'));
        }

        return Scaffold(
          body: _currentLocation != null
              ? GoogleMap(
                  onMapCreated: (GoogleMapController controller) {},
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    zoom: 14.0,
                  ),
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId('destination'),
                      position: LatLng(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                      ),
                      icon: snapshot.data!,
                    ),
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(color: Color(0xFF4527A0)),
                ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: const Color(0xFF4527A0)),
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
                  icon: const Icon(Icons.map, color: const Color(0xFF4527A0)),
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
                  icon:
                      const Icon(Icons.person, color: const Color(0xFF4527A0)),
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
                  icon: const Icon(Icons.event, color: const Color(0xFF4527A0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyEvents()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
