package http

import (
	"fmt"

	chimiddleware "github.com/go-chi/chi/v5/middleware"
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/cors"
	"github.com/owncloud/ocis/v2/ocis-pkg/middleware"
	"github.com/owncloud/ocis/v2/ocis-pkg/service/http"
	"github.com/owncloud/ocis/v2/ocis-pkg/version"
	svc "github.com/owncloud/ocis/v2/services/webdav/pkg/service/v0"
	"go-micro.dev/v4"
)

// Server initializes the http service and server.
func Server(opts ...Option) (http.Service, error) {
	options := newOptions(opts...)

	tlsConfig, err := config.BuildTLSConfig(
		options.Logger,
		options.Config.HTTP.TLS.Enabled,
		options.Config.HTTP.TLS.Cert,
		options.Config.HTTP.TLS.Key,
		options.Config.HTTP.Addr,
	)
	if err != nil {
		options.Logger.Error().
			Err(err).
			Msg("could not build certificate")
		return http.Service{}, fmt.Errorf("could not build certificate: %w", err)
	}

	service, err := http.NewService(
		http.TLSConfig(tlsConfig),
		http.Logger(options.Logger),
		http.Namespace(options.Config.HTTP.Namespace),
		http.Name(options.Config.Service.Name),
		http.Version(version.GetString()),
		http.Address(options.Config.HTTP.Addr),
		http.Context(options.Context),
		http.Flags(options.Flags...),
	)
	if err != nil {
		options.Logger.Error().
			Err(err).
			Msg("Error initializing http service")
		return http.Service{}, fmt.Errorf("could not initialize http service: %w", err)
	}

	handle, err := svc.NewService(
		svc.Logger(options.Logger),
		svc.Config(options.Config),
		svc.Middleware(
			chimiddleware.RealIP,
			chimiddleware.RequestID,
			middleware.NoCache,
			middleware.Cors(
				cors.Logger(options.Logger),
				cors.AllowedOrigins(options.Config.HTTP.CORS.AllowedOrigins),
				cors.AllowedMethods(options.Config.HTTP.CORS.AllowedMethods),
				cors.AllowedHeaders(options.Config.HTTP.CORS.AllowedHeaders),
				cors.AllowCredentials(options.Config.HTTP.CORS.AllowCredentials),
			),
			middleware.Secure,
			middleware.Version(
				options.Config.Service.Name,
				version.GetString(),
			),
			middleware.Logger(
				options.Logger,
			),
		),
	)
	if err != nil {
		return http.Service{}, err
	}

	{
		handle = svc.NewInstrument(handle, options.Metrics)
		handle = svc.NewLogging(handle, options.Logger)
		handle = svc.NewTracing(handle)
	}

	if err := micro.RegisterHandler(service.Server(), handle); err != nil {
		return http.Service{}, err
	}

	return service, nil
}
