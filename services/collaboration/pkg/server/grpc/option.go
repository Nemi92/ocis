package grpc

import (
	"context"

	"github.com/owncloud/ocis/v2/ocis-pkg/log"
	"github.com/owncloud/ocis/v2/services/collaboration/pkg/config"
	"github.com/owncloud/ocis/v2/services/collaboration/pkg/internal/app"
	"go.opentelemetry.io/otel/trace"
)

// Option defines a single option function.
type Option func(o *Options)

// Options defines the available options for this package.
type Options struct {
	App           *app.DemoApp
	Name          string
	Logger        log.Logger
	Context       context.Context
	Config        *config.Config
	TraceProvider trace.TracerProvider
}

// newOptions initializes the available default options.
func newOptions(opts ...Option) Options {
	opt := Options{}

	for _, o := range opts {
		o(&opt)
	}

	return opt
}

// App provides a function to set the logger option.
func App(val *app.DemoApp) Option {
	return func(o *Options) {
		o.App = val
	}
}

// Name provides a name for the service.
func Name(val string) Option {
	return func(o *Options) {
		o.Name = val
	}
}

// Logger provides a function to set the logger option.
func Logger(val log.Logger) Option {
	return func(o *Options) {
		o.Logger = val
	}
}

// Context provides a function to set the context option.
func Context(val context.Context) Option {
	return func(o *Options) {
		o.Context = val
	}
}

// Config provides a function to set the config option.
func Config(val *config.Config) Option {
	return func(o *Options) {
		o.Config = val
	}
}

// TraceProvider provides a function to set the trace provider option.
func TraceProvider(val trace.TracerProvider) Option {
	return func(o *Options) {
		o.TraceProvider = val
	}
}
