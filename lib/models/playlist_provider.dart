import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:three/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  final List<Song> _playlist = [

    Song(
      songName: 'Why', 
      artistName: 'NANA', 
      albumArtImagePath: 'assets/nana.png', 
      audioPath: 'NanaWhy.mp3'),
      Song(
      songName: 'Lonely', 
      artistName: 'NANA', 
      albumArtImagePath: 'assets/nana.png', 
      audioPath: 'NanaWhy.mp3'),
      Song(
      songName: 'Darkness', 
      artistName: 'NANA', 
      albumArtImagePath: 'assets/nana.png', 
      audioPath: 'NanaWhy.mp3'),

  ];

int? _currentSongIndex;

/*

AUDIOPLAYERS

*/
//audioplayer
final AudioPlayer _audioPlayer = AudioPlayer();
//durations
Duration _currentDuration = Duration.zero;
Duration _totalDuration = Duration.zero;

//constructor

PlaylistProvider(){
  listenToDuration();
}

//initially not playing
bool _isPlaying = false;

//play the song
void play() async {
  final String path = _playlist[_currentSongIndex!].audioPath;
  await _audioPlayer.stop();//stop current song
  await _audioPlayer.play(AssetSource(path)); //play the new song
  _isPlaying = true;
  notifyListeners();
}

//pause current song
void pause() async {

  await _audioPlayer.pause(); //play the new song
  _isPlaying = false;
  notifyListeners();
}

//resume playing

void resume() async{
   await _audioPlayer.resume(); //play the new song
  _isPlaying = true;
  notifyListeners();
}

//seek to a specififc position in the current song
void seek(Duration position) async{
  await _audioPlayer.seek(position);
}

// playnext song

void playNextSong(){
  if (_currentSongIndex != null) {
    if (_currentSongIndex! < _playlist.length - 1){
      currentSongIndex = _currentSongIndex! + 1;
    }
    else{
      currentSongIndex = 0;
    }
  }
}

//play previous song
void previousSong() {
  if (_currentDuration.inSeconds > 2){
       seek(Duration.zero);
  }
  else{
    if (_currentSongIndex! > 0){
      currentSongIndex = _currentSongIndex! - 1;
    }
  }
}

//pause or resume

void pauseOrResume() async{
  if (_isPlaying){
    pause();
  }else{
    resume();
  }
  notifyListeners();
}

//listen to duration
void listenToDuration() {

  _audioPlayer.onDurationChanged.listen((newDuration) {
    _totalDuration = newDuration;
    notifyListeners();
   });

  _audioPlayer.onPositionChanged.listen((newPosition) {
    _currentDuration=newPosition;
     notifyListeners();
    
  });

  _audioPlayer.onPlayerComplete.listen((event) {
    playNextSong();
  });
}

//Возвращаем список

List<Song> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;

set currentSongIndex(int? newIndex){
  _currentSongIndex=newIndex;
  notifyListeners();

  if (newIndex != null){
    play();
  }
}

}

