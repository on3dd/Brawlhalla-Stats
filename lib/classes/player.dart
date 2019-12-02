import 'package:brawlhalla_stats/classes/legend.dart';
import 'package:brawlhalla_stats/classes/clan.dart';

class Player {
  final int _brawlhallaId;
  final String _name;
  final int _level;
  final double _xp_percentage;
  final int _games;
  final int _wins;
  final List<Legend> _legends;
  final Clan _clan;

  int get brawlhallaId => _brawlhallaId;

  String get name => _name;

  int get level => _level;

  double get xp_percentage => _xp_percentage;

  int get games => _games;

  int get wins => _wins;

  List<Legend> get legends => _legends;

  Clan get clan => _clan;

  Player(this._brawlhallaId,
			this._name,
			this._level,
			this._xp_percentage,
      this._games,
			this._wins,
			this._legends,
			this._clan);
}
