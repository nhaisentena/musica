import 'package:flutter/material.dart';
import 'package:player_musica/model/Musica_Model.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMusica extends StatelessWidget {
  final MusicaModel musicaC;
  final VoidCallback onPressed;
  final bool isPlaying;
  final bool isSelected;

  const CardMusica({
    required this.musicaC,
    required this.onPressed,
    required this.isPlaying,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            "https://cdn-icons-png.flaticon.com/512/240/240136.png",
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.music_note),
          ),
        ),
        title: Text(
          musicaC.title,
          style: GoogleFonts.lobster(
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(musicaC.author),
        trailing: IconButton(
          icon: Icon(
            isSelected
                ? (isPlaying ? Icons.pause : Icons.play_arrow)
                : Icons.play_arrow,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
