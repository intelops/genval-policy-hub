// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/pipeline/v1

package v1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

// PipelineTaskOnErrorType defines a list of supported failure handling behaviors of a PipelineTask on error
#PipelineTaskOnErrorType: string // #enumPipelineTaskOnErrorType

#enumPipelineTaskOnErrorType:
	#PipelineTaskStopAndFail |
	#PipelineTaskContinue

// PipelineTasksAggregateStatus is a param representing aggregate status of all dag pipelineTasks
#PipelineTasksAggregateStatus: "tasks.status"

// PipelineTasks is a value representing a task is a member of "tasks" section of the pipeline
#PipelineTasks: "tasks"

// PipelineFinallyTasks is a value representing a task is a member of "finally" section of the pipeline
#PipelineFinallyTasks: "finally"

// PipelineTaskStopAndFail indicates to stop and fail the PipelineRun if the PipelineTask fails
#PipelineTaskStopAndFail: #PipelineTaskOnErrorType & "stopAndFail"

// PipelineTaskContinue indicates to continue executing the rest of the DAG when the PipelineTask fails
#PipelineTaskContinue: #PipelineTaskOnErrorType & "continue"

// Pipeline describes a list of Tasks to execute. It expresses how outputs
// of tasks feed into inputs of subsequent tasks.
// +k8s:openapi-gen=true
#Pipeline: {
	metav1.#TypeMeta

	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec holds the desired state of the Pipeline from the client
	// +optional
	spec?: #PipelineSpec @go(Spec)
}

// PipelineSpec defines the desired state of Pipeline.
#PipelineSpec: {
	// DisplayName is a user-facing name of the pipeline that may be
	// used to populate a UI.
	// +optional
	displayName?: string @go(DisplayName)

	// Description is a user-facing description of the pipeline that may be
	// used to populate a UI.
	// +optional
	description?: string @go(Description)

	// Tasks declares the graph of Tasks that execute when this Pipeline is run.
	// +listType=atomic
	tasks?: [...#PipelineTask] @go(Tasks,[]PipelineTask)

	// Params declares a list of input parameters that must be supplied when
	// this Pipeline is run.
	// +listType=atomic
	params?: #ParamSpecs @go(Params)

	// Workspaces declares a set of named workspaces that are expected to be
	// provided by a PipelineRun.
	// +optional
	// +listType=atomic
	workspaces?: [...#PipelineWorkspaceDeclaration] @go(Workspaces,[]PipelineWorkspaceDeclaration)

	// Results are values that this pipeline can output once run
	// +optional
	// +listType=atomic
	results?: [...#PipelineResult] @go(Results,[]PipelineResult)

	// Finally declares the list of Tasks that execute just before leaving the Pipeline
	// i.e. either after all Tasks are finished executing successfully
	// or after a failure which would result in ending the Pipeline
	// +listType=atomic
	finally?: [...#PipelineTask] @go(Finally,[]PipelineTask)
}

// PipelineResult used to describe the results of a pipeline
#PipelineResult: {
	// Name the given name
	name: string @go(Name)

	// Type is the user-specified type of the result.
	// The possible types are 'string', 'array', and 'object', with 'string' as the default.
	// 'array' and 'object' types are alpha features.
	type?: #ResultsType @go(Type)

	// Description is a human-readable description of the result
	// +optional
	description?: string @go(Description)

	// Value the expression used to retrieve the value
	value: #ParamValue @go(Value)
}

// PipelineTaskMetadata contains the labels or annotations for an EmbeddedTask
#PipelineTaskMetadata: {
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string)

	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string)
}

// EmbeddedTask is used to define a Task inline within a Pipeline's PipelineTasks.
#EmbeddedTask: {
	runtime.#TypeMeta

	// Spec is a specification of a custom task
	// +optional
	spec?: runtime.#RawExtension @go(Spec)

	// +optional
	metadata?: #PipelineTaskMetadata @go(Metadata)

	#TaskSpec
}

// PipelineTask defines a task in a Pipeline, passing inputs from both
// Params and from the output of previous tasks.
#PipelineTask: {
	// Name is the name of this task within the context of a Pipeline. Name is
	// used as a coordinate with the `from` and `runAfter` fields to establish
	// the execution order of tasks relative to one another.
	name?: string @go(Name)

	// DisplayName is the display name of this task within the context of a Pipeline.
	// This display name may be used to populate a UI.
	// +optional
	displayName?: string @go(DisplayName)

	// Description is the description of this task within the context of a Pipeline.
	// This description may be used to populate a UI.
	// +optional
	description?: string @go(Description)

	// TaskRef is a reference to a task definition.
	// +optional
	taskRef?: null | #TaskRef @go(TaskRef,*TaskRef)

	// TaskSpec is a specification of a task
	// Specifying TaskSpec can be disabled by setting
	// `disable-inline-spec` feature flag..
	// +optional
	taskSpec?: null | #EmbeddedTask @go(TaskSpec,*EmbeddedTask)

	// When is a list of when expressions that need to be true for the task to run
	// +optional
	when?: #WhenExpressions @go(When)

	// Retries represents how many times this task should be retried in case of task failure: ConditionSucceeded set to False
	// +optional
	retries?: int @go(Retries)

	// RunAfter is the list of PipelineTask names that should be executed before
	// this Task executes. (Used to force a specific ordering in graph execution.)
	// +optional
	// +listType=atomic
	runAfter?: [...string] @go(RunAfter,[]string)

	// Parameters declares parameters passed to this task.
	// +optional
	// +listType=atomic
	params?: #Params @go(Params)

	// Matrix declares parameters used to fan out this task.
	// +optional
	matrix?: null | #Matrix @go(Matrix,*Matrix)

	// Workspaces maps workspaces from the pipeline spec to the workspaces
	// declared in the Task.
	// +optional
	// +listType=atomic
	workspaces?: [...#WorkspacePipelineTaskBinding] @go(Workspaces,[]WorkspacePipelineTaskBinding)

	// Time after which the TaskRun times out. Defaults to 1 hour.
	// Refer Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// PipelineRef is a reference to a pipeline definition
	// Note: PipelineRef is in preview mode and not yet supported
	// +optional
	pipelineRef?: null | #PipelineRef @go(PipelineRef,*PipelineRef)

	// PipelineSpec is a specification of a pipeline
	// Note: PipelineSpec is in preview mode and not yet supported
	// Specifying PipelineSpec can be disabled by setting
	// `disable-inline-spec` feature flag..
	// +optional
	pipelineSpec?: null | #PipelineSpec @go(PipelineSpec,*PipelineSpec)

	// OnError defines the exiting behavior of a PipelineRun on error
	// can be set to [ continue | stopAndFail ]
	// +optional
	onError?: #PipelineTaskOnErrorType @go(OnError)
}

// PipelineTaskList is a list of PipelineTasks
#PipelineTaskList: [...#PipelineTask]

// PipelineTaskParam is used to provide arbitrary string parameters to a Task.
#PipelineTaskParam: {
	name:  string @go(Name)
	value: string @go(Value)
}

// PipelineList contains a list of Pipeline
#PipelineList: {
	metav1.#TypeMeta

	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Pipeline] @go(Items,[]Pipeline)
}
