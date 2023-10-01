class IllegalDataException implements Exception {
  final String filePath;

  IllegalDataException(this.filePath);

  @override
  String toString() {
    return '[IllegalDataException]: 文件数据非法 $filePath';
  }
}
