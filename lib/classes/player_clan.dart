class PlayerClan {
  final String _name;
  final int _id;
  final String _clanXp;
  final int _personalXp;

  String get name => _name;
  int get id => _id;
  String get clanXp => _clanXp;
  int get personalXp => _personalXp;

  PlayerClan(this._name, this._id, this._clanXp, this._personalXp);
}