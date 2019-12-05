class ClanMember {
	final int _id;
	final String _name;
	final String _rank;
	final String _picture;
	final int _joinDate;
	final int _xp;

	int get id => _id;
	String get name => _name;
	String get rank => _rank;
	String get picture => _picture;
	int get joinDate => _joinDate;
	int get xp => _xp;

	ClanMember(this._id, this._name, this._rank, this._picture, this._joinDate, this._xp);
}