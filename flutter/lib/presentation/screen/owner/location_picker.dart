import 'package:flutter/material.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/service/api_service.dart';
import 'package:manpro/model/location_item.dart';
import 'package:manpro/presentation/widget/shimmer.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String location = "Surabaya";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: InputIcon(hintText: "Cari Lokasi", icon: Icons.search, onChanged: (value) {
              setState(() {
                if(value == "") {
                  location = "Surabaya";
                } else {
                  location = value;
                }
              });
            })),
          ]
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<LocationItem>(
              future: ApiService().getLocationItem(location),
              builder: (context, location) {
                if(location.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 5,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {},
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(width: 200, height: 15),
                          SizedBox(height: 5),
                          ShimmerLoading(width: 100, height: 15),
                        ],
                      )
                    )
                  );
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: location.data.data.areas.length,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () => Navigator.pop(context, location.data.data.areas[index]),
                      title: Text(location.data.data.areas[index].title),
                      subtitle: Text(location.data.data.areas[index].area),
                    )
                  );
                }
              }
            )
          )
        ],
      ),
    );
  }
}