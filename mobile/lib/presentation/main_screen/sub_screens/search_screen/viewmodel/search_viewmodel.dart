import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sed/domain/usecase/search_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../../app/di.dart';
import '../../../../../domain/model/models.dart';

class SearchViewModel extends BaseViewModel
    with SearchViewModelInputs, SearchViewModelOutputs {
  final TextEditingController searchController = TextEditingController();
  final StreamController<String> _searchStreamController =
      StreamController<String>.broadcast();

  final StreamController _isListeningStreamController =
      StreamController<bool>.broadcast();

  final SearchUseCase _searchUseCase = instance<SearchUseCase>();

  final SpeechToText speech = SpeechToText();

  Stream<String> get onSearchChanged => _searchStreamController.stream;

  ShowItems? items;
  @override
  void start() {
  }

  void onSearchTextChanged(String value) {
    _searchStreamController.add(value);
    getProducts(value);
  }

  Future<void> initSpeechRecognition() async {
    //Todo call only one time for whole application
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    if (!hasSpeech) {
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

    if (result.finalResult) {
      String spokenText = result.recognizedWords;
      searchController.text = spokenText;
      onSearchTextChanged(spokenText);
      micInput.add(speech.isNotListening);
    }
  }

  void errorListener(SpeechRecognitionError error) {
    micInput.add(speech.isNotListening);
  }

  void statusListener(String status) {
  }

  @override
  void getProducts(String text) async {
    items = null;
    var response = await _searchUseCase.execute(SearchUseCaseInputs(text));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      items = response;

      _searchStreamController.add("1");
    });
  }

  @override
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

  void getProducts(String text);
}

abstract class SearchViewModelOutputs {
  Stream<bool> get micOutput;
}
