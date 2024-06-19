import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'doik App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
          ),
          textTheme: TextTheme(
            displayMedium: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
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

  // 추가: 음악 추천 및 좋아요 기능
  var currentMusic = "Music 1";
  var favoriteMusics = <String>[];

  void getNextMusic() {
    // 여기서 실제 음악 추천 로직을 구현할 수 있습니다.
    var musics = ["Music 1", "Music 2", "Music 3", "Music 4", "Music 5"];
    currentMusic = musics[Random().nextInt(musics.length)];
    notifyListeners();
  }

  void toggleFavoriteMusic() {
    if (favoriteMusics.contains(currentMusic)) {
      favoriteMusics.remove(currentMusic);
    } else {
      favoriteMusics.add(currentMusic);
    }
    notifyListeners();
  }
}

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
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = music(); // music추천
        break;
      case 3:
        page = ProjectPage(); // project 페이지 추가
        break;
      case 4:
        page = Schedule();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Introduction App'), // 앱 제목
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                height: 80,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorites'),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note_sharp),
                title: Text('music'),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Projects'),
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.schedule),
                title: Text('Schedule'),
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
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
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            color: Color(0xFF4A90E2),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/doik.jpg'), // 로컬 이미지 파일 경로
                  ),
                  SizedBox(height: 16),
                  Text(
                    '김도익',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '단국대학교 모바일시스템공학과 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Divider(color: Colors.white),
                  SizedBox(height: 16),
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    '화성시 석우동 6-4',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Icon(Icons.phone, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    '010-2415-3551',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      launchUrl('https://github.com/yourgithub'); // 깃허브 링크
                    },
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.github, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          '깃허브',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          'https://instagram.com/yourinstagram'); // 인스타그램 링크
                    },
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.instagram, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          '인스타',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'KIM DO IK',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '백엔드와 프론트엔드 개발에 대한 열정으로 가득 찬 저는 임베디드 시스템의 복잡성을 마스터하는 것을 목표로 하는 개발자입니다. 기술 분야에서의 저의 여정은 지식과 혁신을 끊임없이 추구하며 디지털 영역의 한계를 계속해서 넓혀가고 있습니다. 소프트웨어와 하드웨어의 격차를 해소하는 것을 열망하며, 저의 기술을 활용하여 일상생활에 원활하게 통합되는 획기적인 솔루션을 창출하는 데 전념하고 있습니다. 임베디드 시스템의 세계를 더욱 깊이 탐구하면서, 기술의 발전에 기여하고 산업에 의미 있는 변화를 가져오는 데 지속적으로 영향을 미치는 것을 목표로 하고 있습니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'STACKS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.c, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('C'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.c, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('C++'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.python, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('Python'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.java, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('JAVA'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.html5, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('HTML5'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.css3, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('CSS3'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.github, color: Color(0xFF4A90E2)),
                      SizedBox(width: 8),
                      Text('Github'),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'WORK EXPERIENCE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(height: 16),
                  ExperienceItem(
                    date: '2012-06 ~ 2012-07',
                    title: '프로젝트 혹은 경력사항 첫 번째',
                    description: '기획 디자이너를 맡아 해당 경력사항을 수행하였습니다.',
                  ),
                  ExperienceItem(
                    date: '2013-10 ~ 2013-11',
                    title: '프로젝트 혹은 경력사항 두 번째',
                    description: '기획 디자이너를 맡아 해당 경력사항을 수행하였습니다.',
                  ),
                  ExperienceItem(
                    date: '2013-12 ~ 2014-01',
                    title: '프로젝트 혹은 경력사항 세 번째',
                    description: '기획 디자이너를 맡아 해당 경력사항을 수행하였습니다.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ExperienceItem extends StatelessWidget {
  final String date;
  final String title;
  final String description;

  const ExperienceItem({
    Key? key,
    required this.date,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 12, color: Color(0xFF4A90E2)),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pair.asLowerCase,
              style: style,
              semanticsLabel: "${pair.first} ${pair.second}",
            ),
            SizedBox(height: 10),
            Text(
              'Here is a cool random word pair!',
              style: theme.textTheme.subtitle1!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty && appState.favoriteMusics.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        if (appState.favorites.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                'You have ${appState.favorites.length} word pair favorites:'),
          ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(pair.asLowerCase),
          ),
        if (appState.favoriteMusics.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                'You have ${appState.favoriteMusics.length} music favorites:'),
          ),
        for (var music in appState.favoriteMusics)
          ListTile(
            leading: Icon(Icons.music_note,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(music),
          ),
      ],
    );
  }
}

class music extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('노래 추천'),
        ),
        titleTextStyle: TextStyle(color: Colors.indigo, fontSize: 25),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '현재 추천 음악: ${appState.currentMusic}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  appState.getNextMusic();
                },
                child: Text('다음 음악 추천'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  appState.toggleFavoriteMusic();
                },
                child: Text(
                    appState.favoriteMusics.contains(appState.currentMusic)
                        ? '좋아요 취소'
                        : '좋아요'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('Computer Architecture'),
            subtitle: Text('MIPS 에뮬레이터 구현'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ComputerArchitecturePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.objectGroup),
            title: Text('Embedded System'),
            subtitle: Text('YOLOv8을 이용한 얼굴인식 프로그램'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmbeddedSystemPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.mobileButton),
            title: Text('Mobile'),
            subtitle: Text('Display mobile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MobilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.networkWired),
            title: Text('Computer Network'),
            subtitle: Text('소캣 프로그래밍'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NetworkPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.music),
            title: Text('Song Day Picker'),
            subtitle: Text('음악발매 날짜 추천 프로그램'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SongPage()),
              );
            },
          )
        ],
      ),
    );
  }
}

class ComputerArchitecturePage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'simple calculator',
      description: 'C언어로 MIPS의 emulator 구현',
      technologies: 'C, MIPS',
      role: 'Lead Developer',
      link: 'https://github.com/DoIkk/simplecalculator',
    ),
    Project(
      title: 'single cycle',
      description: 'C언어로 MIPS의 single cylce emulator 구현',
      technologies: 'C, MIPS',
      role: 'Lead Developer',
      link: 'https://github.com/DoIkk/single-cycle',
    ),
    Project(
      title: 'pipeline',
      description: 'C언어로 MIPS의 pipeline emulator 구현',
      technologies: 'C, MIPS',
      role: 'Lead Developer',
      link: 'https://github.com/DoIkk/pipeline',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Architecture'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String technologies;
  final String role;
  final String link;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.role,
    required this.link,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              project.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Technologies: ${project.technologies}',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              'Role: ${project.role}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _launchURL(context, project.link),
              child: Text(
                'Project Link',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) {
    // Implement your link launching logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Link: $url')),
    );
  }
}

class EmbeddedSystemPage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'Sensor Network',
      description: '센서 네트워크 시스템 구현',
      technologies: 'C, Arduino',
      role: 'Developer',
      link: 'https://github.com/yourusername/project3',
    ),
    Project(
      title: 'Embedded OS',
      description: '간단한 임베디드 운영체제 개발',
      technologies: 'C, ARM',
      role: 'Lead Developer',
      link: 'https://github.com/yourusername/project4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Embedded System'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

class MobilePage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'Flutter App',
      description: 'Flutter로 모바일 앱 개발',
      technologies: 'Flutter, Dart',
      role: 'Lead Developer',
      link: 'https://github.com/yourusername/project5',
    ),
    Project(
      title: '자기소개 웹페이지',
      description: 'HTML을 사용한 자기소개 웹페이지',
      technologies: 'HTML, CSS',
      role: 'Developer',
      link: 'https://github.com/DoIkk/Mid-Term-Project',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

class NetworkPage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'C/S 방식의 소켓프로그래밍',
      description: '사칙연산을 하는 클라이언트, 서버 방식의 소켓 프로그래밍',
      technologies: 'Python',
      role: 'Lead Developer',
      link: 'https://github.com/DoIkk/computer-network-Client-Server',
    ),
    Project(
      title: 'Local DNS 서버 구현',
      description: '상위 레벨 DNS 와 Local DNS, client를 구현한 프로그램',
      technologies: 'Python, MySQL',
      role: 'Developer',
      link: 'https://github.com/yourusername/project6',
    ),
    Project(
      title: 'Link State알고리즘을 사용한 C/S 프로그램',
      description:
          'Intra Routing 알고리즘인 Link State 알고리즘을 사용하여 shortest path를 구하는 C/S 프로그램을 작성',
      technologies: 'Python',
      role: 'Developer',
      link: 'https://github.com/yourusername/project6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Network'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

class SongPage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'Song Day Picker',
      description: 'AI를 활용한 음악 발매일 추천 프로그램',
      technologies: 'Python, MySQL',
      role: '데이터 전처리, 모델 학습',
      link: 'https://github.com/DoIkk/SongDayPicker',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Network'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

const List<String> week = ['월', '화', '수', '목', '금'];
const int kColumnLength = 22;
const double kFirstColumnHeight = 20;
const double kBoxSize = 52;

class Lecture {
  String lname;
  List<String> day;
  List<int> start;
  List<int> end;
  List<String> classroom;
  Color color; // 추가된 속성

  Lecture(
      this.lname, this.day, this.start, this.end, this.classroom, this.color);
}

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<Lecture> selectedLectures = [
    Lecture('컴퓨터구조론', ['월', '화'], [0, 90], [90, 180], ['2공 524', '2공 524'],
        Colors.green),
    Lecture('모바일이동통신', ['월', '화'], [90, 240], [180, 330],
        ['국제관 608', '국제관 608'], Colors.blue),
    Lecture('알고리즘및인공지능', ['월', '목'], [300, 360], [390, 450],
        ['국제관 506', '국제관 506'], Colors.orange),
    Lecture(
        '임베디드시스템', ['수'], [420], [600], ['국제관 205', '국제관 205'], Colors.purple),
    Lecture('오픈소스SW활용', ['목'], [0], [180], ['소프트 516', '소프트 516'], Colors.red),
    Lecture('컴퓨터네트워크(SW))', ['금'], [420], [600], ['소프트 516', '소프트 516'],
        Colors.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: kColumnLength / 2 * kBoxSize + kColumnLength,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    buildTimeColumn(),
                    ...buildDayColumn(0),
                    ...buildDayColumn(1),
                    ...buildDayColumn(2),
                    ...buildDayColumn(3),
                    ...buildDayColumn(4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int index) {
    String currentDay = week[index];
    List<Widget> lecturesForTheDay = [];

    for (var lecture in selectedLectures) {
      for (int i = 0; i < lecture.day.length; i++) {
        double top = kFirstColumnHeight + (lecture.start[i] / 60.0) * kBoxSize;
        double height = ((lecture.end[i] - lecture.start[i]) / 60.0) * kBoxSize;

        if (lecture.day[i] == currentDay) {
          lecturesForTheDay.add(
            Positioned(
              top: top,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: height,
                decoration: BoxDecoration(
                  color: lecture.color, // 색상 적용
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                ),
                child: Text(
                  "${lecture.lname}\n${lecture.classroom[i]}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          );
        }
      }
    }

    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    '${week[index]}',
                  ),
                ),
                ...List.generate(
                  kColumnLength,
                  (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
            ...lecturesForTheDay, // 현재 요일에 해당하는 모든 강의를 Stack에 추가
          ],
        ),
      ),
    ];
  }
}
