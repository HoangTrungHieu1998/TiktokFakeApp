import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<SharedPreferences> get _storage => SharedPreferences.getInstance();
  CacheManager._();
  static final CacheManager instance = CacheManager._();

  final Map<String, CacheSlot> _buffer = {};

  T get<T>(String key, T defaultValue) {
    if (_buffer.containsKey(key)) {
      try {
        final slot = _buffer[key] as CacheSlot<T?>;
        if (slot.timeout == 0) {
          return slot.data ?? defaultValue;
        } else {
          final lastUpdated = DateTime.fromMillisecondsSinceEpoch(slot.updated!);
          final expireTime = lastUpdated.add(Duration(minutes: slot.timeout!));
          if (expireTime.isAfter(DateTime.now())) {
            // print('~~~ invalid after: $expireTime');
            return slot.data ?? defaultValue;
          } else {
            // print('~~~ Cache expired: $k - last updated $expireTime');
            _buffer.remove(key);
            _storage.then((inst) => inst.remove(key));
            return defaultValue;
          }
        }
      } catch (e) {
        print('error: $e');
      }
    }
    return defaultValue;
  }

  set<T>(String key, T data, [int timeout = 0]) {
    final _slot = CacheSlot<T>(
      data: data,
      timeout: timeout,
      updated: DateTime.now().millisecondsSinceEpoch,
    );
    _buffer[key] = _slot;
    _storage.then((inst) => inst.setString(key, _slot.toJson()));
    print('~~~ saved $key');
  }

  init() async {
    _buffer.clear();
    final sto = await _storage;
    await sto.reload();
    sto.getKeys().forEach((k) {
      try {
        // _buffer[k] = sto.getString(k);
        String? raw = sto.getString(k);
        if (k.startsWith('login')) {
          _buffer[k] = _loadLogin(raw!);
        }
      } catch (e) {
        print('~~~ failed key: $k = ${sto.get(k)}');
        print(e);
      }
      // print(_buffer);
    });
  }
  CacheSlot<int?> _loadLogin(String raw) => CacheSlot<int?>.fromJson(raw, (data) => data);

  clear([String prefix = '']) async {
    if (prefix.isNotEmpty) {
      final _keys = _buffer.keys;
      _keys.forEach((k) {
        if (k.startsWith(prefix)) {
          _buffer.remove(k);
        }
      });
      await _storage.then((inst) => inst.getKeys().forEach((k) {
        if (k.startsWith(prefix)) {
          inst.remove(k);
        }
      }));
    } else {
      _buffer.clear();
      await _storage.then((inst) => inst.clear());
    }
  }
}

class CacheSlot<T> {
  final int? timeout; // in minute
  final int? updated;
  final T? data;
  CacheSlot({
    this.timeout = 0,
    this.updated = 0,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'timeout': timeout,
      'updated': updated,
      'data': data,
    };
  }

  factory CacheSlot.fromMap(Map<String, dynamic> map) {
    return CacheSlot(
      timeout: map['timeout'],
      updated: map['updated'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheSlot.fromJson(String source, T Function(dynamic data) fnParser) {
    final rawSlot = CacheSlot.fromMap(json.decode(source));
    final parsedData = fnParser.call(rawSlot.data);
    return rawSlot.copyWith<T>(data: parsedData);
  }

  CacheSlot<T> copyWith<T>({
    int? timeout,
    int? updated,
    T? data,
  }) {
    return CacheSlot<T>(
      timeout: timeout ?? this.timeout,
      updated: updated ?? this.updated,
      data: data ?? this.data as T?,
    );
  }
}