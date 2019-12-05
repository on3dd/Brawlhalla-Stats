class Legend {
  final int _id;
  final String _name;
  final int _kos;
  final int _falls;
  final int _games;
  final int _wins;
  final int _level;
  final String _picture;

  int get id => _id;
  String get name => _name;
  int get kos => _kos;
  int get falls => _falls;
  int get games => _games;
  int get wins => _wins;
  int get level => _level;
  String get picture => _picture;

  Legend(this._id, this._name, this._kos, this._falls, this._games, this._wins, this._level, this._picture);
}