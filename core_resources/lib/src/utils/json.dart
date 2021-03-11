import 'dart:convert';

import 'package:flutter/foundation.dart';

dynamic _decode(String source) => jsonDecode(source);

String _encode(dynamic value) => jsonEncode(value);

/// Decode a String to a JSON object on background
/// using the [compute] function
Future<Map<String, dynamic>> jsonDecodeObj(String source) async {
  final result = compute(_decode, source);
  return await result;
}

/// Decode a String to a JSON array on background
/// using the [compute] function
Future<List<dynamic>> jsonDecodeArray(String source) async {
  final result = compute(_decode, source);
  return await result;
}

/// Encode an object to its JSON representation
/// on background using the [compute] function
Future<String> jsonEncodeBg(dynamic obj) async {
  return await compute(_encode, obj);
}
