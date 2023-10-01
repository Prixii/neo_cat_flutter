class FileNotExistException implements Exception {
  final String filePath;

  FileNotExistException(this.filePath);

  @override
  String toString() {
    return '[FileNotExistException]: 不存在的文件 $filePath';
  }
}
