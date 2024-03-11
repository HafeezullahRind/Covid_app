import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/stats_services.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScrenState();
}

class _CountryListScrenState extends State<CountryListScreen> {
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsService service = StatsService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              onChanged: (value) {
                print(_controller.text);
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  hintText: 'Search with Country Name'),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: service.FetchCountryCases(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ))
                          ],
                        ));
                  },
                );
              } else {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final countryData = snapshot.data![index];
                      String name = snapshot.data![index]['country'].toString();
                      ['country'];
                      if (_controller.text.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(countryData['country'].toString()),
                              subtitle: Text(countryData['cases'].toString()),
                              leading: Image.network(
                                countryData['countryInfo']['flag'],
                                fit: BoxFit.cover,
                                width: 50,
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(_controller.text.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(countryData['country'].toString()),
                              subtitle: Text(countryData['cases'].toString()),
                              leading: Image.network(
                                countryData['countryInfo']['flag'],
                                fit: BoxFit.cover,
                                width: 50,
                              ),
                            ),
                          ],
                        );
                      } else {
                        Container();
                      }
                    },
                  ),
                );
              }
            },
          ))
        ],
      )),
    );
  }
}
