import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:healthapp/charts/chart_bar.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/circular_card.dart';
import 'package:healthapp/components/filtter.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:healthapp/models/chart_data.dart';
import 'package:intl/intl.dart';

class ChartScreen extends StatefulWidget {
  final String title;
  final double value;
  final List<ChatrData> data;
  const ChartScreen(
      {Key? key, required this.title, required this.value, required this.data})
      : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<ChatrData> filtered = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            HealthAppBar(
              title: widget.title,
              isBack: true,
            ),
            const HealthSpacer(height: 0.03),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HealthChartFilter(
                        title: 'D',
                        onTap: () {
                          setData(filter: 'D');
                        },
                      ),
                      HealthChartFilter(
                        title: 'W',
                        onTap: () {
                          setData(filter: 'W');
                        },
                      ),
                      HealthChartFilter(
                        title: 'M',
                        onTap: () {
                          setData(filter: 'M');
                        },
                      ),
                      HealthChartFilter(
                        title: '6M',
                        onTap: () {
                          setData(filter: '6M');
                        },
                      ),
                      HealthChartFilter(
                        title: 'Y',
                        onTap: () {
                          setData(filter: 'Y');
                        },
                      ),
                    ],
                  ),
                  const HealthSpacer(height: 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HealthCircularCard(
                        title: widget.title,
                        value: widget.value,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: HealthBarChart(
                        seriesList: getData(),
                      ),
                    ),
                  ),
                  if (widget.title == 'Steps')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: steps,
                    ),
                  if (widget.title == 'Sleep Time')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: sleep,
                    ),
                  if (widget.title == 'Activity')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: activity,
                    )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void setData({String filter = 'M'}) {
    getData(filter: filter);
    filtered.clear();
    filtered.addAll(filterData(filter));
    print('setData $filter size ${filtered.length}');
    setState(() {});
  }

  List<charts.Series<ChatrData, String>> getData({String filter = 'M'}) {
    return [
      charts.Series<ChatrData, String>(
          id: widget.title,
          domainFn: (ChatrData e, _) => DateFormat('dd').format(e.axis),
          measureFn: (ChatrData e, _) => e.value,
          data: filtered.isNotEmpty ? filtered : widget.data,
          labelAccessorFn: (ChatrData e, _) => e.value.toString())
    ];
  }

  List<ChatrData> filterData(String filter) {
    switch (filter) {
      case 'D':
        return widget.data
            .where((element) => getDiff(element.axis) < 1)
            .toList();
      case 'W':
        return widget.data
            .where((element) => getDiff(element.axis) < 7)
            .toList();
      case 'M':
        return widget.data
            .where((element) => getDiff(element.axis) < 30)
            .toList();
      case 'Y':
        return widget.data
            .where((element) => getDiff(element.axis) < 180)
            .toList();
      default:
        return widget.data;
    }
  }

  int getDiff(DateTime createdAt) {
    DateTime dateTimeNow = DateTime.now();
    final differenceInDays = createdAt.difference(dateTimeNow).inDays;
    print('getDiff $differenceInDays');
    return differenceInDays;
  }

  Widget activity = HtmlWidget(
    """
          
<p><span style="text-decoration: underline;"><strong>CALORIES</strong></span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><span style="font-weight: 400;">How many calories to be burnt a day?</span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><a href="https://www.healthline.com/health/fitness-exercise/how-many-calories-do-i-burn-a-day"><span style="font-weight: 400;">https://www.healthline.com/health/fitness-exercise/how-many-calories-do-i-burn-a-day</span></a></p>
<p><span style="font-weight: 400;">&nbsp;</span><span style="font-weight: 400;">Most female adults need 1,600&ndash;2,200 calories per day, while adult males need 2,200&ndash;3,000 calories per day. However, the amount of calories you need each day is unique to your body and activity levels</span></p>
<p><span style="font-weight: 400;">For sustainable weight loss, an ideal calorie deficit will be around 10&ndash;20% fewer calories than your total daily energy expenditure (TDEE).</span></p>
<p><a href="https://www.webmd.com/diet/features/estimated-calorie-requirement"><span style="font-weight: 400;">https://www.webmd.com/diet/features/estimated-calorie-requirement</span></a></p>
<p><br style="font-weight: 400;" /><br style="font-weight: 400;" /><br /></p>
          """,
  );

  Widget steps = HtmlWidget(
    """
<p><span style="text-decoration: underline;"><strong>STEPS</strong></span></p>
<p>&nbsp;</p>
<p>How many steps should you take a day?</p>
<p><span style="font-weight: 400;">A </span><a href="https://ijbnpa.biomedcentral.com/articles/10.1186/1479-5868-8-79"><span style="font-weight: 400;">2011 study</span><span style="font-weight: 400;">Trusted Source</span></a><span style="font-weight: 400;"> found that healthy adults can take anywhere between approximately 4,000 and 18,000 steps/day, and that 10,000 steps/day is a reasonable target for healthy adults.</span></p>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Inactive:</strong><span style="font-weight: 400;"> less than 5,000 steps per day</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Average (somewhat active):</strong><span style="font-weight: 400;"> ranges from 7,500 to 9,999 steps per day</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Very active:</strong><span style="font-weight: 400;"> more than 12,500 steps per day</span></li>
</ul>
<p><a href="https://www.healthline.com/health/how-many-steps-a-day#How-many-steps-to-improve-your-fitness-level?"><span style="font-weight: 400;">https://www.healthline.com/health/how-many-steps-a-day#How-many-steps-to-improve-your-fitness-level?</span></a></p>
<p><span style="font-weight: 400;">What happens if you walk too much?</span></p>
<p><span style="font-weight: 400;">Old injuries, like a sore knee, are likely to flare up. Increased risk of injury: Soreness from overtraining can lead to bad form and posture while walking, which can then lead to an increased risk of injury. Sore or injured joints are also at more risk for a sudden, severe injury than they would be with proper rest.</span></p>
<p><a href="https://brightside.me/inspiration-health/10-things-that-happen-to-your-body-if-you-walk-every-day-485010/"><span style="font-weight: 400;">https://brightside.me/inspiration-health/10-things-that-happen-to-your-body-if-you-walk-every-day-485010/</span></a></p>
<p><br style="font-weight: 400;" /><br style="font-weight: 400;" /><br /></p>
          """,
  );

  Widget sleep = HtmlWidget(
    """
<p><span style="text-decoration: underline;"><strong>SLEEP</strong></span></p>
<p><span style="font-weight: 400;">Adult and children sleep time recommendations from a research paper or a accepted website</span></p>
<p>&nbsp;</p>
<p>How does sleep affect the mental health?</p>
<p><span style="font-weight: 400;">Lack of sleep is linked to a number of unfavorable health consequences including heart disease, type 2 diabetes, and depression.</span></p>
<p><span style="font-weight: 400;">Poor sleep can make it much more difficult to cope with even relatively minor </span><a href="https://www.verywellmind.com/stress-and-health-3145086"><span style="font-weight: 400;">stress</span></a><span style="font-weight: 400;">. Daily hassles can turn into major sources of frustration. You might find yourself feeling frazzled, short-tempered, and frustrated by everyday annoyances.</span></p>
<p><span style="font-weight: 400;">Insomnia and other sleep problems can be a symptom of </span><a href="https://www.verywellmind.com/depression-4157261"><span style="font-weight: 400;">depression</span></a><span style="font-weight: 400;">, but more recently, research has implicated lack of sleep in actually causing depression.</span></p>
<p><span style="font-weight: 400;">As with many other psychological conditions, the relationship between sleep and anxiety appears to go both directions. People with anxiety tend to experience more sleep disturbances, but experiencing sleep deprivation can also contribute to feelings of anxiety. This can become a cycle that perpetuates both the sleep and anxiety issues.</span></p>
<p><span style="font-weight: 400;">Sleep disturbances are very common among people with </span><a href="https://www.verywellmind.com/how-sleep-and-bipolar-disorder-interact-379019"><span style="font-weight: 400;">bipolar disorder</span></a><span style="font-weight: 400;">. Such problems can include insomnia, irregular sleep-wake cycles, and nightmares. Bipolar disorder is characterized by alternating periods of depressed and elevated moods.</span></p>
<p><a href="https://www.verywellmind.com/adhd-overview-4581801"><span style="font-weight: 400;">Attention-deficit hyperactivity disorder (ADHD)</span></a><span style="font-weight: 400;"> is a common psychiatric condition, affecting as many as 5.3% of children between the ages of six and 17 years old. ADHD is associated with sleep problems, and research also suggests that sleep disturbances may be a predictor or even a contributor to symptoms of the condition. Studies have found that between 25% and 55% of children who have ADHD also experience sleep disturbances.</span></p>
<p>&nbsp;</p>
<p><span style="font-weight: 400;">How to overcome?</span></p>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Limit napping.</strong><span style="font-weight: 400;"> Too much sleep during the day can have an effect on your ability to fall or stay asleep at night. Naps of 20 to 30 minutes a day can help you feel more alert and rested without interrupting your nightly sleep.</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Establish a nightly routine.</strong><span style="font-weight: 400;"> Stick to a set of habits that help prepare you for rest each night. Take a bath, read a book, or practice a few minutes of meditation to calm your body. Repeat these routines each night to help set the mood for a solid night&rsquo;s sleep.</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Avoid caffeine or stimulants too close to bedtime.</strong><span style="font-weight: 400;"> Consuming coffee, soda, or other caffeinated products in the late afternoon or evening can make it difficult to fall asleep.</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Turn off your devices. </strong><span style="font-weight: 400;">Watching television or playing on your phone at bedtime can make it more difficult to relax and settle down for sleep. Try setting limits on when you quit using your devices before bed.</span></li>
</ul>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><span style="font-weight: 400;">The effects of sleep deprivation on physical health include:</span></p>
<ul>
<li style="font-weight: 400;" aria-level="1"><span style="font-weight: 400;">Obesity: Studies have found sleep loss can increase your risk of becoming obese. Your body produces and regulates various hormones during sleep. These include ghrelin, which makes you feel hungry, and leptin, which makes you feel full. Lack of sleep can cause your ghrelin levels to increase and leptin levels to decrease, meaning you are more likely to feel excessively hungry&nbsp; and overeat.</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Heart Problems:</strong><span style="font-weight: 400;"> Blood pressure is generally reduced during sleep.&nbsp; Thus, decreased sleep can lead to a higher daily average blood pressure, which in turn may increase your risk of heart disease and stroke. Inadequate sleep has also been linked to </span><a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2661105/"><span style="font-weight: 400;">coronary artery calcification</span><span style="font-weight: 400;">3</span></a><span style="font-weight: 400;">, a major predictor for coronary heart disease.</span></li>
<li style="font-weight: 400;" aria-level="1"><strong>Insulin management:</strong><span style="font-weight: 400;"> Insulin is a natural bodily hormone that regulates your glucose (or blood sugar) level. Sleep deprivation can affect how your body reacts to insulin and cause your glucose level to rise, which in turn puts you at higher risk for </span><a href="https://jamanetwork.com/journals/jamainternalmedicine/fullarticle/410883"><span style="font-weight: 400;">developing Type 2 diabetes</span><span style="font-weight: 400;">4</span></a><span style="font-weight: 400;">. Similarly, reduced sleep or poor sleep quality may adversely affect glucose control in known diabetics.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Immunohealth:</strong><span style="font-weight: 400;"> During sleep, there is a peak in the number of certain T-cells, various cytokines, and other </span><a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3256323/"><span style="font-weight: 400;">important components of your immune system</span><span style="font-weight: 400;">5</span></a><span style="font-weight: 400;">. Not getting enough sleep can affect </span><a href="https://www.sleepfoundation.org/sleep-news/can-we-fight-superbugs-with-sleep"><span style="font-weight: 400;">how the immune system responds</span></a><span style="font-weight: 400;"> to viruses and other infections. Long-term reduction in sleep can also lead to persistent low-level inflammation throughout the body, which underlies many chronic medical conditions.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Cognitive Performance:</strong><span style="font-weight: 400;"> A good night&rsquo;s sleep can improve your ability to concentrate, be creative, and learn new skills. People who don&rsquo;t get enough rest often have a hard time paying attention and are more likely to commit errors at work or in school.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Memory Consolidation:</strong><span style="font-weight: 400;"> Sleep is essential for </span><a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3768102/"><span style="font-weight: 400;">processing memories</span><span style="font-weight: 400;">6</span></a><span style="font-weight: 400;">. During the third non-rapid eye movement stage of your sleep cycle &ndash; also known as slow-wave sleep &ndash; your brain begins organizing and consolidating memories. The rapid eye movement stage that follows may help to cement these memories. As a result, not getting enough sleep can affect your ability to remember important details.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Mood:</strong><span style="font-weight: 400;"> People who don&rsquo;t get enough sleep may have a harder time controlling their emotions, making good decisions, and coping with different aspects of daily life. Sleep deficiency can also lead to mental health issues, such as depression and increase one&rsquo;s risk of suicide.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Growth and Development:</strong><span style="font-weight: 400;"> For children and adolescents, deep sleep triggers the release of hormones that promote healthy growth, increase muscle mass, regulate puberty and fertility, and repair cells and tissues. Children who don&rsquo;t receive enough sleep may feel angry or sad, struggle with school work, and have a hard time engaging with their peers in positive ways.</span></li>
</ul>
<ul>
<li style="font-weight: 400;" aria-level="1"><strong>Safety:</strong> <a href="https://www.nhtsa.gov/risky-driving/drowsy-driving"><span style="font-weight: 400;">Drowsy driving</span><span style="font-weight: 400;">7</span></a><span style="font-weight: 400;"> is a major road hazard for U.S. drivers. Sleep deficiency can reduce one&rsquo;s reaction time and lead to falling asleep behind the wheel. People who don&rsquo;t get enough sleep are also at higher risk of being involved in a workplace accident.</span></li>
</ul>
<p><span style="font-weight: 400;">The </span><a href="https://www.sleepfoundation.org/how-sleep-works/how-much-sleep-do-we-really-need"><span style="font-weight: 400;">amount of sleep you need</span></a><span style="font-weight: 400;"> changes with age. Newborns and infants require as much as 15 to 17 hours of sleep per night, whereas teenagers can usually get by with eight to ten hours. Adults between the ages of 18 and 64 generally need seven to nine hours. After reaching 65, this amount drops slightly to seven or eight hours.</span></p>
<p>&nbsp;</p>
<p><span style="font-weight: 400;">The importance of sleep hygiene</span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<ul>
<li style="font-weight: 400;" aria-level="1"><span style="font-weight: 400;">Healthy Habits: Moderate exercise and a healthy diet can improve your sleep quality and help you sleep longer at night. People who have a hard time getting enough sleep should avoid smoking altogether, and also refrain from drinking alcohol or consuming caffeine in the hours leading up to bed. Dining late in the evening &ndash; especially large meals &ndash; can negatively impact sleep as well.</span></li>
</ul>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><span style="font-weight: 400;">How does long sleep hours effect the health ?</span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><span style="font-weight: 400;">Other possible causes of oversleeping include the use of certain substances, such as alcohol and some prescription medications. Other medical conditions, including depression, can cause people to oversleep. And then there are people who simply want to sleep a lot.</span></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><span style="font-weight: 400;">Read more:</span></p>
<ul>
<li><a href="https://www.webmd.com/sleep-disorders/physical-side-effects-oversleeping#:~:text=Other%20possible%20causes%20of%20oversleeping,want%20to%20sleep%20a%20lot"><span style="font-weight: 400;">https://www.webmd.com/sleep-disorders/physical-side-effects-oversleeping#:~:text=Other%20possible%20causes%20of%20oversleeping,want%20to%20sleep%20a%20lot</span></a><span style="font-weight: 400;">.</span></li>
<li><a href="https://www.sleepfoundation.org/how-sleep-works/oversleeping"><span style="font-weight: 400;">https://www.sleepfoundation.org/how-sleep-works/oversleeping</span></a></li>
</ul>
<p><span style="font-weight: 400;">&nbsp;</span><span style="font-weight: 400;">&nbsp;</span></p>
<h1 style="color: #5e9ca0;"><br /><br style="font-weight: 400;" /><br /></h1>
          """,
  );
}
