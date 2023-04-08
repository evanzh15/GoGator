import processing.sound.*;
class Sounds {
  SoundFile[] sFiles = new SoundFile[8];
  SoundFile currSound;
  Sounds() {
      sFiles[0] = new SoundFile(GoGator.this, "albertDeath1.wav");
      sFiles[1] = new SoundFile(GoGator.this, "backgroundMusic1.wav");
      sFiles[2] = new SoundFile(GoGator.this, "backgroundMusic2.wav");
      sFiles[3] = new SoundFile(GoGator.this, "backgroundMusic3.wav");
      sFiles[4] = new SoundFile(GoGator.this, "collectChomp.wav");
      sFiles[1].loop();
      currSound = sFiles[1];
      currSound.amp(0.01);
  }
  
  void changeState(State prevState, State nextState) {
    if (prevState == State.MAIN_MENU && nextState == State.GAME) {
      currSound.stop();
      currSound = sFiles[2];
      currSound.loop();
      currSound.amp(0.01);
    } else if (prevState == State.GAME && nextState == State.ESCAPE_MENU) {
      currSound.pause();
    } else if (prevState == State.GAME && nextState == State.DEATH) {
      currSound.stop();
      currSound = sFiles[3];
      currSound.play();
      currSound.amp(0.01);
    } else if (prevState == State.ESCAPE_MENU && nextState == State.GAME) {
      currSound.play();
    } else if (prevState == State.DEATH && nextState == State.MAIN_MENU || 
    prevState == State.ESCAPE_MENU && nextState == State.MAIN_MENU) {
      currSound.stop();
      currSound = sFiles[1];
      currSound.play();
      currSound.amp(0.01);
    }
  }
  
  void playSound(SoundFile sound) {
    sound.play();
    sound.amp(0.01);
  }
}
