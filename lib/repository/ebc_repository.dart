import 'dart:convert';

import 'package:ebc_app/model/block.dart';
import 'package:http/http.dart' as http;

abstract class EbcRepository {
  Future<List<Block>> getAll();

  Future<Block> get(int index);

  Future<Block> add(String value);
}

class LocalEbcRepository implements EbcRepository {
  final List<Block> blockchain = [
    Block(
      index: 1,
      timeStamp: DateTime.now().millisecondsSinceEpoch,
      value: "GENESIS",
      hash: "123456789abcdef",
      prevHash: "123456789abcdef",
    )
  ];

  @override
  Future<Block> add(String value) async {
    final block = Block(
        index: blockchain.length + 1,
        value: value,
        hash: "123456789abcdef",
        prevHash: "123456789abcdef",
        timeStamp: DateTime.now().millisecondsSinceEpoch);
    blockchain.add(block);
    return block;
  }

  @override
  Future<Block> get(int index) async {
    return blockchain[index - 1];
  }

  @override
  Future<List<Block>> getAll() async {
    return List.of(blockchain);
  }
}

class EbcServerRepository implements EbcRepository {
  final String baseUrl;
  final String endpoint = "api/blockchain";

  EbcServerRepository(this.baseUrl);

  @override
  Future<List<Block>> getAll() async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/all'));
    print(response.body);
    return jsonDecode(response.body)['chains']
        .map((e) => Block.fromMap(e))
        .cast<Block>()
        .toList();
  }

  @override
  Future<Block> get(int index) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$endpoint/query?index=$index'));
    return Block.fromJson(jsonDecode(response.body)['block']);
  }

  @override
  Future<Block> add(String value) async {
    final response =
        await http.post(Uri.parse('$baseUrl/$endpoint/insert?value=$value'));
    return Block.fromJson(jsonDecode(response.body)['block']);
  }
}
