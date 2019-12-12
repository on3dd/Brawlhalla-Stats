class Ranked {
	final int _rating;
	final int _peakRating;
	final String _tier;
	final String _picture;
	final int _games;
	final int _wins;
	final String _region;
	final int _globalRank;
	final int _regionRank;

	int get rating => _rating;
	int get peakRating => _peakRating;
	String get tier => _tier;
	String get picture => _picture;
	int get games => _games;
	int get wins => _wins;
	String get region => _region;
	int get globalRank => _globalRank;
	int get regionRank => _regionRank;

	Ranked(this._rating, this._peakRating, this._tier, this._picture, this._games, this._wins, this._region, this._globalRank, this._regionRank);
}