// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/config

package config

import (
	"github.com/tektoncd/pipeline/pkg/apis/pipeline/pod"
	corev1 "k8s.io/api/core/v1"
)

// DefaultTimeoutMinutes is used when no timeout is specified.
#DefaultTimeoutMinutes: 60

// NoTimeoutDuration is used when a pipeline or task should never time out.
#NoTimeoutDuration: int & 0

// DefaultServiceAccountValue is the SA used when one is not specified.
#DefaultServiceAccountValue: "default"

// DefaultManagedByLabelValue is the value for the managed-by label that is used by default.
#DefaultManagedByLabelValue: "tekton-pipelines"

// DefaultCloudEventSinkValue is the default value for cloud event sinks.
#DefaultCloudEventSinkValue: ""

// DefaultMaxMatrixCombinationsCount is used when no max matrix combinations count is specified.
#DefaultMaxMatrixCombinationsCount: 256

// DefaultResolverTypeValue is used when no default resolver type is specified
#DefaultResolverTypeValue: ""

// default resource requirements, will be applied to all the containers, which has empty resource requirements
#ResourceRequirementDefaultContainerKey:   "default"
#DefaultImagePullBackOffTimeout:           int & 0
_#defaultTimeoutMinutesKey:                "default-timeout-minutes"
_#defaultServiceAccountKey:                "default-service-account"
_#defaultManagedByLabelValueKey:           "default-managed-by-label-value"
_#defaultPodTemplateKey:                   "default-pod-template"
_#defaultAAPodTemplateKey:                 "default-affinity-assistant-pod-template"
_#defaultCloudEventsSinkKey:               "default-cloud-events-sink"
_#defaultTaskRunWorkspaceBinding:          "default-task-run-workspace-binding"
_#defaultMaxMatrixCombinationsCountKey:    "default-max-matrix-combinations-count"
_#defaultForbiddenEnv:                     "default-forbidden-env"
_#defaultResolverTypeKey:                  "default-resolver-type"
_#defaultContainerResourceRequirementsKey: "default-container-resource-requirements"
_#defaultImagePullBackOffTimeout:          "default-imagepullbackoff-timeout"

// Defaults holds the default configurations
// +k8s:deepcopy-gen=true
#Defaults: {
	DefaultTimeoutMinutes:             int
	DefaultServiceAccount:             string
	DefaultManagedByLabelValue:        string
	DefaultPodTemplate?:               null | pod.#Template                  @go(,*pod.Template)
	DefaultAAPodTemplate?:             null | pod.#AffinityAssistantTemplate @go(,*pod.AffinityAssistantTemplate)
	DefaultCloudEventsSink:            string
	DefaultTaskRunWorkspaceBinding:    string
	DefaultMaxMatrixCombinationsCount: int
	DefaultForbiddenEnv: [...string] @go(,[]string)
	DefaultResolverType: string
	DefaultContainerResourceRequirements: {[string]: corev1.#ResourceRequirements} @go(,map[string]corev1.ResourceRequirements)
	DefaultImagePullBackOffTimeout: int @go(,time.Duration)
}
