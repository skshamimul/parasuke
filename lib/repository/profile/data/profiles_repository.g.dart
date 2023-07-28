// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profilesRepositoryHash() =>
    r'95639e75062f6c6996d1abbc22681fb1be6f776a';

/// See also [profilesRepository].
@ProviderFor(profilesRepository)
final profilesRepositoryProvider = Provider<ProfilesRepository>.internal(
  profilesRepository,
  name: r'profilesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profilesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfilesRepositoryRef = ProviderRef<ProfilesRepository>;
String _$profilesQueryHash() => r'b47c136eb09b021b148df25d80e6eb2f27c37148';

/// See also [profilesQuery].
@ProviderFor(profilesQuery)
final profilesQueryProvider = AutoDisposeProvider<Query<Profile>>.internal(
  profilesQuery,
  name: r'profilesQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profilesQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfilesQueryRef = AutoDisposeProviderRef<Query<Profile>>;
String _$profileStreamHash() => r'2a97b2aca97d74793282f6f267b70c07baee2976';

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

typedef ProfileStreamRef = AutoDisposeStreamProviderRef<Profile>;

/// See also [profileStream].
@ProviderFor(profileStream)
const profileStreamProvider = ProfileStreamFamily();

/// See also [profileStream].
class ProfileStreamFamily extends Family<AsyncValue<Profile>> {
  /// See also [profileStream].
  const ProfileStreamFamily();

  /// See also [profileStream].
  ProfileStreamProvider call(
    String profileID,
  ) {
    return ProfileStreamProvider(
      profileID,
    );
  }

  @override
  ProfileStreamProvider getProviderOverride(
    covariant ProfileStreamProvider provider,
  ) {
    return call(
      provider.profileID,
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
  String? get name => r'profileStreamProvider';
}

/// See also [profileStream].
class ProfileStreamProvider extends AutoDisposeStreamProvider<Profile> {
  /// See also [profileStream].
  ProfileStreamProvider(
    this.profileID,
  ) : super.internal(
          (ref) => profileStream(
            ref,
            profileID,
          ),
          from: profileStreamProvider,
          name: r'profileStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$profileStreamHash,
          dependencies: ProfileStreamFamily._dependencies,
          allTransitiveDependencies:
              ProfileStreamFamily._allTransitiveDependencies,
        );

  final String profileID;

  @override
  bool operator ==(Object other) {
    return other is ProfileStreamProvider && other.profileID == profileID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profileID.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
