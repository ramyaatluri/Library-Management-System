

class bookDetails{
  final String bookGenre;
  final String bookName;
  final String bookIsbn;
  final String bookLanguage;
  final String bookAuthor;
  final String bookPrice;
  final String bookQuantity;
  final String bookPublisher;
  final String bookImageUrl;

  bookDetails({
    this.bookAuthor,
    this.bookGenre,
    this.bookIsbn,
    this.bookLanguage,
    this.bookName,
    this.bookPrice,
    this.bookPublisher,
    this.bookQuantity,
    this.bookImageUrl
  });

  factory bookDetails.fromJson(Map<String, dynamic> json) {
    return bookDetails(
      bookAuthor: json['bookAuthor'],
      bookGenre: json['bookGenre'],
      bookIsbn: json['bookIsbn'],
      bookLanguage: json['bookLanguage'],
      bookName: json['bookName'],
      bookPrice: json['bookPrice'],
      bookPublisher: json['bookPublisher'],
      bookQuantity: json['bookQuantity'],
      bookImageUrl: json['bookImageUrl']
      );
  }
}

class futureBookDetails{
  final List<String> futureBookName; 
  final List<String> futureAuthor; 
  final List<String> futureLanguage; 
  final List<String> futurePublisher; 
  final List<String> futureGenre; 
  final List<String> futureIsbn; 
  final List<String> futurePrice;
  final List<String> futureQuantity;  
  final List<String> futureImageUrl; 
  final int length;

  futureBookDetails({
    this.futureAuthor,
    this.futureBookName,
    this.futureGenre,
    this.futureImageUrl,
    this.futureIsbn,
    this.futureLanguage,
    this.futurePrice,
    this.futurePublisher,
    this.futureQuantity,
    this.length,
  });

  factory futureBookDetails.from(bookDetails temp)  {
    String pattern = '_-_-_';
    return futureBookDetails(
      futureAuthor:  temp.bookAuthor.split(pattern).toList(),
      futureBookName: temp.bookName.split(pattern).toList(),
      futureGenre: temp.bookGenre.split(pattern).toList(),
      futureImageUrl: temp.bookImageUrl.split(pattern).toList(),
      futureIsbn: temp.bookIsbn.split(pattern).toList(),
      futureLanguage: temp.bookLanguage.split(pattern).toList(),
      futurePrice: temp.bookPrice.split(pattern).toList(),
      futurePublisher: temp.bookPublisher.split(pattern).toList(),
      futureQuantity: temp.bookQuantity.split(pattern).toList(),
      length: temp.bookQuantity.split(pattern).length
    );
  }

}