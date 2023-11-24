import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AzkarApp(),
    );
  }
}

class AzkarApp extends StatefulWidget {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RadioListTile<String>(
              title: Text('صباحًا'),
              value: 'صباحًا',
              groupValue: selectedAzkarType,
              onChanged: (value) {
                setState(() {
                  selectedAzkarType = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('مساءً'),
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
                        "أصـبحنا وأصـبح المـلك لله والحمد لله...",
                        "اللهـم إنـي أصبـحت أشـهدك...",
                        "اللهـم ما أصبـح بي مـن نعـمة...",
                      ]
                          : [
                        "أمسيـنا وأمسـى المـلك لله...",
                        "اللهـم أنت ربـي لا إله إلا أنت...",
                        "اللهـم إنـي أمسيت أشـهدك...",
                      ],
                    ),
                  ),
                );
              },
              child: Text('المتابعة'.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

class AzkarPage extends StatefulWidget {
  final String azkarType;
  final List<String> azkarList;

  AzkarPage({required this.azkarType, required this.azkarList});

  @override
  _AzkarPageState createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  int currentIndex = 0;
  TextEditingController azkarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.azkarType.toUpperCase()),
      ),
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    widget.azkarList[currentIndex].toUpperCase(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex < widget.azkarList.length - 1) {
                          currentIndex++;
                        } else {
                          currentIndex = 0;
                        }
                      });
                    },
                    child: Text('Next'.toUpperCase()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await _showAddAzkarDialog(context);
              },
              child: Text('إضافة ذكر جديد'.toUpperCase()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAzkarDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة ذكر جديد'),
          content: TextField(
            controller: azkarController,
            decoration: InputDecoration(labelText: 'اكتب الذكر هنا'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                String newAzkar = azkarController.text;
                if (newAzkar.isNotEmpty) {
                  Navigator.pop(context);
                  setState(() {
                    widget.azkarList.add(newAzkar);
                  });
                }
              },
              child: Text('إضافة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}