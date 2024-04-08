// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/v1alpha1

package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// ResourceRef is a reference to a resource.
#ResourceRef: {
	// Name of the referent.
	name: string @go(Name)
}

// ResourceSelector is a selector to a resource.
#ResourceSelector: {
	// MatchLabels ensures an object with matching labels is selected.
	matchLabels?: {[string]: string} @go(MatchLabels,map[string]string)

	// MatchControllerRef ensures an object with the same controller reference
	// as the selecting object is selected.
	matchControllerRef?: null | bool @go(MatchControllerRef,*bool)
}

// Resource defines a cluster-scoped resource.
#Resource: {
	// API version of the referent.
	// +optional
	apiVersion?: string @go(APIVersion)

	// Kind of the referent.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	// +optional
	kind?: string @go(Kind)

	// Reference to the resource.
	// +optional
	resourceRef?: null | #ResourceRef @go(ResourceRef,*ResourceRef)

	// Selector to the resource.
	// This field will be ignored if ResourceRef is set.
	// +optional
	resourceSelector?: null | #ResourceSelector @go(ResourceSelector,*ResourceSelector)
}

// UsageSpec defines the desired state of Usage.
#UsageSpec: {
	// Of is the resource that is "being used".
	// +kubebuilder:validation:XValidation:rule="has(self.resourceRef) || has(self.resourceSelector)",message="either a resource reference or a resource selector should be set."
	of: #Resource @go(Of)

	// By is the resource that is "using the other resource".
	// +optional
	// +kubebuilder:validation:XValidation:rule="has(self.resourceRef) || has(self.resourceSelector)",message="either a resource reference or a resource selector should be set."
	by?: null | #Resource @go(By,*Resource)

	// Reason is the reason for blocking deletion of the resource.
	// +optional
	reason?: null | string @go(Reason,*string)

	// ReplayDeletion will trigger a deletion on the used resource during the deletion of the usage itself, if it was attempted to be deleted at least once.
	// +optional
	replayDeletion?: null | bool @go(ReplayDeletion,*bool)
}

// UsageStatus defines the observed state of Usage.
#UsageStatus: {
	xpv1.#ConditionedStatus
}

// A Usage defines a deletion blocking relationship between two resources.
// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +kubebuilder:printcolumn:name="DETAILS",type="string",JSONPath=".metadata.annotations.crossplane\\.io/usage-details"
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
#Usage: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="has(self.by) || has(self.reason)",message="either \"spec.by\" or \"spec.reason\" must be specified."
	spec:    #UsageSpec   @go(Spec)
	status?: #UsageStatus @go(Status)
}

// UsageList contains a list of Usage.
#UsageList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Usage] @go(Items,[]Usage)
}
