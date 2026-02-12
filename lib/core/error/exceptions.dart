class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'A server error occurred']);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'A cache error occurred']);
}
