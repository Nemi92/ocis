package defaults

import (
	"github.com/owncloud/ocis/v2/services/postprocessing/pkg/config"
)

// DefaultConfig is the default configuration
func DefaultConfig() *config.Config {
	return &config.Config{
		Service: config.Service{
			Name: "postprocessing",
		},
		Postprocessing: config.Postprocessing{
			Events: config.Events{
				Endpoint: "127.0.0.1:9233",
				Cluster:  "ocis-cluster",
			},
		},
	}
}

// EnsureDefaults adds default values to the configuration if they are not set yet
func EnsureDefaults(cfg *config.Config) {
	// provide with defaults for shared logging, since we need a valid destination address for BindEnv.
	if cfg.Log == nil && cfg.Commons != nil && cfg.Commons.Log != nil {
		cfg.Log = &config.Log{
			Level:  cfg.Commons.Log.Level,
			Pretty: cfg.Commons.Log.Pretty,
			Color:  cfg.Commons.Log.Color,
			File:   cfg.Commons.Log.File,
		}
	} else if cfg.Log == nil {
		cfg.Log = &config.Log{}
	}
}
