package tracing

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/log"
	"github.com/owncloud/ocis/v2/ocis-pkg/tracing"
	"github.com/owncloud/ocis/v2/services/gateway/pkg/config"
	"go.opentelemetry.io/otel/trace"
)

var (
	// TraceProvider is the global trace provider for the service.
	TraceProvider = trace.NewNoopTracerProvider()
)

// Configure checks all necessary settings and returns an error if something is wrong.
func Configure(cfg *config.Config, logger log.Logger) error {
	tracing.Configure(cfg.Tracing.Enabled, cfg.Tracing.Type, logger)
	return nil
}
