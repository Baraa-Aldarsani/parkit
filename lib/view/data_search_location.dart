import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/location_model.dart';
import 'package:parking/view/map_view.dart';

class DataSearchLocation extends SearchDelegate {
  final List<LocationModel>? location;

  DataSearchLocation({this.location});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.close,
            color: red,
            size: 30,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: darkblue,
          size: 30,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> names = [];
    List<String> streets = [];
    for (int i = 0; i < location!.length; i++) {
      String name = location![i].name;
      String street = location![i].street;
      names.add(name);
      streets.add(street);
    }
    List filternames =
        names.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemCount: query == '' ? location!.length : filternames.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: InkWell(
            onTap: () {
              Get.to(MapView(latitude:location![index].latitude, longitude: location![index].longitude,));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: darkblue,
              ),
              child: query == ''
                  ? ListTile(
                      title: Text(
                        location![index].name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400,color: lightgreen),
                      ),
                      leading: Icon(Icons.location_on,color: deepdarkblue,size: 40),
                      subtitle: Text(location![index].street,style: TextStyle(color: Colors.grey.shade200)),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: lightgreen,
                        size: 30,

                      ),
                    )
                  : ListTile(
                      title: Text(
                        filternames[index],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400,color: lightgreen),
                      ),
                leading: Icon(Icons.location_on,color: deepdarkblue,size: 40),
                subtitle: Text(streets[index],style: TextStyle(color: Colors.grey.shade200)),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: lightgreen,
                        size: 30,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
