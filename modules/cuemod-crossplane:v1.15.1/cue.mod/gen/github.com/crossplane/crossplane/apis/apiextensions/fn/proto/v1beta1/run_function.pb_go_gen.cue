// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/fn/proto/v1beta1

package v1beta1

import (
	"google.golang.org/protobuf/types/known/structpb"
	"google.golang.org/protobuf/types/known/durationpb"
)

// Ready indicates whether a composed resource should be considered ready.
#Ready: int32 // #enumReady

#enumReady:
	#Ready_READY_UNSPECIFIED |
	#Ready_READY_TRUE |
	#Ready_READY_FALSE

#values_Ready: {
	Ready_READY_UNSPECIFIED: #Ready_READY_UNSPECIFIED
	Ready_READY_TRUE:        #Ready_READY_TRUE
	Ready_READY_FALSE:       #Ready_READY_FALSE
}

#Ready_READY_UNSPECIFIED: #Ready & 0

// True means the composed resource has been observed to be ready.
#Ready_READY_TRUE: #Ready & 1

// False means the composed resource has not been observed to be ready.
#Ready_READY_FALSE: #Ready & 2

// Severity of Function results.
#Severity: int32 // #enumSeverity

#enumSeverity:
	#Severity_SEVERITY_UNSPECIFIED |
	#Severity_SEVERITY_FATAL |
	#Severity_SEVERITY_WARNING |
	#Severity_SEVERITY_NORMAL

#values_Severity: {
	Severity_SEVERITY_UNSPECIFIED: #Severity_SEVERITY_UNSPECIFIED
	Severity_SEVERITY_FATAL:       #Severity_SEVERITY_FATAL
	Severity_SEVERITY_WARNING:     #Severity_SEVERITY_WARNING
	Severity_SEVERITY_NORMAL:      #Severity_SEVERITY_NORMAL
}

#Severity_SEVERITY_UNSPECIFIED: #Severity & 0

// Fatal results are fatal; subsequent Composition Functions may run, but
// the Composition Function pipeline run will be considered a failure and
// the first fatal result will be returned as an error.
#Severity_SEVERITY_FATAL: #Severity & 1

// Warning results are non-fatal; the entire Composition will run to
// completion but warning events and debug logs associated with the
// composite resource will be emitted.
#Severity_SEVERITY_WARNING: #Severity & 2

// Normal results are emitted as normal events and debug logs associated
// with the composite resource.
#Severity_SEVERITY_NORMAL: #Severity & 3

// A RunFunctionRequest requests that the Composition Function be run.
#RunFunctionRequest: {
	// Metadata pertaining to this request.
	meta?: null | #RequestMeta @go(Meta,*RequestMeta) @protobuf(1,bytes,opt,proto3)

	// The observed state prior to invocation of a Function pipeline. State passed
	// to each Function is fresh as of the time the pipeline was invoked, not as
	// of the time each Function was invoked.
	observed?: null | #State @go(Observed,*State) @protobuf(2,bytes,opt,proto3)

	// Desired state according to a Function pipeline. The state passed to a
	// particular Function may have been accumulated by previous Functions in the
	// pipeline.
	//
	// Note that the desired state must be a partial object with only the fields
	// that this function (and its predecessors in the pipeline) wants to have
	// set in the object. Copying a non-partial observed state to desired is most
	// likely not what you want to do. Leaving out fields that had been returned
	// as desired before will result in them being deleted from the objects in the
	// cluster.
	desired?: null | #State @go(Desired,*State) @protobuf(3,bytes,opt,proto3)

	// Optional input specific to this Function invocation. A JSON representation
	// of the 'input' block of the relevant entry in a Composition's pipeline.
	input?: null | structpb.#Struct @go(Input,*structpb.Struct) @protobuf(4,bytes,opt,proto3,oneof)

	// Optional context. Crossplane may pass arbitary contextual information to a
	// Function. A Function may also return context in its RunFunctionResponse,
	// and that context will be passed to subsequent Functions. Crossplane
	// discards all context returned by the last Function in the pipeline.
	context?: null | structpb.#Struct @go(Context,*structpb.Struct) @protobuf(5,bytes,opt,proto3,oneof)

	// Optional extra resources that the Function required.
	// Note that extra resources is a map to Resources, plural.
	// The map key corresponds to the key in a RunFunctionResponse's
	// extra_resources field. If a Function requested extra resources that
	// did not exist, Crossplane sets the map key to an empty Resources message to
	// indicate that it attempted to satisfy the request.
	extra_resources?: {[string]: null | #Resources} @go(ExtraResources,map[string]*Resources) @protobuf(6,map[bytes]bytes,rep,json=extraResources,proto3)
}

// Resources represents the state of several Crossplane resources.
#Resources: {
	items?: [...null | #Resource] @go(Items,[]*Resource) @protobuf(1,bytes,rep,proto3)
}

// A RunFunctionResponse contains the result of a Composition Function run.
#RunFunctionResponse: {
	// Metadata pertaining to this response.
	meta?: null | #ResponseMeta @go(Meta,*ResponseMeta) @protobuf(1,bytes,opt,proto3)

	// Desired state according to a Function pipeline. Functions may add desired
	// state, and may mutate or delete any part of the desired state they are
	// concerned with. A Function must pass through any part of the desired state
	// that it is not concerned with.
	//
	// Note that the desired state must be a partial object with only the fields
	// that this function (and its predecessors in the pipeline) wants to have
	// set in the object. Copying a non-partial observed state to desired is most
	// likely not what you want to do. Leaving out fields that had been returned
	// as desired before will result in them being deleted from the objects in the
	// cluster.
	desired?: null | #State @go(Desired,*State) @protobuf(2,bytes,opt,proto3)

	// Results of the Function run. Results are used for observability purposes.
	results?: [...null | #Result] @go(Results,[]*Result) @protobuf(3,bytes,rep,proto3)

	// Optional context to be passed to the next Function in the pipeline as part
	// of the RunFunctionRequest. Dropped on the last function in the pipeline.
	context?: null | structpb.#Struct @go(Context,*structpb.Struct) @protobuf(4,bytes,opt,proto3,oneof)

	// Requirements that must be satisfied for this Function to run successfully.
	requirements?: null | #Requirements @go(Requirements,*Requirements) @protobuf(5,bytes,opt,proto3)
}

// RequestMeta contains metadata pertaining to a RunFunctionRequest.
#RequestMeta: {
	// An opaque string identifying the content of the request. Two identical
	// requests should have the same tag.
	tag?: string @go(Tag) @protobuf(1,bytes,opt,proto3)
}

// Requirements that must be satisfied for a Function to run successfully.
#Requirements: {
	// Extra resources that this Function requires.
	// The map key uniquely identifies the group of resources.
	extra_resources?: {[string]: null | #ResourceSelector} @go(ExtraResources,map[string]*ResourceSelector) @protobuf(1,map[bytes]bytes,rep,json=extraResources,proto3)
}

// ResourceSelector selects a group of resources, either by name or by label.
#ResourceSelector: {
	api_version?: string @go(ApiVersion) @protobuf(1,bytes,opt,json=apiVersion,proto3)
	kind?:        string @go(Kind) @protobuf(2,bytes,opt,proto3)

	// Types that are assignable to Match:
	//
	//	*ResourceSelector_MatchName
	//	*ResourceSelector_MatchLabels
	Match: _#isResourceSelector_Match
}

_#isResourceSelector_Match: _

#ResourceSelector_MatchName: {
	MatchName: string @protobuf(3,bytes,opt,name=match_name,json=matchName,proto3,oneof)
}

#ResourceSelector_MatchLabels: {
	MatchLabels?: null | #MatchLabels @go(,*MatchLabels) @protobuf(4,bytes,opt,name=match_labels,json=matchLabels,proto3,oneof)
}

// MatchLabels defines a set of labels to match resources against.
#MatchLabels: {
	labels?: {[string]: string} @go(Labels,map[string]string) @protobuf(1,map[bytes]bytes,rep,proto3)
}

// ResponseMeta contains metadata pertaining to a RunFunctionResponse.
#ResponseMeta: {
	// An opaque string identifying the content of the request. Must match the
	// meta.tag of the corresponding RunFunctionRequest.
	tag?: string @go(Tag) @protobuf(1,bytes,opt,proto3)

	// Time-to-live of this response. Deterministic Functions with no side-effects
	// (e.g. simple templating Functions) may specify a TTL. Crossplane may choose
	// to cache responses until the TTL expires.
	ttl?: null | durationpb.#Duration @go(Ttl,*durationpb.Duration) @protobuf(2,bytes,opt,proto3,oneof)
}

// State of the composite resource (XR) and any composed resources.
#State: {
	// The state of the composite resource (XR).
	composite?: null | #Resource @go(Composite,*Resource) @protobuf(1,bytes,opt,proto3)

	// The state of any composed resources.
	resources?: {[string]: null | #Resource} @go(Resources,map[string]*Resource) @protobuf(2,map[bytes]bytes,rep,proto3)
}

// A Resource represents the state of a composite or composed resource.
#Resource: {
	// The JSON representation of the resource.
	//
	//   - Crossplane will set this field in a RunFunctionRequest to the entire
	//     observed state of a resource - including its metadata, spec, and status.
	//
	//   - A Function should set this field in a RunFunctionRequest to communicate
	//     the desired state of a composite or composed resource.
	//
	//   - A Function may only specify the desired status of a composite resource -
	//     not its metadata or spec. A Function should not return desired metadata
	//     or spec for a composite resource. This will be ignored.
	//
	//   - A Function may not specify the desired status of a composed resource -
	//     only its metadata and spec. A Function should not return desired status
	//     for a composed resource. This will be ignored.
	resource?: null | structpb.#Struct @go(Resource,*structpb.Struct) @protobuf(1,bytes,opt,proto3)

	// The resource's connection details.
	//
	//   - Crossplane will set this field in a RunFunctionRequest to communicate the
	//     the observed connection details of a composite or composed resource.
	//
	//   - A Function should set this field in a RunFunctionResponse to indicate the
	//     desired connection details of the composite resource.
	//
	//   - A Function should not set this field in a RunFunctionResponse to indicate
	//     the desired connection details of a composed resource. This will be
	//     ignored.
	connection_details?: {[string]: bytes} @go(ConnectionDetails,map[string][]byte) @protobuf(2,map[bytes]bytes,rep,json=connectionDetails,proto3)

	// Ready indicates whether the resource should be considered ready.
	//
	// * Crossplane will never set this field in a RunFunctionRequest.
	//
	//   - A Function should set this field to READY_TRUE in a RunFunctionResponse
	//     to indicate that a desired composed resource is ready.
	//
	//   - A Function should not set this field in a RunFunctionResponse to indicate
	//     that the desired composite resource is ready. This will be ignored.
	ready?: #Ready @go(Ready) @protobuf(3,varint,opt,proto3,enum=apiextensions.fn.proto.v1beta1.Ready)
}

// A Result of running a Function.
#Result: {
	// Severity of this result.
	severity?: #Severity @go(Severity) @protobuf(1,varint,opt,proto3,enum=apiextensions.fn.proto.v1beta1.Severity)

	// Human-readable details about the result.
	message?: string @go(Message) @protobuf(2,bytes,opt,proto3)
}
