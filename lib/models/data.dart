class Data {
  final String imdbRating;
  final String Plot;
  final String Year;
  final String Genre;
  final String Title;
  final String Poster;
  final String Actors;
  final String Runtime;


  Data({this.imdbRating, this.Plot,this.Year,this.Genre,this.Title,this.Poster,this.Actors,this.Runtime});  // curly braces specify arguments not always required

  Data.fromJson(Map<String, dynamic> json)
      : imdbRating = json['imdbRating'],
        Year = json['Year'],
        Genre = json['Genre'],
        Title = json['Title'],
        Poster = json['Poster'],
        Actors = json['Actors'],
        Plot = json['Plot'],
        Runtime= json['Runtime'];

  Map<String, dynamic> toJson() => {
    'imdbRating': imdbRating,
    'Year': Year,
    'Genre': Genre,
    'Title': Title,
    'Posters': Poster,
    'Actors': Actors,
    'Plot':Plot,
    'Runtime':Runtime

  };
}
Data current = Data(); // to store a current Movie data