import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/Client/profile/client-profile.dart';

class ClientMapPage extends StatefulWidget {
  final String? targetAddress;

  const ClientMapPage({Key? key, this.targetAddress}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<ClientMapPage> {
  GoogleMapController? _mapController;
  location.LocationData? _currentLocation;
  location.Location _location = location.Location();
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
        print('Could not get the location: $e');
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
      } else {
        print('Could not find the location for the address: $_targetAddress');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation != null
          ? GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
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
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
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
                // Navegue para a página de ingressos aqui
              },
            ),
          ],
        ),
      ),
    );
  }
}