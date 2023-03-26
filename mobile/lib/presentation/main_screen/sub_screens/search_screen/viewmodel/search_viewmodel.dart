import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchViewModel extends BaseViewModel
    with SearchViewModelInputs, SearchViewModelOutputs {
  final TextEditingController searchController = TextEditingController();
  final StreamController<String> _searchStreamController =
      StreamController<String>.broadcast();

  final StreamController _isListeningStreamController =
      StreamController<bool>.broadcast();

  final SpeechToText speech = SpeechToText();

  Stream<String> get onSearchChanged => _searchStreamController.stream;

  @override
  void start() {
    // TODO: implement start
  }

  void onSearchTextChanged(String value) {
    _searchStreamController.add(value);
  }

  Future<void> initSpeechRecognition() async {
    //Todo call only one time for whole application
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    if (!hasSpeech) {
      print("Speech recognition not available");
    }
  }

  void startListening() async {
    await speech.listen(onResult: resultListener, localeId: 'en_us');
    micInput.add(speech.isNotListening);
  }

  void stopListening() async {
    await speech.stop();
    micInput.add(speech.isNotListening);
  }

  void resultListener(SpeechRecognitionResult result) {
    print("results: $result.recognizedWords");

    if (result.finalResult) {
      String spokenText = result.recognizedWords;
      searchController.text = spokenText;
      onSearchTextChanged(spokenText);
      micInput.add(speech.isNotListening);
    }
  }

  void errorListener(SpeechRecognitionError error) {
    print("Error: $error");
    micInput.add(speech.isNotListening);
  }

  void statusListener(String status) {
    print("Status: $status");
  }

  void dispose() {
    searchController.dispose();
    _searchStreamController.close();
    _isListeningStreamController.close();
    speech.stop();
  }

  @override
  Sink get micInput => _isListeningStreamController.sink;

  @override
  Stream<bool> get micOutput =>
      _isListeningStreamController.stream.map((event) => event);
}

abstract class SearchViewModelInputs {
  Sink get micInput;
}

abstract class SearchViewModelOutputs {
  Stream<bool> get micOutput;
}
