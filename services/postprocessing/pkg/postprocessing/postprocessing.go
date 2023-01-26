package postprocessing

import (
	"time"

	user "github.com/cs3org/go-cs3apis/cs3/identity/user/v1beta1"
	provider "github.com/cs3org/go-cs3apis/cs3/storage/provider/v1beta1"
	"github.com/cs3org/reva/v2/pkg/events"
)

// Postprocessing handles postprocessing of a file
type Postprocessing struct {
	id         string
	url        string
	u          *user.User
	m          map[events.Postprocessingstep]interface{}
	filename   string
	filesize   uint64
	resourceID *provider.ResourceId
	steps      []events.Postprocessingstep
	delay      time.Duration
}

// New returns a new postprocessing instance
func New(uploadID string, uploadURL string, user *user.User, filename string, filesize uint64, resourceID *provider.ResourceId, steps []events.Postprocessingstep, delay time.Duration) *Postprocessing {
	return &Postprocessing{
		id:         uploadID,
		url:        uploadURL,
		u:          user,
		m:          make(map[events.Postprocessingstep]interface{}),
		filename:   filename,
		filesize:   filesize,
		resourceID: resourceID,
		steps:      steps,
		delay:      delay,
	}
}

// Init is the first step of the postprocessing
func (pp *Postprocessing) Init(ev events.BytesReceived) interface{} {
	pp.m["init"] = ev

	if len(pp.steps) == 0 {
		return pp.finished(events.PPOutcomeContinue)
	}

	return pp.nextStep(pp.steps[0])
}

// NextStep returns the next postprocessing step
func (pp *Postprocessing) NextStep(ev events.PostprocessingStepFinished) interface{} {
	pp.m[ev.FinishedStep] = ev

	switch ev.Outcome {
	case events.PPOutcomeContinue:
		return pp.next(ev.FinishedStep)
	default:
		return pp.finished(ev.Outcome)
	}
}

// Delay will sleep the configured time then continue
func (pp *Postprocessing) Delay(ev events.StartPostprocessingStep) interface{} {
	pp.m[events.PPStepDelay] = ev
	time.Sleep(pp.delay)
	return pp.next(events.PPStepDelay)
}

func (pp *Postprocessing) next(current events.Postprocessingstep) interface{} {
	l := len(pp.steps)
	for i, s := range pp.steps {
		if s == current && i+1 < l {
			return pp.nextStep(pp.steps[i+1])
		}
	}
	return pp.finished(events.PPOutcomeContinue)
}

func (pp *Postprocessing) nextStep(next events.Postprocessingstep) events.StartPostprocessingStep {
	return events.StartPostprocessingStep{
		UploadID:      pp.id,
		URL:           pp.url,
		ExecutingUser: pp.u,
		Filename:      pp.filename,
		Filesize:      pp.filesize,
		ResourceID:    pp.resourceID,
		StepToStart:   next,
	}
}

func (pp *Postprocessing) finished(outcome events.PostprocessingOutcome) events.PostprocessingFinished {
	return events.PostprocessingFinished{
		UploadID:      pp.id,
		Result:        pp.m,
		ExecutingUser: pp.u,
		Filename:      pp.filename,
		Outcome:       outcome,
	}
}
