// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apimachinery/pkg/apis/meta/v1

package v1

// Timestamp is a struct that is equivalent to Time, but intended for
// protobuf marshalling/unmarshalling. It is generated into a serialization
// that matches Time. Do not use in Go structs.
#Timestamp: {
	// Represents seconds of UTC time since Unix epoch
	// 1970-01-01T00:00:00Z. Must be from 0001-01-01T00:00:00Z to
	// 9999-12-31T23:59:59Z inclusive.
	seconds: int64 @go(Seconds) @protobuf(1,varint,opt)

	// Non-negative fractions of a second at nanosecond resolution. Negative
	// second values with fractions must still have non-negative nanos values
	// that count forward in time. Must be from 0 to 999,999,999
	// inclusive. This field may be limited in precision depending on context.
	nanos: int32 @go(Nanos) @protobuf(2,varint,opt)
}
