import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'TigerScout',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
    void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}




// ...

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
      case 1:
        page = DataAnalysisPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');

    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                
                extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.analytics),
                      label: Text('Analyze Data'),
                    ),
                  ],
                  selectedIndex: selectedIndex,   
                  onDestinationSelected: (value) {
        
                    // ↓ Replace print with this.
                    setState(() {
                      selectedIndex = value;
        
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                 showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                title: Text("Settings"),
                    
                
                actions: <Widget>[
                  SettingsContent(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                )
          ]
          )
            );
              },
                icon: Icon(Icons.settings_outlined),
                label: Text('Settings'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScoutPage())
                  );
                  },
                icon: Icon(Icons.search),
                label: Text('Scout Match'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

  
    return Settings();

    
  }
}
class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();

}
class _SettingsState extends State<Settings> {
  
  int brightnesSettings = 50;
  int volumeSettings = 0;
  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        Slider(
          label: "Brightness",   
          value: brightnesSettings.toDouble(),
          onChanged: (value) {
              setState(() {
                  brightnesSettings = value.toInt(); 

              });

          },  
          min: 0.0,
          max: 100.0,
           ),
           Slider(
          label: "Volume",
          value: volumeSettings.toDouble(),
          onChanged: (value) {
            setState(() {
                  volumeSettings = value.toInt(); 

            });
           
          },
          min: 0,
          max: 100,
           ),
      ],
    );
  }
}

class DataAnalysisPage extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);    

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    // TODO: add data analysis
    return comingSoon(theme, style);
    }

  Center comingSoon(ThemeData theme, TextStyle style) {
    return Center(
    child: Card(
      color: theme.colorScheme.primary,  
      child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text("Coming Soon!", style: style),
      )
    ),
  );
  }
}
// ...

class ScoutPage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);    

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    // TODO: add scout page
    return comingSoon(theme, style);
  }
  Center comingSoon(ThemeData theme, TextStyle style) {
    return Center(
    child: Card(
      color: theme.colorScheme.primary,  
      child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text("Coming Soon!", style: style),
      )
    ),
  );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);    

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(

      color: theme.colorScheme.primary,  
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("TigerScout", style: style),
      ),
    );
  }
}
