import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const bool isProd = bool.fromEnvironment('dart.vm.product');

const DevEnv = {
  'isProd': false,
  'apiBaseUri': 'http://localhost:8081',
};

const ProdEnv = {
  'isProd': true,
  'apiBaseUri': 'http://api.influ-dojo-stg.work:8080',
};

final env = isProd ? ProdEnv : DevEnv;

Future<String> greet() async {
  print(env['apiBaseUri']);
  final response = await http.get(env['apiBaseUri']);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("failed to hello");
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ECS Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> hello;

  @override
  void initState() {
    super.initState();
    hello = greet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
        future: hello,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
