import 'package:flutter/material.dart';
import 'azkar_page.dart';
import 'summary_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedAzkarType = 'صباحًا'; // Default selection
  bool isNightMode = false; // Night mode state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AzkarApp(
        isNightMode: isNightMode,
        updateNightModeCallback: updateNightMode,
      ),
    );
  }

  void updateNightMode(bool isNightMode) {
    setState(() {
      this.isNightMode = isNightMode;
    });
  }
}

class AzkarApp extends StatefulWidget {
  final bool isNightMode;
  final Function(bool) updateNightModeCallback;

  AzkarApp({
    required this.isNightMode,
    required this.updateNightModeCallback,
  });

  @override
  _AzkarAppState createState() => _AzkarAppState();
}

class _AzkarAppState extends State<AzkarApp> {
  String selectedAzkarType = 'صباحًا'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أذكار مسلم'.toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(widget.isNightMode ? Icons.brightness_3 : Icons.brightness_7),
            onPressed: () {
              widget.updateNightModeCallback(!widget.isNightMode);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RadioListTile<String>(
                title: Text(
                  'صباحًا',
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
                value: 'صباحًا',
                groupValue: selectedAzkarType,
                onChanged: (value) {
                  setState(() {
                    selectedAzkarType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'مساءً',
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
                value: 'مساءً',
                groupValue: selectedAzkarType,
                onChanged: (value) {
                  setState(() {
                    selectedAzkarType = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarPage(
                        azkarType: selectedAzkarType,
                        azkarList: selectedAzkarType == 'صباحًا'
                            ? [
                          "أصبحنا وأصبح المـلك لله و الحمدلله و لا اله الا الله وحده لا شريك له له الملك و له الحمد و هو على كل شيء قدير",
                          "اللهـم مااصبح بي من نعمة او باحد من خلقك فمنك وحدك لا شريك لك فلك الحمد و لك الشكر ",
                          "اللهـم إنـي أصبحت أشـهدك و اشهد حملة عرشك و ملائكتك و جميع خلقك بانك انت الله وحدك لا شريك لك و ان محمدا عبدك و رسولك",
                        ]
                            : [
                          "أمسيـنا وأمسـى المـلك لله و الحمدلله و لا اله الا الله وحده لا شريك له له الملك و له الحمد و هو على كل شيء قدير",
                          "اللهـم ماامسى بي من نعمة او باحد من خلقك فمنك وحدك لا شريك لك فلك الحمد و لك الشكر ",
                          "اللهـم إنـي أمسيت أشـهدك و اشهد حملة عرشك و ملائكتك و جميع خلقك بانك انت الله وحدك لا شريك لك و ان محمدا عبدك و رسولك",
                        ],
                        isNightMode: widget.isNightMode,
                        updateNightModeCallback: widget.updateNightModeCallback,
                      ),
                    ),
                  );
                },
                child: Text('المتابعة'.toUpperCase()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryPage(
                        morningAzkar: [
                          "أصبحنا وأصبح المـلك لله و الحمدلله و لا اله الا الله وحده لا شريك له له الملك و له الحمد و هو على كل شيء قدير",
                          "اللهـم مااصبح بي من نعمة او باحد من خلقك فمنك وحدك لا شريك لك فلك الحمد و لك الشكر ",
                          "اللهـم إنـي أصبحت أشـهدك و اشهد حملة عرشك و ملائكتك و جميع خلقك بانك انت الله وحدك لا شريك لك و ان محمدا عبدك و رسولك"
                        ],
                        eveningAzkar: [
                          "أمسيـنا وأمسـى المـلك لله و الحمدلله و لا اله الا الله وحده لا شريك له له الملك و له الحمد و هو على كل شيء قدير",
                          "اللهـم ماامسى بي من نعمة او باحد من خلقك فمنك وحدك لا شريك لك فلك الحمد و لك الشكر ",
                          "اللهـم إنـي أمسيت أشـهدك و اشهد حملة عرشك و ملائكتك و جميع خلقك بانك انت الله وحدك لا شريك لك و ان محمدا عبدك و رسولك",
                        ],
                      ),
                    ),
                  );
                },
                child: Text('عرض الملخص'.toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}