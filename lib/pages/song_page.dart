import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three/components/new_box.dart';
import 'package:three/models/playlist_provider.dart';


class SongPage extends StatelessWidget {
  const SongPage({super.key});
  //convert duration into min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {

      //get playlist
      final playlist = value.playlist;


      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];



        return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          
          padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // app bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          
                Text('P L A Y L I S T'),
          
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              ],
            ),
            //album artwork
          NewBox(
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(currentSong.albumArtImagePath)
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(currentSong.songName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        Text(currentSong.artistName)
                      ],
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                
                  ],
                ),
              )
            ],)
          ),
          const SizedBox(height: 25),
            //song duration progress
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   Text(formatTime(value.currentDuration)),
                   Icon(Icons.shuffle),
                   Icon(Icons.repeat),
                   Text(formatTime(value.totalDuration))
                
                 ],),
              ),
               SliderTheme(data: SliderTheme.of(context).copyWith(
                thumbShape: 
                const RoundSliderThumbShape(enabledThumbRadius: 0)
               ), child: Slider(
                     min: 0,
                     max: value.totalDuration.inSeconds.toDouble(),
                     value: value.currentDuration.inSeconds.toDouble(),
                     activeColor: Colors.green, 
                     onChanged: (double double) {

                     },
                     onChangeEnd: (double double) =>
                     value.seek(Duration(seconds: double.toInt()))
                     ))
            ],
          ),

         
            // playback controls

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: value.previousSong,
                    child: const NewBox(
                      child: Icon(Icons.skip_previous),),
                  )
                  ),
                  const SizedBox(width: 20,),
                   Expanded(
                    flex: 2,
                  child: GestureDetector(
                    onTap: value.pauseOrResume,
                    child: NewBox(
                      child: Icon(value.isPlaying ? Icons.pause: Icons.play_arrow),),
                  )
                  ),
                  const SizedBox(width: 20,),
                   Expanded(
                  child: GestureDetector(
                    onTap: value.playNextSong,
                    child: const NewBox(
                      child: Icon(Icons.skip_next),),
                  )
                  )
               
              ],
            )
          ],
          ),
        ),
      ),
    );
      }
    );
  }
}