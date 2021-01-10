import 'dart:math';

import 'package:flutter/cupertino.dart';

dynamic backgroundImages = [
  "lib/assets/background/BG01.jpg",
  "lib/assets/background/BG02.jpg",
  "lib/assets/background/BG03.jpg",
  "lib/assets/background/BG04.jpg",
  "lib/assets/background/BG05.jpg",
  "lib/assets/background/BG06.jpg",
  "lib/assets/background/BG07.jpg",
];

String getBGImage() {
  int min = 0;
  int max = backgroundImages.length-1;
  Random rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  return backgroundImages[r].toString();
}