// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/config

package config

// FormatTektonV1 represents the "v1" events in Tekton custom format
#FormatTektonV1: #EventFormat & "tektonv1"

// DefaultSink is the default value for "sink"
#DefaultSink: ""
_#formatsKey: "formats"
_#sinkKey:    "sink"

// Events holds the events configurations
// +k8s:deepcopy-gen=true
#Events: {
	Sink:    string
	Formats: #EventFormats
}

// EventFormat is a single event format
#EventFormat: string // #enumEventFormat

#enumEventFormat:
	#FormatTektonV1

// EventFormats is a set of event formats
#EventFormats: {[string]: {
}}
