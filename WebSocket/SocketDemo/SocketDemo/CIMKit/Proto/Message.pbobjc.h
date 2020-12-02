// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Message.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MessageRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface MessageRoot : GPBRootObject
@end

#pragma mark - Model

typedef GPB_ENUM(MessageModel_FieldNumber) {
    MessageModel_FieldNumber_Id_p = 1,
    MessageModel_FieldNumber_Action = 2,
    MessageModel_FieldNumber_Content = 3,
    MessageModel_FieldNumber_Sender = 4,
    MessageModel_FieldNumber_Receiver = 5,
    MessageModel_FieldNumber_Extra = 6,
    MessageModel_FieldNumber_Title = 7,
    MessageModel_FieldNumber_Format = 8,
    MessageModel_FieldNumber_Timestamp = 9,
};

@interface MessageModel : GPBMessage

@property(nonatomic, readwrite) int64_t id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *action;

@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

@property(nonatomic, readwrite, copy, null_resettable) NSString *sender;

@property(nonatomic, readwrite, copy, null_resettable) NSString *receiver;

@property(nonatomic, readwrite, copy, null_resettable) NSString *extra;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@property(nonatomic, readwrite, copy, null_resettable) NSString *format;

@property(nonatomic, readwrite) int64_t timestamp;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
