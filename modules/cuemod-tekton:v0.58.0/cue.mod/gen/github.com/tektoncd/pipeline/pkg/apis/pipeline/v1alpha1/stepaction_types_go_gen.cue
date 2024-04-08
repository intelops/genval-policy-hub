// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/pipeline/v1alpha1

package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	corev1 "k8s.io/api/core/v1"
	"github.com/tektoncd/pipeline/pkg/apis/pipeline/v1"
)

// StepAction represents the actionable components of Step.
// The Step can only reference it from the cluster or using remote resolution.
//
// +k8s:openapi-gen=true
#StepAction: {
	metav1.#TypeMeta

	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec holds the desired state of the Step from the client
	// +optional
	spec?: #StepActionSpec @go(Spec)
}

// StepActionList contains a list of StepActions
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
#StepActionList: {
	metav1.#TypeMeta

	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#StepAction] @go(Items,[]StepAction)
}

// StepActionSpec contains the actionable components of a step.
#StepActionSpec: {
	// Image reference name to run for this StepAction.
	// More info: https://kubernetes.io/docs/concepts/containers/images
	// +optional
	image?: string @go(Image) @protobuf(2,bytes,opt)

	// Entrypoint array. Not executed within a shell.
	// The image's ENTRYPOINT is used if this is not provided.
	// Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
	// cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
	// to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
	// produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
	// of whether the variable exists or not. Cannot be updated.
	// More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
	// +optional
	// +listType=atomic
	command?: [...string] @go(Command,[]string) @protobuf(3,bytes,rep)

	// Arguments to the entrypoint.
	// The image's CMD is used if this is not provided.
	// Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
	// cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
	// to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
	// produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
	// of whether the variable exists or not. Cannot be updated.
	// More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
	// +optional
	// +listType=atomic
	args?: [...string] @go(Args,[]string) @protobuf(4,bytes,rep)

	// List of environment variables to set in the container.
	// Cannot be updated.
	// +optional
	// +patchMergeKey=name
	// +patchStrategy=merge
	// +listType=atomic
	env?: [...corev1.#EnvVar] @go(Env,[]corev1.EnvVar) @protobuf(7,bytes,rep)

	// Script is the contents of an executable file to execute.
	//
	// If Script is not empty, the Step cannot have an Command and the Args will be passed to the Script.
	// +optional
	script?: string @go(Script)

	// Step's working directory.
	// If not specified, the container runtime's default will be used, which
	// might be configured in the container image.
	// Cannot be updated.
	// +optional
	workingDir?: string @go(WorkingDir) @protobuf(5,bytes,opt)

	// Params is a list of input parameters required to run the stepAction.
	// Params must be supplied as inputs in Steps unless they declare a defaultvalue.
	// +optional
	// +listType=atomic
	params?: v1.#ParamSpecs @go(Params)

	// Results are values that this StepAction can output
	// +optional
	// +listType=atomic
	results?: [...v1.#StepResult] @go(Results,[]v1.StepResult)

	// SecurityContext defines the security options the Step should be run with.
	// If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
	// More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
	// The value set in StepAction will take precedence over the value from Task.
	// +optional
	securityContext?: null | corev1.#SecurityContext @go(SecurityContext,*corev1.SecurityContext) @protobuf(15,bytes,opt)

	// Volumes to mount into the Step's filesystem.
	// Cannot be updated.
	// +optional
	// +patchMergeKey=mountPath
	// +patchStrategy=merge
	// +listType=atomic
	volumeMounts?: [...corev1.#VolumeMount] @go(VolumeMounts,[]corev1.VolumeMount) @protobuf(9,bytes,rep)
}

// StepActionObject is implemented by StepAction
#StepActionObject: _
