import 'package:flutter/material.dart';
import 'package:player_musica/model/Musica_Model.dart';
import 'package:player_musica/service/Musica_Player_Service.dart';
import 'package:player_musica/service/Musica_Service.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:player_musica/widget/Card_Musica.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.farteche.channel.audio',
    androidNotificationChannelName: 'Reproductor de Música',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 154, 187),
        ),
      ),
      home: const MyHomePage(title: 'Reproductor de Música'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final playerService = MusicaPlayerService();
  List<MusicaModel> musicas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarMusica();
  }

  void cargarMusica() async {
    try {
      musicas = await MusicaService.fetchMusicas();
    } catch (e) {
      print('Error al cargar canciones: $e');
    } finally {
      setState(() => cargando = false);
    }
  }

  @override
  void dispose() {
    playerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 154, 187),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 189, 255, 214),
              Color.fromARGB(255, 255, 154, 187),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: playerService.isPlaying,
          builder: (context, isPlaying, _) {
            return ListView.builder(
              itemCount: musicas.length,
              itemBuilder: (context, index) {
                final musica = musicas[index];
                final isSelected = playerService.musicaAtual?.url == musica.url;

                return CardMusica(
                  musicaC: musica,
                  isPlaying: isPlaying,
                  isSelected: isSelected,
                  onPressed: () => playerService.PlayPausa(musica),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
