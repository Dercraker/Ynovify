import 'package:flutter/material.dart';
import 'music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ynovify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 43, 43, 43),
      ),
      home: const MyHomePage(title: 'Ynovify'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = true;
  int selectMusic = 0;

  List<Music> myMusicList = [
    Music(
      'Never Gonna Give You Up',
      'Rick Astley',
      'assets/img/rickroll.jpg',
      'http://tinyurl.com/s63ve48'),
    Music(
      'Enemy',
      'Imagine Dragons',
      'assets/img/Arcane-photo.jpeg',
      'https://music.florian-berthier.com/Enemy%20-%20Imagine%20Dragons.mp3'),
  ];

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _init(selectMusic);
  }

  void _incrementMusicCounter() {
    setState(() {
      (selectMusic == myMusicList.length - 1) ? selectMusic = 0 : selectMusic++;
    });
    _init(selectMusic);
  }

  void _decrementMusicCounter() {
    setState(() {
      (selectMusic == 0) ? selectMusic = myMusicList.length - 1 : selectMusic--;
    });
    _init(selectMusic);
  }

  Future<void> _init(int selectMusic) async {
    await _player
        .setAudioSource(
            AudioSource.uri(Uri.parse(myMusicList[selectMusic].urlSong)))
        .then((value) => {
              setState(() {
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Image.asset(myMusicList[selectMusic].imagePath),
                )
                // child: Image.asset(myMusicList[selectMusic].imagePath),
                ),
            Text(
              myMusicList[selectMusic].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 0, 255),
              ),
            ),
            Text(
              myMusicList[selectMusic].singer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 17, 255),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      color: Colors.deepPurple,
                      icon: const Icon(Icons.fast_rewind),
                      onPressed: _decrementMusicCounter,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      color: Colors.deepPurple,
                      icon: Icon(selected ? Icons.play_arrow : Icons.pause),
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                          (selected ? _player.pause() : _player.play());
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      color: Colors.deepPurple,
                      icon: const Icon(Icons.fast_forward),
                      onPressed: _incrementMusicCounter,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
