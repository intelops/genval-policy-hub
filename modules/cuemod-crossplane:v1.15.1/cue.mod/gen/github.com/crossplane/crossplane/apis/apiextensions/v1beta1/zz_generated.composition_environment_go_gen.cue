// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/v1beta1

package v1beta1

import (
	extv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
)

// An EnvironmentConfiguration specifies the environment for rendering composed
// resources.
#EnvironmentConfiguration: {
	// DefaultData statically defines the initial state of the environment.
	// It has the same schema-less structure as the data field in
	// environment configs.
	// It is overwritten by the selected environment configs.
	defaultData?: {[string]: extv1.#JSON} @go(DefaultData,map[string]extv1.JSON)

	// EnvironmentConfigs selects a list of `EnvironmentConfig`s. The resolved
	// resources are stored in the composite resource at
	// `spec.environmentConfigRefs` and is only updated if it is null.
	//
	// The list of references is used to compute an in-memory environment at
	// compose time. The data of all object is merged in the order they are
	// listed, meaning the values of EnvironmentConfigs with a larger index take
	// priority over ones with smaller indices.
	//
	// The computed environment can be accessed in a composition using
	// `FromEnvironmentFieldPath` and `CombineFromEnvironment` patches.
	// +optional
	environmentConfigs?: [...#EnvironmentSource] @go(EnvironmentConfigs,[]EnvironmentSource)

	// Patches is a list of environment patches that are executed before a
	// composition's resources are composed.
	patches?: [...#EnvironmentPatch] @go(Patches,[]EnvironmentPatch)

	// Policy represents the Resolve and Resolution policies which apply to
	// all EnvironmentSourceReferences in EnvironmentConfigs list.
	// +optional
	policy?: null | xpv1.#Policy @go(Policy,*xpv1.Policy)
}

// EnvironmentSourceType specifies the way the EnvironmentConfig is selected.
#EnvironmentSourceType: string // #enumEnvironmentSourceType

#enumEnvironmentSourceType:
	#EnvironmentSourceTypeReference |
	#EnvironmentSourceTypeSelector

// EnvironmentSourceTypeReference by name.
#EnvironmentSourceTypeReference: #EnvironmentSourceType & "Reference"

// EnvironmentSourceTypeSelector by labels.
#EnvironmentSourceTypeSelector: #EnvironmentSourceType & "Selector"

// EnvironmentSource selects a EnvironmentConfig resource.
#EnvironmentSource: {
	// Type specifies the way the EnvironmentConfig is selected.
	// Default is `Reference`
	// +optional
	// +kubebuilder:validation:Enum=Reference;Selector
	// +kubebuilder:default=Reference
	type?: #EnvironmentSourceType @go(Type)

	// Ref is a named reference to a single EnvironmentConfig.
	// Either Ref or Selector is required.
	// +optional
	ref?: null | #EnvironmentSourceReference @go(Ref,*EnvironmentSourceReference)

	// Selector selects EnvironmentConfig(s) via labels.
	// +optional
	selector?: null | #EnvironmentSourceSelector @go(Selector,*EnvironmentSourceSelector)
}

// An EnvironmentSourceReference references an EnvironmentConfig by it's name.
#EnvironmentSourceReference: {
	// The name of the object.
	name: string @go(Name)
}

// EnvironmentSourceSelectorModeType specifies amount of retrieved EnvironmentConfigs
// with matching label.
#EnvironmentSourceSelectorModeType: string // #enumEnvironmentSourceSelectorModeType

#enumEnvironmentSourceSelectorModeType:
	#EnvironmentSourceSelectorSingleMode |
	#EnvironmentSourceSelectorMultiMode

// EnvironmentSourceSelectorSingleMode extracts only first EnvironmentConfig from the sorted list.
#EnvironmentSourceSelectorSingleMode: #EnvironmentSourceSelectorModeType & "Single"

// EnvironmentSourceSelectorMultiMode extracts multiple EnvironmentConfigs from the sorted list.
#EnvironmentSourceSelectorMultiMode: #EnvironmentSourceSelectorModeType & "Multiple"

// An EnvironmentSourceSelector selects an EnvironmentConfig via labels.
#EnvironmentSourceSelector: {
	// Mode specifies retrieval strategy: "Single" or "Multiple".
	// +kubebuilder:validation:Enum=Single;Multiple
	// +kubebuilder:default=Single
	mode?: #EnvironmentSourceSelectorModeType @go(Mode)

	// MaxMatch specifies the number of extracted EnvironmentConfigs in Multiple mode, extracts all if nil.
	maxMatch?: null | uint64 @go(MaxMatch,*uint64)

	// MinMatch specifies the required minimum of extracted EnvironmentConfigs in Multiple mode.
	minMatch?: null | uint64 @go(MinMatch,*uint64)

	// SortByFieldPath is the path to the field based on which list of EnvironmentConfigs is alphabetically sorted.
	// +kubebuilder:default="metadata.name"
	sortByFieldPath?: string @go(SortByFieldPath)

	// MatchLabels ensures an object with matching labels is selected.
	matchLabels?: [...#EnvironmentSourceSelectorLabelMatcher] @go(MatchLabels,[]EnvironmentSourceSelectorLabelMatcher)
}

// EnvironmentSourceSelectorLabelMatcherType specifies where the value for a
// label comes from.
#EnvironmentSourceSelectorLabelMatcherType: string // #enumEnvironmentSourceSelectorLabelMatcherType

#enumEnvironmentSourceSelectorLabelMatcherType:
	#EnvironmentSourceSelectorLabelMatcherTypeFromCompositeFieldPath |
	#EnvironmentSourceSelectorLabelMatcherTypeValue

// EnvironmentSourceSelectorLabelMatcherTypeFromCompositeFieldPath extracts
// the label value from a composite fieldpath.
#EnvironmentSourceSelectorLabelMatcherTypeFromCompositeFieldPath: #EnvironmentSourceSelectorLabelMatcherType & "FromCompositeFieldPath"

// EnvironmentSourceSelectorLabelMatcherTypeValue uses a literal as label
// value.
#EnvironmentSourceSelectorLabelMatcherTypeValue: #EnvironmentSourceSelectorLabelMatcherType & "Value"

// An EnvironmentSourceSelectorLabelMatcher acts like a k8s label selector but
// can draw the label value from a different path.
#EnvironmentSourceSelectorLabelMatcher: {
	// Type specifies where the value for a label comes from.
	// +optional
	// +kubebuilder:validation:Enum=FromCompositeFieldPath;Value
	// +kubebuilder:default=FromCompositeFieldPath
	type?: #EnvironmentSourceSelectorLabelMatcherType @go(Type)

	// Key of the label to match.
	key: string @go(Key)

	// ValueFromFieldPath specifies the field path to look for the label value.
	valueFromFieldPath?: null | string @go(ValueFromFieldPath,*string)

	// FromFieldPathPolicy specifies the policy for the valueFromFieldPath.
	// The default is Required, meaning that an error will be returned if the
	// field is not found in the composite resource.
	// Optional means that if the field is not found in the composite resource,
	// that label pair will just be skipped. N.B. other specified label
	// matchers will still be used to retrieve the desired
	// environment config, if any.
	// +kubebuilder:validation:Enum=Optional;Required
	// +kubebuilder:default=Required
	fromFieldPathPolicy?: null | #FromFieldPathPolicy @go(FromFieldPathPolicy,*FromFieldPathPolicy)

	// Value specifies a literal label value.
	value?: null | string @go(Value,*string)
}

// EnvironmentPatch is a patch for a Composition environment.
#EnvironmentPatch: {
	// Type sets the patching behaviour to be used. Each patch type may require
	// its own fields to be set on the Patch object.
	// +optional
	// +kubebuilder:validation:Enum=FromCompositeFieldPath;ToCompositeFieldPath;CombineFromComposite;CombineToComposite
	// +kubebuilder:default=FromCompositeFieldPath
	type?: #PatchType @go(Type)

	// FromFieldPath is the path of the field on the resource whose value is
	// to be used as input. Required when type is FromCompositeFieldPath or
	// ToCompositeFieldPath.
	// +optional
	fromFieldPath?: null | string @go(FromFieldPath,*string)

	// Combine is the patch configuration for a CombineFromComposite or
	// CombineToComposite patch.
	// +optional
	combine?: null | #Combine @go(Combine,*Combine)

	// ToFieldPath is the path of the field on the resource whose value will
	// be changed with the result of transforms. Leave empty if you'd like to
	// propagate to the same path as fromFieldPath.
	// +optional
	toFieldPath?: null | string @go(ToFieldPath,*string)

	// Transforms are the list of functions that are used as a FIFO pipe for the
	// input to be transformed.
	// +optional
	transforms?: [...#Transform] @go(Transforms,[]Transform)

	// Policy configures the specifics of patching behaviour.
	// +optional
	policy?: null | #PatchPolicy @go(Policy,*PatchPolicy)
}
