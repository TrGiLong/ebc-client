import 'dart:convert';

import 'package:ebc_app/model/block.dart';
import 'package:http/http.dart' as http;

abstract class EbcRepository {
  Future<List<Block>> getAll();

  Future<Block> get(int index);

  Future<Block> add(String value);
}

class EbcServerRepository implements EbcRepository {
  final String baseUrl;

  EbcServerRepository(this.baseUrl);

  @override
  Future<List<Block>> getAll() async {
    final response = await http.get(Uri.parse('$baseUrl/api/block-chain/all'));
    return jsonDecode(response.body)['chains'].map((e) => Block.fromMap(e)).cast<Block>().toList();
  }

  @override
  Future<Block> get(int index) async {
    final response = await http.get(Uri.parse('$baseUrl/api/block-chain/query?index=$index'));
    return Block.fromJson(jsonDecode(response.body)['block']);
  }

  @override
  Future<Block> add(String value) async {
    final response = await http.post(Uri.parse('$baseUrl/api/block-chain/insert?value=$value'));
    return Block.fromJson(jsonDecode(response.body)['block']);
  }
}
