import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation _profilePictureAnimation;
  late final Animation _contentAnimation;
  late final Animation _listAnimation;
  late final Animation _fabAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _profilePictureAnimation = Tween(begin: 0.0, end: 50.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.20, curve: Curves.easeOut)));
    _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.20, 0.40, curve: Curves.easeOut)));
    _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.40, 0.75, curve: Curves.easeOut)));
    _fabAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.75, 1.0, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.supervised_user_circle),
          color: Colors.black,
          onPressed: () {},
          iconSize: _profilePictureAnimation.value,
        ),
      ],
      elevation: 0.0,
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Good Morning",
                  style: TextStyle(
                      fontSize: _contentAnimation.value,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "Here are your plans for today",
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Opacity(
            opacity: _listAnimation.value,
            child: ListView.builder(
              itemBuilder: (context, position) {
                return CheckboxListTile(
                  title: Text("This is item $position"),
                  value: true,
                  onChanged: (val) {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return Transform.scale(
      scale: _fabAnimation.value,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
