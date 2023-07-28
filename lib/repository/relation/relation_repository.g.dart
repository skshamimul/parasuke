// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$relationsRepositoryHash() =>
    r'80ebd3428b91d6fc62e17990b840584b8a93e294';

/// See also [relationsRepository].
@ProviderFor(relationsRepository)
final relationsRepositoryProvider = Provider<RelationsRepository>.internal(
  relationsRepository,
  name: r'relationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$relationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RelationsRepositoryRef = ProviderRef<RelationsRepository>;
String _$relationsQueryHash() => r'0dec3395e017f19f00308b9332b1c219b617e9b6';

/// See also [relationsQuery].
@ProviderFor(relationsQuery)
final relationsQueryProvider = AutoDisposeProvider<Query<Relation>>.internal(
  relationsQuery,
  name: r'relationsQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$relationsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RelationsQueryRef = AutoDisposeProviderRef<Query<Relation>>;
String _$relationsStreamHash() => r'11cfa3b3b9b531168096cab26d73a60b092ebb98';

/// See also [relationsStream].
@ProviderFor(relationsStream)
final relationsStreamProvider =
    AutoDisposeStreamProvider<List<Relation>>.internal(
  relationsStream,
  name: r'relationsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$relationsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RelationsStreamRef = AutoDisposeStreamProviderRef<List<Relation>>;
String _$relationStreamHash() => r'a0f36f20e1e324ffdd0d1c7d3bae1e6cc83389f8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef RelationStreamRef = AutoDisposeStreamProviderRef<Relation>;

/// See also [relationStream].
@ProviderFor(relationStream)
const relationStreamProvider = RelationStreamFamily();

/// See also [relationStream].
class RelationStreamFamily extends Family<AsyncValue<Relation>> {
  /// See also [relationStream].
  const RelationStreamFamily();

  /// See also [relationStream].
  RelationStreamProvider call(
    String relationID,
  ) {
    return RelationStreamProvider(
      relationID,
    );
  }

  @override
  RelationStreamProvider getProviderOverride(
    covariant RelationStreamProvider provider,
  ) {
    return call(
      provider.relationID,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'relationStreamProvider';
}

/// See also [relationStream].
class RelationStreamProvider extends AutoDisposeStreamProvider<Relation> {
  /// See also [relationStream].
  RelationStreamProvider(
    this.relationID,
  ) : super.internal(
          (ref) => relationStream(
            ref,
            relationID,
          ),
          from: relationStreamProvider,
          name: r'relationStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$relationStreamHash,
          dependencies: RelationStreamFamily._dependencies,
          allTransitiveDependencies:
              RelationStreamFamily._allTransitiveDependencies,
        );

  final String relationID;

  @override
  bool operator ==(Object other) {
    return other is RelationStreamProvider && other.relationID == relationID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, relationID.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
