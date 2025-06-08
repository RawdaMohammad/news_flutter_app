import 'package:flutter/material.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:news_app/models/onBoardingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  /// (DONE) TODO : Task - Create Model For This List
  final List<OnBoardingModel> onboardingData = [
    OnBoardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Discover News',
      desc:
          "Swipe through trending news and explore your favorite categories — stay updated in just a tap!",
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Trending News',
      desc:
          "Stay on top of what's happening now — catch the most talked-about headlines.",
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Bookmarks',
      desc:
          "You can easily access the news you've saved for later.",
    ),
  ];

  void _onNext() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SignInScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_currentPage < onboardingData.length - 1)
            TextButton(
              onPressed: _finishOnboarding,
              child: Text('Skip', style: Theme.of(context).textTheme.displayMedium),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Column(
                  children: [
                    const SizedBox(height: 16),

                    Image.asset(data.image!, height: 320, fit: BoxFit.contain),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        data.title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        data.desc!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 24),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? const Color(0xFFC53030)
                          : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _onNext,
                child: Text(
                  _currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
