import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kozarni_ecome/screen/home_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "",
          body: '''မြန်မာဖိနပ် နှင့် နိုင်ငံခြားဖိနပ်အမျိုးမျိုး လက်ကားအရောင်းဆိုင်''',
          image: buildImage('assets/logotr.png'),
          decoration: getPageDecoration(),
        ),

        PageViewModel(
          title: "",
          body: '''❤ မြခြူးမိသားစုမှ သူဌေးလောင်းများကို 
          
          ဖိတ်ခေါ်နေပါတယ် ❤️''',
          image: buildImage('assets/logotr.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '',
          body: '''🏠 ဆိုင်လိပ်စာလေးကတော့….
          
အမှတ် ၂၁၇ - ၂၃၆ ၊ ၊ ၂၉လမ်း အထက် ၊ 
ပန်းဘဲတန်းမြို့နယ်၊ ရန်ကုန်မြို့။''',
          image: buildImage('assets/logotr.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "",
          body: '''☎ ဆက်သွယ်ရန် 
     ဖုန်းနံပါတ်လေးတွေကတော့
          
09 265 700 006

09 796 700 006

09 952 700 006''',
          image: buildImage('assets/logotr.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '',
          body: ''' ❝  အခုလိုမျိုး ရွေးချယ်စရာတွေအများကြီးရှိတဲ့ အထဲကမှ မင်မင်တို့ရဲ့ "မြခြူး" တံဆိပ်ကို ယုံယုံကြည်ကြည်နဲ့ ရွေးချယ်ပေးခဲ့လို့ ကျေးဇူးအထူးတင်ပါတယ် ❞ ''',
          footer: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ButtonWidget(
              text: "LET'S GET STARTED",
              onClicked: () => goToHome(context),
            ),
          ),
          image: buildImage('assets/logotr.png'),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text("", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text('SKIP', style: TextStyle(fontSize: 16, color: Colors.orange),),
      onSkip: () => goToHome(context),
      next: Icon(Icons.forward_outlined, size: 30, color: Colors.orange),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Colors.white,
      skipFlex: 0,
      nextFlex: 0,
      // isProgressTap: false,
      // isProgress: false,
      // showNextButton: true,
      // freeze: true,
      // animationDuration: 1000,
    ),
  );

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomeScreen()),
  );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 250));

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Colors.indigo,
    activeColor: Colors.orange,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    titlePadding: EdgeInsets.only(top: 0),
    descriptionPadding: EdgeInsets.only(top: 30).copyWith(bottom: 0),
    imagePadding: EdgeInsets.only(top: 30),
    pageColor: Colors.white,
  );
}


class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    onPressed: onClicked,
    color: Colors.orangeAccent,
    shape: StadiumBorder(),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Text(text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}