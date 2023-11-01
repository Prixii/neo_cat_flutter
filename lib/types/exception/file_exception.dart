class FileNotExistException implements Exception {
  FileNotExistException(this.filePath);

  final String filePath;

  @override
  String toString() {
    return '[FileNotExistException]: 不存在的文件 $filePath';
  }
}
