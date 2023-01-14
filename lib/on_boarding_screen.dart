import 'package:flutter/material.dart';
import 'package:shopapp/login.dart';
import 'package:shopapp/shared_prefrences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(title: 'Title 1', body: 'Body 1', image: 'assets/shop.png'),
    BoardingModel(title: 'Title 2', body: 'Body 2', image: 'assets/shop.png'),
    BoardingModel(title: 'Title 3', body: 'Body 3', image: 'assets/shop.png')
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.savaData(key: 'onBoarding', value: true);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const ScreenLogin()),
            (route) {
          return false;
        });
      
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
 submit();                  },
                child: Text(
                  'SKIP',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      BuildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                      count: boarding.length),
                  Spacer(),
                  FloatingActionButton(
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        if (isLast) {
 submit();                      }
                        boardController.nextPage(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      })
                ],
              )
            ],
          ),
        ));
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(model.title),
          SizedBox(
            height: 30,
          ),
          Text(model.body)
        ],
      );
}
