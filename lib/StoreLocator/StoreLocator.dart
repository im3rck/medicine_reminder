// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// import 'package:medicine_reminder/StoreLocator/models/place.dart';
// import 'package:medicine_reminder/StoreLocator/screens/search.dart';
// import 'package:medicine_reminder/StoreLocator/services/geolocator_service.dart';
// import 'package:medicine_reminder/StoreLocator/services/places_service.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// void main() => runApp(StoreLocator());
//
// class StoreLocator extends StatelessWidget {
//   final locatorService = GeoLocatorService();
//   final placesService = PlacesService();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         FutureProvider(create: (context) => locatorService.getLocation()),
//         FutureProvider(create: (context) {
//           ImageConfiguration configuration = createLocalImageConfiguration(context);
//           return BitmapDescriptor.fromAssetImage(configuration, 'assets/images/parking-icon.png');
//         }),
//         ProxyProvider2<Position,BitmapDescriptor,Future<List<Place>>>(
//           update: (context,position,icon,places){
//             return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude,icon) :null;
//           },
//         )
//       ],
//       // child: MaterialApp(
//       //   title: 'Parking App',
//       //   theme: ThemeData(
//       //     primarySwatch: Colors.blue,
//       //   ),
//       //   home: Search(),
//       // ),
//       child: Search(),
//     );
//   }
// }
