import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicine_reminder/StoreLocator/services/geolocator_service.dart';
import 'package:medicine_reminder/StoreLocator/services/marker_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : List<Marker>();
                  return (places != null)
                      ? Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0),
                                zoomGesturesEnabled: true,
                                mapType: MapType.normal,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                trafficEnabled: true,
                                scrollGesturesEnabled: true,
                                markers: Set<Marker>.of(markers),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Expanded(
                              child: (places.length > 0)
                                  ? ListView.builder(
                                      itemCount: places.length,
                                      itemBuilder: (context, index) {
                                        return FutureProvider(
                                          create: (context) =>
                                              geoService.getDistance(
                                                  currentPosition.latitude,
                                                  currentPosition.longitude,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng),
                                          child: Card(
                                            margin: EdgeInsets.all(
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height) *
                                                    .01),
                                            elevation: 10.0,
                                            color: Color(0xff292929),
                                            child: ListTile(
                                              title: Text(
                                                places[index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Circular',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffF2E7FE),
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  (places[index].rating != null)
                                                      ? Row(
                                                          children: <Widget>[
                                                            RatingBarIndicator(
                                                              rating:
                                                                  places[index]
                                                                      .rating,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber),
                                                              itemCount: 5,
                                                              itemSize: 10.0,
                                                              direction: Axis
                                                                  .horizontal,
                                                            )
                                                          ],
                                                        )
                                                      : Row(),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Consumer<double>(
                                                    builder: (context, meters,
                                                        wiget) {
                                                      return (meters != null)
                                                          ? Text(
                                                              '${places[index].vicinity} \u00b7 ${(meters / 1000).toStringAsFixed(2)} km',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Circular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                        0xffF2E7FE)
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            )
                                                          : Container();
                                                    },
                                                  )
                                                ],
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.directions),
                                                color: Color(0xffbb86fe),
                                                onPressed: () {
                                                  _launchMapsUrl(
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text(
                                        'No Pharmacy Found Nearby',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Circular',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffF2E7FE),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        )
                      : Center(child: SpinKitFadingCircle(color: Color(0xffbb86fe),));
                },
              )
            : Center(
                child: SpinKitFadingCircle(color: Color(0xffbb86fe),),
              ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
