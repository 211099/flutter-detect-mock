import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trust_location/trust_location.dart';

import 'package:location_permissions/location_permissions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _latitude = '0';
  String _longitude = '0';
  bool _isMockLocation = false;

  /// initialize state.
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    // input seconds into parameter for getting location with repeating by timer.
    // this example set to 5 seconds.
    TrustLocation.start(5);
    getLocation();
  }

  /// get location method, use a try/catch PlatformException.
  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
        _latitude = values.latitude!;
        _longitude = values.longitude!;
        _isMockLocation = values.isMockLocation!;
      }));
} on PlatformException catch (e) {
  print('PlatformException $e');
}
}

  /// request location permission at runtime.
  void requestLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    print('permissions: $permission');
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trust Location Plugin'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
          child: Column(
        children: <Widget>[
          Text('Mock Location: $_isMockLocation'),
          Text('Latitude: $_latitude, Longitude: $_longitude'),
         ],
       )),
     ),
   ),
 );
}
}
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ubicación Falsa Detector',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _message = "Verificando ubicación...";

//   @override
//   void initState() {
//     super.initState();
//     _checkLocation();
//   }

//   _checkLocation() async {
//     bool isLocationFake;
//     try {
//       LocationAccuracy accuracy = LocationAccuracy.high;
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: accuracy);

//       isLocationFake = position.isMocked;
//       setState(() {
//         _message = isLocationFake
//             ? "La ubicación es falsa."
//             : "La ubicación es verdadera.";
//       });
//     } catch (e) {
//       setState(() {
//         _message = "Error al obtener la ubicación: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ubicación Falsa Detector'),
//       ),
//       body: Center(
//         child: Text(_message),
//       ),
//     );
//   }
// }
