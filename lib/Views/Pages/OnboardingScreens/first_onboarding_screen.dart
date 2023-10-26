import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:bytepad/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FirstOnboardingScreen extends StatefulWidget {
  const FirstOnboardingScreen({super.key});

  @override
  State<FirstOnboardingScreen> createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {

  List display = [
    { "img": 'assets/images/FirstOnboardImage.jpeg' , "heading": 'Unlock the Past', "content": 'Dive into a treasure trove of past exam papers and study materials, making exam preparation a breeze.'},
    { "img": 'assets/images/SecondOnboardImage.jpeg' , "heading": 'Stay Informed', "content": 'Keep track of your attendance effortlessly, ensuring you never miss an important class or deadline.'},
    { "img": 'assets/images/ThirdOnboardImage.jpeg' , "heading": 'Empower Educators', "content": 'Stay updated with the latest course materials, announcements, and resources shared by your teachers.'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  void onNextButtonPressed() {
    if (currentIndex == display.length - 1) {
      // Logic for when "NEXT" button is pressed on the last page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Replace YourNextPage() with the actual next page widget
      );
    } else {
      carouselController.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                    items: display.map((item) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(item['img'],),
                        SizedBox(height: size.height*0.05),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal : size.width*0.05),
                          child: Text(item['heading'],
                            style: TextStyle(
                              fontSize: size.width*0.08,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        // SizedBox(height: size.height*0.05),
                        Padding(
                          padding: EdgeInsets.all(size.width*0.05),
                          child: Text(item['content'],
                            style: TextStyle(
                              fontSize: size.width*0.05,
                            ),
                          ),
                        )
                      ],
                    )).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    aspectRatio: 0.6,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }
                  ),
                ),
                Positioned(
                    bottom: size.height*0.09,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: display.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => carouselController.animateToPage(entry.key),
                          child: Container(
                            width: size.width*0.025,
                            height: size.height*0.012,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: currentIndex == entry.key? blueColor : Colors.grey,
                              borderRadius: BorderRadius.circular(size.width*0.025),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: size.width*0.9,
                      child: ElevatedButton(
                        onPressed: onNextButtonPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("NEXT",
                            style: TextStyle(
                              fontSize: size.width*0.05,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(blueColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
