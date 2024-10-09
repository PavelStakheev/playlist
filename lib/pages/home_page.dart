import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three/components/my_drawer.dart';
import 'package:three/models/playlist_provider.dart';
import 'package:three/models/song.dart';
import 'package:three/pages/song_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    late final dynamic playlist_provider;

    void initState(){
      super.initState();
      playlist_provider = Provider.of<PlaylistProvider>(context, listen: false);
    }

void goToSong(int songIndex){
  playlist_provider.currentSongIndex = songIndex;

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SongPage())
  );
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('P L A Y L I S T'),),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) { 
          final List<Song> playlist = value.playlist;
          
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context,index){
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
                );
            });} 
     ),
      
      
    );
  }
}