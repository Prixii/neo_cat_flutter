class IllegalDataException implements Exception {
  IllegalDataException(this.filePath);

  final String filePath;

  @override
  String toString() {
    return '[IllegalDataException]: 文件数据非法 $filePath';
  }
}
