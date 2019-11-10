import 'package:brawlhalla_stats/classes/legend.dart';
import 'package:brawlhalla_stats/classes/clan.dart';

class Player {
  final int _brawlhallaId;
  final String _name;
  final int _level;
  final int _games;
  final int _wins;
  final List<Legend> _legends;
  final Clan _clan;

  int get brawlhallaId => _brawlhallaId;
  String get name => _name;
  int get level => _level;
  int get games => _games;
  int get wins => _wins;
  List<Legend> get legends => _legends;
  Clan get clan => _clan;

  Player(
    this._brawlhallaId, this._name, this._level, this._games, this._wins, this._legends, this._clan);
}