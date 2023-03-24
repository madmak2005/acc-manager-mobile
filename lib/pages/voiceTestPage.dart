import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:io' show Platform;

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(SpeechSampleApp());

class SpeechSampleApp extends StatefulWidget {
  @override
  _SpeechSampleAppState createState() => _SpeechSampleAppState();
}

enum TtsState { playing, stopped, paused, continued }

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Map<String, int>? commandValue;
  Future<Map<String, KeySettings>>? _allKeys = conf.getAllKeys();
  late Map<String, KeySettings> keySetting;
//------------tts
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.6;
  double pitch = 0.9;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;
//--------------

  @override
  void initState() {
    super.initState();
    initKeySettings();
    Wakelock.enable();
    initTts();
    initSpeechState();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();
        var systemLocale = await speech.systemLocale();
        _localeNames.retainWhere((element) =>
            element.localeId.startsWith('pl') ||
            element.localeId.startsWith('en') ||
            element.localeId == systemLocale!.localeId);
        dev.log(_localeNames.toString());

        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) {
    flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    //dev.log("set language: $selectedType");
    setState(() {
      language = selectedType?.replaceFirst('_', '-');
      //dev.log("change to: $language");
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
        //dev.log("can we use it: $isCurrentLanguageInstalled ?");
        if (!isCurrentLanguageInstalled) {
          flutterTts.getLanguages.then((value) => listLanguages(value));
        }
      }
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Voice commands'),
        ),
        body: Column(children: [
          HeaderWidget(),
          Container(
            child: Column(
              children: <Widget>[
                InitSpeechWidget(_hasSpeech, initSpeechState),
                SpeechControlWidget(_hasSpeech, speech.isListening,
                    startListening, stopListening, cancelListening),
                SessionOptionsWidget(_currentLocaleId, _switchLang,
                    _localeNames, _logEvents, _switchLogging),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: RecognitionResultsWidget(lastWords: lastWords, level: level),
          ),
          Expanded(
            flex: 1,
            child: lastError.isNotEmpty
                ? ErrorWidget(lastError: lastError)
                : Container(),
          ),
          SpeechStatusWidget(speech: speech),
        ]),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    if (result.finalResult) {
      Map<String, int> detectedCommand = detectCommand(result);
      if (detectedCommand.keys.first != 'none' &&
          detectedCommand.keys.first.isNotEmpty &&
          detectedCommand.values.first != -1) {
        if (detectedCommand.keys.first == 'MAP' &&
            detectedCommand.values.first >= 0) {
          if (_currentLocaleId.startsWith('en'))
            _newVoiceText =
                'Setting engine map to ${detectedCommand.values.first.toString()}';
          else if (_currentLocaleId.startsWith('pl'))
            _newVoiceText =
                'Ustawiam mapę na pozycję: ${detectedCommand.values.first.toString()}';
          //dev.log('MAP ${detectedCommand.values.first.toString()}');
          //dev.log(keySetting.length.toString());
          var key =
              keySetting['MAP ${detectedCommand.values.first.toString()}'];
          //dev.log(key!.name.toString());
          //dev.log('Send: ' + key.key.toString());

          RESTVirtualKeyboard.sendkey(key!.key.toString());
        } else if (detectedCommand.keys.first == 'TC' &&
            detectedCommand.values.first >= 0) {
          if (_currentLocaleId.startsWith('en'))
            _newVoiceText =
                'Setting traction control to ${detectedCommand.values.first.toString()}';
          else if (_currentLocaleId.startsWith('pl'))
            _newVoiceText =
                'Ustawiam kontrolę trakcji na pozycję: ${detectedCommand.values.first.toString()}';

          //dev.log('TC: ${detectedCommand.values.first.toString()}');
          var key = keySetting['TC ${detectedCommand.values.first.toString()}'];
          //dev.log('Send: ' + key!.key.toString());

          RESTVirtualKeyboard.sendkey(key!.key.toString());
        }

        dev.log(detectedCommand.keys.first);
        setState(() {
          lastWords = 'command: ' +
              detectedCommand.keys.first +
              '\n value: ' +
              detectedCommand.values.first.toString();
        });
      } else {
        _newVoiceText = 'Command was not recognized.';
        lastWords = 'words: ${result.recognizedWords}';
      }
      _speak();
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
      changedLanguageDropDownItem(selectedVal);
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  Map<String, int> detectCommand(SpeechRecognitionResult result) {
    Map<String, int> ret = {'none': -1};

    if (result.recognizedWords.isNotEmpty || result.alternates.isNotEmpty) {
      dev.log('recognizedWords: ${result.recognizedWords}');
      var words = result.recognizedWords.toUpperCase().split(' ');
      words.addAll(getAlterListStrings(result.alternates));
      words = words.toSet().toList();
      List<String> en_brakeBias = ['BB', 'Brake', 'Bias', 'BEBE', 'break'];
      List<String> en_tractionControl = ['Traction', 'TC', 'Control', 'DC'];
      List<String> en_engineMap = ['MAP', 'ENGINE'];
      List<String> pl_brakeBias = ['BB', 'Hamulce', 'Balans', 'BEBE'];
      List<String> pl_tractionControl = ['Kontrola', 'Trakcja', 'TC', 'TECE'];
      List<String> pl_engineMap = ['MAPA', 'Silnik'];
      var command = '';
      if (_currentLocaleId.startsWith('en')) {
        if (shareTheSameWord(en_brakeBias, words)) {
          command = 'BB';
        } else if (shareTheSameWord(en_tractionControl, words)) {
          command = 'TC';
        } else if (shareTheSameWord(en_engineMap, words)) {
          command = 'MAP';
        }
      } else if (_currentLocaleId.startsWith('pl')) {
        if (shareTheSameWord(pl_brakeBias, words)) {
          command = 'BB';
        } else if (shareTheSameWord(pl_tractionControl, words)) {
          command = 'TC';
        } else if (shareTheSameWord(pl_engineMap, words)) {
          command = 'MAP';
        }
      }
      var number = searchForNumber(words);
      dev.log('Komenda: $command');
      dev.log('Wartość: $number');
      Map<String, int> r = {command: int.parse(number)};
      return r;
    }
    return ret;
  }

  bool shareTheSameWord(List<String> commands, List<String> words) {
    for (var command in commands) {
      for (var word in words) {
        //dev.log('$command = $word');
        if (command.toUpperCase() == word.toUpperCase()) return true;
      }
    }
    return false;
  }

  List<String> getAlterListStrings(List<SpeechRecognitionWords> alternates) {
    List<String> alterList = [];
    alternates.forEach((element) {
      if (element.confidence > 0.85)
        alterList.addAll(element.recognizedWords.toUpperCase().split(' '));
    });
    return alterList;
  }

  searchForNumber(List<String> words) {
    for (var word in words) {
      word = word.replaceAll(new RegExp(r'[^0-9]'), '');
      if (word.isNotEmpty) return word;
    }
  }

  listLanguages(languages) {
    dev.log("lang: $languages");
    for (dynamic type in languages) {
      dev.log("lang: ${type as String}");
    }
  }

  void initKeySettings() {
    _allKeys!.then((value) => setKeys(value));
  }

  void setKeys(Map<String, KeySettings> value) {
    keySetting = value;
    dev.log("imported: ${keySetting.length.toString()}");
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Last command:',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).selectedRowColor,
                child: Center(
                  child: Text(
                    lastWords,
                    style: GoogleFonts.getFont(
                      'Anton',
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () => null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Speech recognition available',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  Widget get speechButton {
    if (!hasSpeech || !isListening)
      return TextButton(
        onPressed: startListening,
        child: Text(
          'START',
          style: GoogleFonts.getFont(
            'Anton',
            fontSize: 48,
          ),
        ),
        style: TextButton.styleFrom(
          fixedSize: Size.fromHeight(250),
          primary: Colors.white,
          backgroundColor: Colors.teal,
        ),
      );
    else
      return TextButton(
        onPressed: isListening ? cancelListening : null,
        child: Text(
          'STOP',
          style: GoogleFonts.getFont(
            'Anton',
            fontSize: 48,
          ),
        ),
        style: TextButton.styleFrom(
            fixedSize: Size.fromHeight(250),
            primary: Colors.white,
            backgroundColor: Colors.red),
      );
    /*
          TextButton(
            onPressed: isListening ? stopListening : null,
            child: Text('Stop'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.red),
          ),
          */
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        speechButton,
      ],
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(this.currentLocaleId, this.switchLang,
      this.localeNames, this.logEvents, this.switchLogging,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final List<LocaleName> localeNames;
  final bool logEvents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Text('Lang: '),
              DropdownButton<String>(
                onChanged: (selectedVal) => switchLang(selectedVal),
                value: currentLocaleId,
                items: localeNames
                    .map(
                      (localeName) => DropdownMenuItem(
                        value: localeName.localeId,
                        child: Text(localeName.name),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: hasSpeech ? null : initSpeechState,
          child: Text('Initialize'),
        ),
      ],
    );
  }
}

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
