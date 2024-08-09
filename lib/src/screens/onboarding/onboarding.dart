// carosel slider 3 image with 3 poin bellow images and button next and button bypass , to login

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/system/system.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _Onboarding createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  int currentIndex = 0;
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Center> carouselItems = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboarding/0.png',
              scale: 0.8,
              height: 280,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              child: DotsIndicator(
                dotsCount: 3,
                decorator: const DotsDecorator(
                  color: Colors.grey,

                  activeColor: Colors.blue, // Active color
                ),
                position: currentIndex,
                onTap: (position) {
                  setState(() {
                    currentIndex = position;
                    controller.animateToPage(position);
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    S.of(context).onboardTitle1,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    S.of(context).onboardDescription1,
                    style: const TextStyle(fontSize: 22, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the value as needed
                          )),
                      onPressed: () {
                        controller.animateToPage(1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize:
                            MainAxisSize.max, // To minimize the button's size
                        children: [
                          Text(
                            "${S.of(context).next} ",
                            style: const TextStyle(fontSize: 20, height: 3),
                          ),
                          const Icon(Icons.arrow_forward_sharp), // Your icon
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboarding/1.png',
              scale: 0.8,
              height: 280,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              child: DotsIndicator(
                dotsCount: 3,
                decorator: const DotsDecorator(
                  color: Colors.grey,

                  activeColor: Colors.blue, // Active color
                ),
                position: currentIndex,
                onTap: (position) {
                  setState(() {
                    currentIndex = position;
                    controller.animateToPage(position);
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    S.of(context).onboardTitle2,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    S.of(context).onboardDescription2,
                    style: const TextStyle(fontSize: 22, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the value as needed
                          )),
                      onPressed: () {
                        controller.animateToPage(2);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize:
                            MainAxisSize.max, // To minimize the button's size
                        children: [
                          Text(
                            "${S.of(context).next} ",
                            style: const TextStyle(fontSize: 20, height: 3),
                          ),
                          const Icon(Icons.arrow_forward_sharp), // Your icon
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboarding/2.png',
              scale: 0.8,
              height: 280,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              child: DotsIndicator(
                dotsCount: 3,
                decorator: const DotsDecorator(
                  color: Colors.grey,

                  activeColor: Colors.blue, // Active color
                ),
                position: currentIndex,
                onTap: (position) {
                  setState(() {
                    currentIndex = position;
                    controller.animateToPage(position);
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    S.of(context).onboardTitle3,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    S.of(context).onboardDescription3,
                    style: const TextStyle(fontSize: 22, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the value as needed
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, 'welcome');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize:
                            MainAxisSize.max, // To minimize the button's size
                        children: [
                          Text(
                            "${S.of(context).done} ",
                            style: const TextStyle(fontSize: 20, height: 3),
                          ),
                          const Icon(Icons.arrow_forward_sharp), // Your icon
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: BlocBuilder<SystemBloc, SystemModel>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<SystemBloc>().add(ChangeThemeEvent(
                            state.themeMode == 'dark' ? 'light' : 'dark'));
                      },
                      icon: state.themeMode == 'dark'
                          ? const Icon(Icons.brightness_7)
                          : const Icon(Icons.brightness_4)),

                  //dropdown to change laguage
                  DropdownButton<String>(
                    alignment: Alignment.center,
                    value: state.language == 'en' ? 'en' : 'vi',
                    iconSize: 25,
                    onChanged: (String? newValue) {
                      context
                          .read<SystemBloc>()
                          .add(ChangeLanguageEvent(newValue!));
                    },
                    items: <String>['en', 'vi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: value == 'en'
                              ? Row(
                                  children: [
                                    Image.asset('assets/images/flag/1.png',
                                        width: 24, height: 24),
                                    const Text(" English")
                                  ],
                                )
                              : Row(
                                  children: [
                                    Image.asset('assets/images/flag/2.png',
                                        width: 24, height: 24),
                                    const Text(" Vietnamese")
                                  ],
                                ));
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(S.of(context).passed,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            CarouselSlider(
              items: carouselItems,
              carouselController: controller,
              options: CarouselOptions(
                height: size.height,
                // Customize the height of the carousel
                autoPlay: false, // Enable auto-play
                enlargeCenterPage: true, // Increase the size of the center item
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            )
          ],
        ));
  }
}
