import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rockets_app/features/rocket_lauches/bloc/rocket_launch_bloc.dart';
import 'package:rockets_app/repositories/rocket_launches/abstract_rocket_launch_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rockets_app/features/rocket_lauches/widgets/carousel_container.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketLaunchesScreen extends StatefulWidget {
  const RocketLaunchesScreen({super.key});

  @override
  State<RocketLaunchesScreen> createState() => _RocketLaunchesScreenState();
}

class _RocketLaunchesScreenState extends State<RocketLaunchesScreen> {
  int currentIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final _rocketLaunchBloc = RocketLaunchBloc(
    GetIt.I<AbstractRocketLaunchRepository>(),
  );

  @override
  void initState() {
    _rocketLaunchBloc.add(GetRocketLaunchesById("falcon1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<Widget> carouselItems = [
      CarouselContainer(
        screenWidth: deviceWidth,
        screenHeigh: deviceHeight,
        imageAsset: "assets/falcon1.jpg",
      ),
      CarouselContainer(
        screenWidth: deviceWidth,
        screenHeigh: deviceHeight,
        imageAsset: "assets/falcon9.jpg",
      ),
      CarouselContainer(
        screenWidth: deviceWidth,
        screenHeigh: deviceHeight,
        imageAsset: "assets/falcon_heavy.jpg",
      ),
    ];

    Future<void> openWikipedia(String url) async {
      await launchUrl(Uri.parse(url));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "SpaceX Launches",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CarouselSlider(
              items: carouselItems,
              carouselController: controller,
              options: CarouselOptions(
                height: deviceHeight * 0.35,
                aspectRatio: 2,
                viewportFraction: 0.78,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                    switch (index) {
                      case 0:
                        _rocketLaunchBloc.add(GetRocketLaunchesById("falcon1"));
                      case 1:
                        _rocketLaunchBloc.add(GetRocketLaunchesById("falcon9"));
                      case 2:
                        _rocketLaunchBloc.add(
                          GetRocketLaunchesById("falconheavy"),
                        );
                    }
                    debugPrint(currentIndex.toString());
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(carouselItems.length, (index) {
                return GestureDetector(
                  onTap: () => controller.animateToPage(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.transparent,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  SizedBox(height: 10),

                  Text(
                    "Missions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    height: deviceHeight * 0.37,
                    child: BlocBuilder<RocketLaunchBloc, RocketLaunchState>(
                      bloc: _rocketLaunchBloc,
                      builder: (context, state) {
                        if (state is RocketLaunchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is RocketLaunchLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.launchList.length,
                            itemBuilder: (context, i) {
                              final launch = state.launchList[i];
                              return GestureDetector(
                                onTap: () => openWikipedia(launch.wikipedia!),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(28, 28, 28, 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              launch.dateDmy,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                  255,
                                                  185,
                                                  252,
                                                  84,
                                                ),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              launch.timeHmAmPm,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                  255,
                                                  197,
                                                  197,
                                                  197,
                                                ),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 30),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                overflow: TextOverflow.clip,
                                                launch.missionName,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                overflow: TextOverflow.clip,
                                                launch.launchSiteName,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    165,
                                                    165,
                                                    165,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is RocketLaunchLoadingError) {
                          return Center(
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
