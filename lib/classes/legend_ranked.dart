class LegendRanked {
	final int _id;
	final String _name;
	final String _picture;
	final int _rating;
	final int _peakRating;
	final String _tier;
	final int _wins;
	final int _games;

	int get id => _id;
	String get name => _name;
	String get picture => _picture;
	int get rating => _rating;
	int get peakRating => _peakRating;
	String get tier => _tier;
	int get wins => _wins;
	int get games => _games;

	LegendRanked(
			this._id,
			this._name,
			this._picture,
			this._rating,
			this._peakRating,
			this._tier,
			this._wins,
			this._games);
}