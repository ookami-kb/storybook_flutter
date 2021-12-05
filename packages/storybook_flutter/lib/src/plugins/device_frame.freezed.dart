// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeviceFrameDataTearOff {
  const _$DeviceFrameDataTearOff();

  _DeviceFrameData call(
      {bool isFrameVisible = true,
      DeviceInfo? device,
      Orientation orientation = Orientation.portrait}) {
    return _DeviceFrameData(
      isFrameVisible: isFrameVisible,
      device: device,
      orientation: orientation,
    );
  }
}

/// @nodoc
const $DeviceFrameData = _$DeviceFrameDataTearOff();

/// @nodoc
mixin _$DeviceFrameData {
  bool get isFrameVisible => throw _privateConstructorUsedError;
  DeviceInfo? get device => throw _privateConstructorUsedError;
  Orientation get orientation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceFrameDataCopyWith<DeviceFrameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceFrameDataCopyWith<$Res> {
  factory $DeviceFrameDataCopyWith(
          DeviceFrameData value, $Res Function(DeviceFrameData) then) =
      _$DeviceFrameDataCopyWithImpl<$Res>;
  $Res call({bool isFrameVisible, DeviceInfo? device, Orientation orientation});

  $DeviceInfoCopyWith<$Res>? get device;
}

/// @nodoc
class _$DeviceFrameDataCopyWithImpl<$Res>
    implements $DeviceFrameDataCopyWith<$Res> {
  _$DeviceFrameDataCopyWithImpl(this._value, this._then);

  final DeviceFrameData _value;
  // ignore: unused_field
  final $Res Function(DeviceFrameData) _then;

  @override
  $Res call({
    Object? isFrameVisible = freezed,
    Object? device = freezed,
    Object? orientation = freezed,
  }) {
    return _then(_value.copyWith(
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      device: device == freezed
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ));
  }

  @override
  $DeviceInfoCopyWith<$Res>? get device {
    if (_value.device == null) {
      return null;
    }

    return $DeviceInfoCopyWith<$Res>(_value.device!, (value) {
      return _then(_value.copyWith(device: value));
    });
  }
}

/// @nodoc
abstract class _$DeviceFrameDataCopyWith<$Res>
    implements $DeviceFrameDataCopyWith<$Res> {
  factory _$DeviceFrameDataCopyWith(
          _DeviceFrameData value, $Res Function(_DeviceFrameData) then) =
      __$DeviceFrameDataCopyWithImpl<$Res>;
  @override
  $Res call({bool isFrameVisible, DeviceInfo? device, Orientation orientation});

  @override
  $DeviceInfoCopyWith<$Res>? get device;
}

/// @nodoc
class __$DeviceFrameDataCopyWithImpl<$Res>
    extends _$DeviceFrameDataCopyWithImpl<$Res>
    implements _$DeviceFrameDataCopyWith<$Res> {
  __$DeviceFrameDataCopyWithImpl(
      _DeviceFrameData _value, $Res Function(_DeviceFrameData) _then)
      : super(_value, (v) => _then(v as _DeviceFrameData));

  @override
  _DeviceFrameData get _value => super._value as _DeviceFrameData;

  @override
  $Res call({
    Object? isFrameVisible = freezed,
    Object? device = freezed,
    Object? orientation = freezed,
  }) {
    return _then(_DeviceFrameData(
      isFrameVisible: isFrameVisible == freezed
          ? _value.isFrameVisible
          : isFrameVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      device: device == freezed
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ));
  }
}

/// @nodoc

class _$_DeviceFrameData
    with DiagnosticableTreeMixin
    implements _DeviceFrameData {
  const _$_DeviceFrameData(
      {this.isFrameVisible = true,
      this.device,
      this.orientation = Orientation.portrait});

  @JsonKey(defaultValue: true)
  @override
  final bool isFrameVisible;
  @override
  final DeviceInfo? device;
  @JsonKey(defaultValue: Orientation.portrait)
  @override
  final Orientation orientation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceFrameData(isFrameVisible: $isFrameVisible, device: $device, orientation: $orientation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceFrameData'))
      ..add(DiagnosticsProperty('isFrameVisible', isFrameVisible))
      ..add(DiagnosticsProperty('device', device))
      ..add(DiagnosticsProperty('orientation', orientation));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceFrameData &&
            const DeepCollectionEquality()
                .equals(other.isFrameVisible, isFrameVisible) &&
            const DeepCollectionEquality().equals(other.device, device) &&
            const DeepCollectionEquality()
                .equals(other.orientation, orientation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isFrameVisible),
      const DeepCollectionEquality().hash(device),
      const DeepCollectionEquality().hash(orientation));

  @JsonKey(ignore: true)
  @override
  _$DeviceFrameDataCopyWith<_DeviceFrameData> get copyWith =>
      __$DeviceFrameDataCopyWithImpl<_DeviceFrameData>(this, _$identity);
}

abstract class _DeviceFrameData implements DeviceFrameData {
  const factory _DeviceFrameData(
      {bool isFrameVisible,
      DeviceInfo? device,
      Orientation orientation}) = _$_DeviceFrameData;

  @override
  bool get isFrameVisible;
  @override
  DeviceInfo? get device;
  @override
  Orientation get orientation;
  @override
  @JsonKey(ignore: true)
  _$DeviceFrameDataCopyWith<_DeviceFrameData> get copyWith =>
      throw _privateConstructorUsedError;
}
