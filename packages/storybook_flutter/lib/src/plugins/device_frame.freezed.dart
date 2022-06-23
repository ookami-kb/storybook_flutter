// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_DeviceFrameDataCopyWith<$Res>
    implements $DeviceFrameDataCopyWith<$Res> {
  factory _$$_DeviceFrameDataCopyWith(
          _$_DeviceFrameData value, $Res Function(_$_DeviceFrameData) then) =
      __$$_DeviceFrameDataCopyWithImpl<$Res>;
  @override
  $Res call({bool isFrameVisible, DeviceInfo? device, Orientation orientation});

  @override
  $DeviceInfoCopyWith<$Res>? get device;
}

/// @nodoc
class __$$_DeviceFrameDataCopyWithImpl<$Res>
    extends _$DeviceFrameDataCopyWithImpl<$Res>
    implements _$$_DeviceFrameDataCopyWith<$Res> {
  __$$_DeviceFrameDataCopyWithImpl(
      _$_DeviceFrameData _value, $Res Function(_$_DeviceFrameData) _then)
      : super(_value, (v) => _then(v as _$_DeviceFrameData));

  @override
  _$_DeviceFrameData get _value => super._value as _$_DeviceFrameData;

  @override
  $Res call({
    Object? isFrameVisible = freezed,
    Object? device = freezed,
    Object? orientation = freezed,
  }) {
    return _then(_$_DeviceFrameData(
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

  @override
  @JsonKey()
  final bool isFrameVisible;
  @override
  final DeviceInfo? device;
  @override
  @JsonKey()
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
            other is _$_DeviceFrameData &&
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
  _$$_DeviceFrameDataCopyWith<_$_DeviceFrameData> get copyWith =>
      __$$_DeviceFrameDataCopyWithImpl<_$_DeviceFrameData>(this, _$identity);
}

abstract class _DeviceFrameData implements DeviceFrameData {
  const factory _DeviceFrameData(
      {final bool isFrameVisible,
      final DeviceInfo? device,
      final Orientation orientation}) = _$_DeviceFrameData;

  @override
  bool get isFrameVisible => throw _privateConstructorUsedError;
  @override
  DeviceInfo? get device => throw _privateConstructorUsedError;
  @override
  Orientation get orientation => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceFrameDataCopyWith<_$_DeviceFrameData> get copyWith =>
      throw _privateConstructorUsedError;
}
