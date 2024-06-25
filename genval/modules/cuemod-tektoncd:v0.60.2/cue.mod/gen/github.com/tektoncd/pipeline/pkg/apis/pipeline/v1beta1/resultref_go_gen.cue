// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/pipeline/v1beta1

package v1beta1

// ResultRef is a type that represents a reference to a task run result
#ResultRef: {
	pipelineTask:  string     @go(PipelineTask)
	result:        string     @go(Result)
	resultsIndex?: null | int @go(ResultsIndex,*int)
	property:      string     @go(Property)
}

// ResultTaskPart Constant used to define the "tasks" part of a pipeline result reference
// retained because of backwards compatibility
#ResultTaskPart: "tasks"

// ResultFinallyPart Constant used to define the "finally" part of a pipeline result reference
// retained because of backwards compatibility
#ResultFinallyPart: "finally"

// ResultResultPart Constant used to define the "results" part of a pipeline result reference
// retained because of backwards compatibility
#ResultResultPart: "results"

// TODO(#2462) use one regex across all substitutions
// variableSubstitutionFormat matches format like $result.resultname, $result.resultname[int] and $result.resultname[*]
_#variableSubstitutionFormat: "\\$\\([_a-zA-Z0-9.-]+(\\.[_a-zA-Z0-9.-]+)*(\\[([0-9]+|\\*)\\])?\\)" // `\$\([_a-zA-Z0-9.-]+(\.[_a-zA-Z0-9.-]+)*(\[([0-9]+|\*)\])?\)`

// exactVariableSubstitutionFormat matches strings that only contain a single reference to result or param variables, but nothing else
// i.e. `$(result.resultname)` is a match, but `foo $(result.resultname)` is not.
_#exactVariableSubstitutionFormat: "^\\$\\([_a-zA-Z0-9.-]+(\\.[_a-zA-Z0-9.-]+)*(\\[([0-9]+|\\*)\\])?\\)$" // `^\$\([_a-zA-Z0-9.-]+(\.[_a-zA-Z0-9.-]+)*(\[([0-9]+|\*)\])?\)$`

// ResultNameFormat Constant used to define the regex Result.Name should follow
#ResultNameFormat: "^([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9]$" // `^([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9]$`