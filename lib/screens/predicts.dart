import 'package:flutter/material.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/util/colors.dart';

class PredictsScreen extends StatelessWidget {
  const PredictsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const HealthAppBar(
              title: 'Future Predicts',
              isBack: true,
            ),
            const HealthSpacer(height: 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'How it Works',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBlue,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const HealthSpacer(height: 0.03),
                      const Text(
                        'The system predicts the health risks of a human using the statistics of the the past couple of months. Eg - Sleep time, Screen time, Activity and Steps.',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const HealthSpacer(height: 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Health Risk',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBlue,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const HealthSpacer(height: 0.03),
                      buildRisk(
                        'Health Pro has detected lower average of sleep during the past mont. By continuing this you have risk of having obesity, heart disease, high blood pressure and diabetes.',
                      ),
                      buildRisk(
                          'Health Pro has detected higher average of screen ussage during the past mont. By continuing this you have risk of having obesity, sleep problems, chronic neck and back problems and depression.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRisk(String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Container(
        color: Colors.redAccent.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
