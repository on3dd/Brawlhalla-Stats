import 'package:brawlhalla_stats/classes/clan_member.dart';

class Clan {
	final int _id;
	final String _name;
	final int _createdAt;
	final String _xp;
	final List<ClanMember> _members;

	int get id => _id;
	String get name => _name;
	int get createdAt => _createdAt;
	String get xp => _xp;
	List<ClanMember> get members => _members;

	Clan(this._id, this._name, this._createdAt, this._xp, this._members);
}