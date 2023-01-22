import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../help/globals.dart' as globals;

class AtlasPortProvider with ChangeNotifier{
  Map<String,dynamic> _globalDashboardDetails = {};
  get globalDashboardDetails => _globalDashboardDetails;
  set globalDashboardDetails(var globalDashboardDetails){
    _globalDashboardDetails = globalDashboardDetails;
    notifyListeners();
  }

  List _globalDashboardDetailsCampaigns = [];
  get globalDashboardDetailsCampaigns => _globalDashboardDetailsCampaigns;
  set globalDashboardDetailsCampaigns(var globalDashboardDetailsCampaigns){
    _globalDashboardDetailsCampaigns = globalDashboardDetailsCampaigns;
    notifyListeners();
  }


  String _dayInfo = '';
  get dayInfo => _dayInfo;
  set dayInfo(var dayInfo){
    _dayInfo = dayInfo;
    notifyListeners();
  }


  int _sent = 0;
  int get sent => _sent;
  set sent(int sent){
    _sent = sent;
    notifyListeners();
  }
  int _max = 0;
  int get max => _max;
  set max(int max){
    _max = max;
    notifyListeners();
  }
  String _sentKb = "0";
  String get sentKb => _sentKb;
  set sentKb(String sentKb){
    _sentKb = sentKb;
    notifyListeners();
  }
  String _totalKb = "0";
  String get totalKb => _totalKb;
  set totalKb(String totalKb){
    _totalKb = totalKb;
    notifyListeners();
  }

  var _loading = false ;
  bool get loading => _loading;
  set loading(bool loading){
    _loading = loading;
    notifyListeners();
  }



  List _storyItems = [];
  List get storyItems => _storyItems;
  set storyItems(List storyItems){
    _storyItems = storyItems;
    notifyListeners();
  }


  List _introItems = [];
  List get introItems => _introItems;
  set introItems(List introItems){
    _introItems = introItems;
    notifyListeners();
  }


  var _setLocal = "en";
  get setLocal => _setLocal;
  set setLocal(var setLocal){
    _setLocal = setLocal;
    notifyListeners();
  }


  int _overlyIndex = 0;
  int get overlyIndex => _overlyIndex;
  set overlyIndex(int overlyIndex){
    _overlyIndex = overlyIndex;
    notifyListeners();
  }


  int _selected = 0;
  int get selected => _selected;
  set selected(int selected){
    _selected = selected;
    notifyListeners();
  }


}




