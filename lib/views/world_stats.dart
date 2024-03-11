import 'package:covid_app/Models/worldStats.dart';
import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/views/Country_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class worldstatsScreen extends StatefulWidget {
  const worldstatsScreen({super.key});

  @override
  State<worldstatsScreen> createState() => _worldStatsScreenState();
}

class _worldStatsScreenState extends State<worldstatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    StatsService();
    super.initState();
  }

  final colorList = [
    const Color(0xff4285f4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];
  var devheight;
  var devwidth;
  @override
  Widget build(BuildContext context) {
    StatsService stats = StatsService();
    devheight = MediaQuery.of(context).size.height;
    devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<WorldStatsModel?> snapshot) {
            if (!snapshot.hasData) {
              return SpinKitFadingCircle(
                size: 50,
                color: Colors.white,
                controller: _controller,
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: devheight * 0.01,
                  ),
                  PieChart(
                    dataMap: {
                      'Total': double.parse(snapshot.data!.cases!.toString()),
                      'Recovered':
                          double.parse(snapshot.data!.recovered!.toString()),
                      'Deaths': double.parse(
                        snapshot.data!.deaths!.toString(),
                      ),
                    },
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                    animationDuration: const Duration(microseconds: 1200),
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left),
                    chartType: ChartType.ring,
                    chartRadius: devwidth / 3.2,
                    colorList: colorList,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 10, right: 10, bottom: 5),
                    child: Card(
                      child: Column(
                        children: [
                          ResurebleEow(
                            title: 'Total',
                            value: snapshot.data!.cases.toString(),
                          ),
                          ResurebleEow(
                            title: 'Deaths',
                            value: snapshot.data!.deaths.toString(),
                          ),
                          ResurebleEow(
                            title: 'Recovered',
                            value: snapshot.data!.recovered.toString(),
                          ),
                          ResurebleEow(
                            title: 'Active',
                            value: snapshot.data!.active.toString(),
                          ),
                          ResurebleEow(
                            title: 'Critical',
                            value: snapshot.data!.critical.toString(),
                          ),
                          ResurebleEow(
                            title: 'Todays Deaths',
                            value: snapshot.data!.todayDeaths.toString(),
                          ),
                          ResurebleEow(
                            title: 'Todays Recoverd',
                            value: snapshot.data!.todayRecovered.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 10, right: 10, bottom: 5),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryListScreen(),
                          )),
                      child: Container(
                        height: 50,
                        width: devwidth,
                        decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('Track Contries')),
                      ),
                    ),
                  )
                ],
              );
            }
          },
          future: stats.FetchWorldStatsRecord(),
        ),
      )),
    );
  }
}

class ResurebleEow extends StatelessWidget {
  ResurebleEow({super.key, required this.title, required this.value});

  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 12,
          ),
        ],
      ),
    );
  }
}
