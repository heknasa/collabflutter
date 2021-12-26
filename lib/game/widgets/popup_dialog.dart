import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import '../game_core.dart';
import '../helpers/dpad.dart';
import '../widgets/qna_pad.dart';

class PopUpDialog extends StatelessWidget {
  static const id = 'pop up dialog';
  final GameCore gameRef;
  const PopUpDialog(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    if (gameRef.enemies.isEmpty) {
      FlameAudio.bgm.pause();
      FlameAudio.play('win.wav');
    }    
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        padding: EdgeInsets.all(20.0),
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(gameRef.popUpTitle!),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (gameRef.popUpTitle == 'Ready?') {                    
                    gameRef.overlays.remove(PopUpDialog.id);
                    if (platform == TargetPlatform.android
                      || platform == TargetPlatform.iOS                      
                    ) {
                      gameRef.overlays.add(DPad.id);
                      gameRef.overlays.add(QnAPad.id);
                      gameRef.gamerIsOnMobile = true;
                    }
                    else if (
                      platform == TargetPlatform.windows
                      || platform == TargetPlatform.macOS
                      || platform == TargetPlatform.linux
                    ) {
                      gameRef.gamerIsOnPC = true;
                    }
                    FlameAudio.bgm.play('bgm.ogg', volume: 0.5);
                    gameRef.roundCountdown.start();
                  } else if (
                    gameRef.popUpTitle == 'game over...'
                    || gameRef.popUpTitle == 'YOU WIN!!\nPlay Again?'
                  ) {
                    gameRef.overlays.remove(PopUpDialog.id);
                    if (platform == TargetPlatform.android
                      || platform == TargetPlatform.iOS                      
                    ) {
                      gameRef.overlays.add(DPad.id);
                      gameRef.overlays.add(QnAPad.id);
                    }
                    FlameAudio.bgm.resume();
                    gameRef.reset();    
                  }
                },
                child: Text('YES')
              )
            ],
          )
        )
      ),
    );
  }
}