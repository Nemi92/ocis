package config

import "github.com/owncloud/ocis/v2/ocis-pkg/tracing"

// Tracing defines the available tracing configuration.
type Tracing struct {
	Enabled   bool   `yaml:"enabled" env:"OCIS_TRACING_ENABLED;SSE_TRACING_ENABLED" desc:"Activates tracing."`
	Type      string `yaml:"type" env:"OCIS_TRACING_TYPE;SSE_TRACING_TYPE" desc:"The type of tracing. Defaults to '', which is the same as 'jaeger'. Allowed tracing types are 'jaeger' and '' as of now."`
	Endpoint  string `yaml:"endpoint" env:"OCIS_TRACING_ENDPOINT;SSE_TRACING_ENDPOINT" desc:"The endpoint of the tracing agent."`
	Collector string `yaml:"collector" env:"OCIS_TRACING_COLLECTOR;SSE_TRACING_COLLECTOR" desc:"The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset."`
}

// Convert Tracing to the tracing package's Config struct.
func (t Tracing) Convert() tracing.Config {
	return tracing.Config{
		Enabled:   t.Enabled,
		Type:      t.Type,
		Endpoint:  t.Endpoint,
		Collector: t.Collector,
	}
}