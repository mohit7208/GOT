import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:got/episodes_page.dart';
import 'package:got/got.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      'http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes';
  GOT got;
  Widget myBody() {
    return got == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

  Widget myCard() {
    return SingleChildScrollView(
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Hero(
                  tag: 'g1',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(got.image.original),
                    radius: 70.0,
                  ),
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  got.name,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  'Runtime : ${got.runtime.toString()} minutes',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  got.summary,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpisodesPage(
                            episodes: got.eEmbedded.episodes,
                            image: got.image,
                          ),
                        ));
                  },
                  child: Text('All Episodes'),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 13.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    var res = await http.get(url);
    var decres = jsonDecode(res.body);
    print(decres);
    got = GOT.fromJson(decres);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Of Thrones'),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchEpisodes,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
