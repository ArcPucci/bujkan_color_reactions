import 'package:bujkan_color_reactions/utils/box_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService instance = PreferenceService._();
  static late final SharedPreferences _prefs;

  PreferenceService._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory PreferenceService() => instance;

  static const premiumKey = "PREMIUM_KEY";
  static const recordsKey = "RECORDS_KEY";
  static const pointsKey = "POINTS_KEY";
  static const boxAssetsKey = "ITEMS_KEY";
  static const boxAssetKey = "ITEM_KEY";
  static const levelKey = "LEVEL_KEY";

  Future<void> setPremium() async {
    await _prefs.setBool(premiumKey, true);
  }

  bool isPremium() {
    return _prefs.getBool(premiumKey) ?? false;
  }

  Future<void> setRecord(int id, int value) async{
    await _prefs.setInt("$recordsKey$id", value);
  }

  int getRecord(int id){
    return _prefs.getInt("$recordsKey$id") ?? 0;
  }

  Future<void> setPoints(int value)async {
    await _prefs.setInt(pointsKey, value);
  }

  int getPoints() {
    return _prefs.getInt(pointsKey) ?? 500;
  }

  Future<void> setBoxAssets(List<String> items)async {
    await _prefs.setStringList(boxAssetsKey, items);
  }

  List<String> getBoxAssets() {
    return _prefs.getStringList(boxAssetsKey) ?? [boxAssets[0].asset];
  }

  Future<void> setBoxAsset(String value) async{
    await _prefs.setString(boxAssetKey, value);
  }

  String getBoxAsset(){
    return _prefs.getString(boxAssetKey) ?? boxAssets[0].asset;
  }

  Future<void> setLevel(int value) async {
    await _prefs.setInt(levelKey, value);
  }

  int getLevel() {
    return _prefs.getInt(levelKey) ?? 0;
  }
}
