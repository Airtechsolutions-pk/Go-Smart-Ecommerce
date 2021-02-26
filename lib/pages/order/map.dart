part of '../pages.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentPostion;
  bool showMap = false;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;

  @override
  void initState() {
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    mapController = controller;
    //
    // mapController.setMapStyle(
    //     '[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');

    if (currentPostion != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = currentPostion;
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
      );
      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(seconds: 1), () async {
        GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 17.0,
            ),
          ),
        );
      });
    }
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);

      showMap = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Location',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: showMap
          ? Stack(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  markers: Set<Marker>.of(_markers.values),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: currentPostion,
                    zoom: 18.0,
                  ),
                  myLocationEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    if (_markers.length > 0) {
                      MarkerId markerId = MarkerId(_markerIdVal());
                      Marker marker = _markers[markerId];
                      Marker updatedMarker = marker.copyWith(
                        positionParam: position.target,
                      );

                      setState(() {
                        _markers[markerId] = updatedMarker;
                      });
                    }
                  },
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 15.0),
                      child: FadeInAnimation(
                        2,
                        child: RaisedButtonWidget(
                          title: 'order.next',
                          onPressed: () {
                            Navigator.of(context).pop();

                          },
                        ),
                      ),
                    ),
                  ))
            ])
          : Center(
              child: SpinKitWave(
                  color: kPrimaryColor, type: SpinKitWaveType.center)),
    );
  }
}
