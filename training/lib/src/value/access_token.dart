/// class のコメント<br>
/// ２行目
/// 
/// 詳細
class AccessToken {
  /// value 変数のコメント<br>
  /// ２行目
  /// 
  /// 詳細
  final String value;

  /// constractor のコメント<br>
  /// ２行目
  /// 
  /// 詳細
  AccessToken(this.value) {
    if (value.length > 32) {
      throw Exception("overflow");
    }
  }

  /// operator == のコメント<br>
  /// ２行目
  /// 
  /// 詳細
  @override
  bool operator ==(Object other) =>
    identical(this, other) || (other is AccessToken && runtimeType == other.runtimeType && value == other.value); 

  /// hashCode getter のコメント<br>
  /// ２行目
  /// 
  /// 詳細
  @override
  int get hashCode => value.hashCode;
}