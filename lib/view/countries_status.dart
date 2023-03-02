import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/Models/Services/state_services.dart';
import 'package:new_project/view/countries_detail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class CountriesStatusScreen extends StatefulWidget {
  const CountriesStatusScreen({super.key});

  @override
  State<CountriesStatusScreen> createState() => _CountriesStatusScreenState();
}

class _CountriesStatusScreenState extends State<CountriesStatusScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          10.heightBox,
          TextFormField(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: "Search the Country",
                hintStyle: TextStyle(fontSize: 16),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 110, 103, 103))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 231, 224, 224)))),
          ).box.padding(EdgeInsets.all(8)).make(),
          Expanded(
            child: FutureBuilder(
                future: stateServices.fetchCountriesStatusData(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade800,
                              highlightColor: Colors.grey.shade100,
                              child: ListTile(
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  color: Vx.white,
                                ),
                                title: Container(
                                  height: 15,
                                  width: 100,
                                  color: Vx.white,
                                ),
                                subtitle: Container(
                                  height: 15,
                                  width: 100,
                                  color: Vx.white,
                                ),
                              ));
                        });
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String countryName = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return ListTile(
                              onTap: () {
                                Get.to(() => CountriesDetails(
                                      title: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases']
                                          .toString(),
                                      totalRecovered: snapshot.data![index]
                                              ['recovered']
                                          .toString(),
                                      totalDeath: snapshot.data![index]
                                              ['deaths']
                                          .toString(),
                                      critical: snapshot.data![index]
                                              ['critical']
                                          .toString(),
                                      active: snapshot.data![index]['active']
                                          .toString(),
                                      flag: snapshot.data![index]['countryInfo']
                                              ['flag']
                                          .toString(),
                                    ));
                              },
                              leading: (
                                snapshot.data![index]['countryInfo']['flag'] == null)?
                                CircularProgressIndicator()
                                :Image.network(
                                snapshot.data![index]['countryInfo']['flag']
                                    .toString(),
                                height: 50,
                                width: 40,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text('Failed to load image');
                                },
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text("Effected:  " +
                                  snapshot.data![index]['cases'].toString()),
                            );
                          } else if (countryName
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return ListTile(
                              onTap: () {
                                Get.to(() => CountriesDetails(
                                      title: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases']
                                          .toString(),
                                      totalRecovered: snapshot.data![index]
                                              ['recovered']
                                          .toString(),
                                      totalDeath: snapshot.data![index]
                                              ['deaths']
                                          .toString(),
                                      critical: snapshot.data![index]
                                              ['critical']
                                          .toString(),
                                      active: snapshot.data![index]['active']
                                          .toString(),
                                      flag: snapshot.data![index]['countryInfo']
                                              ['flag']
                                          .toString(),
                                    ));
                              },
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag']
                                    .toString(),
                                height: 50,
                                width: 40,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text('Failed to load image');
                                },
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text("Effected:  " +
                                  snapshot.data![index]['cases'].toString()),
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      )),
    );
  }
}
