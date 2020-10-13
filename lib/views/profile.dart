import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/models/getlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/database.dart';
import 'package:geolocator/geolocator.dart';

class UserProfile extends StatefulWidget {
  final String chatRoomId;

  UserProfile({this.chatRoomId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  initiateSearch() async {
    setState(() {
      isLoading = true;
    });
    String name = widget.chatRoomId
        .toString()
        .replaceAll("_", "")
        .replaceAll(Constants.myName, "");
    print("Name: " + name);
    await databaseMethods.searchOneName(name).then((snapshot) {
      searchResultSnapshot = snapshot;
      print("$searchResultSnapshot");
      print("Hello");
      setState(() {
        isLoading = false;
        haveUserSearched = true;
      });
    });
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.documents[index].data["userName"],
                searchResultSnapshot.documents[index].data["userEmail"],
              );
            })
        : Container();
  }

  Widget userTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();

    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFILE"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          ((widget.chatRoomId
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, "") ==
                      "Shivam") ||
                  (widget.chatRoomId
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, "") ==
                      "Rohan"))
              ? Image.asset(
                  "assets/images/m_avatar.png",
                  height: 150,
                )
              : Image.asset(
                  "assets/images/g_avatar.png",
                  height: 150,
                ),
          userList(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Location',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          if (_currentPosition != null &&
                              _currentAddress != null)
                            Text(_currentAddress,
                                style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
