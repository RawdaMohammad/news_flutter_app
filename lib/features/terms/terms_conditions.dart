import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last updated at ${DateTime.timestamp()}"),
                SizedBox(height: 20,),
                Text('Welcome to Newst! These Terms and Conditions ("Terms") govern your use of the Newst mobile \napplication ("App"), developed and operated \nby [Your Company Name]. \n\nBy accessing or using the App, you agree to be bound by these Terms. \nIf you do not agree with any part of these Terms, \nplease do not use the App.'
                  ,style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Divider(thickness: 1, color: Color(0xFFD1DAD6),),
                SizedBox(height: 20,),
                Text('1. Use of the App', style: Theme.of(context).textTheme.titleMedium,),
                Text('Newst provides users with curated news, updates, and personalized content. You agree to use the App only for lawful purposes and in a way that does not violate the rights of others or restrict their use of the App.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('2. User Content', style: Theme.of(context).textTheme.titleMedium,),
                Text('You may have the opportunity to submit feedback or content through the App. By doing so, you grant Newst a non-exclusive, royalty-free license to use, reproduce, and display that content.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 8,),
                Text('You are responsible for the content you submit and must not upload any material that is illegal, offensive, or infringes upon intellectual property rights.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('3. Privacy', style: Theme.of(context).textTheme.titleMedium,),
                Text('Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('4. Intellectual Property', style: Theme.of(context).textTheme.titleMedium,),
                Text('All content, trademarks, and data on the App, including text, images, logos, and software, are the property of Newst or its licensors. You may not copy, reproduce, or distribute any part of the App without permission.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('5. Modifications and Updates', style: Theme.of(context).textTheme.titleMedium,),
                Text('We may update the App or these Terms at any time without prior notice. It is your responsibility to check for updates. Continued use of the App after changes constitutes acceptance of the revised Terms.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('6. Disclaimer', style: Theme.of(context).textTheme.titleMedium,),
                Text('The App is provided "as is" without warranties of any kind. While we strive for accuracy, we do not guarantee the completeness or reliability of any information provided.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('7. Limitation of Liability', style: Theme.of(context).textTheme.titleMedium,),
                Text('Newst shall not be liable for any direct, indirect, or incidental damages resulting from the use or inability to use the App.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20,),
                Text('8. Termination', style: Theme.of(context).textTheme.titleMedium,),
                Text('We may suspend or terminate your access to the App at any time, without notice, for conduct that we believe violates these Terms or is harmful to other users or the App.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),

              ],
            ),
        ),
      ),
    );
  }
}
