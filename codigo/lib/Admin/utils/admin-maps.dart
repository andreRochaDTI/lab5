import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:myapp/Admin/events/admin-homepage.dart';
import 'package:myapp/Admin/profile/profile.dart';

class AdminMapPage extends StatefulWidget {
  final String? targetAddress;

  const AdminMapPage({Key? key, this.targetAddress}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<AdminMapPage> {
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
                    builder: (context) => AdminHomePage(),
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
                    builder: (context) => const AdminMapPage(),
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
                    builder: (context) => AdminProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
