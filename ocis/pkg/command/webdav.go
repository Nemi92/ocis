package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/webdav/pkg/command"
	"github.com/urfave/cli/v2"
)

// WebDAVCommand is the entrypoint for the webdav command.
func WebDAVCommand(cfg *config.Config) *cli.Command {

	return &cli.Command{
		Name:     cfg.WebDAV.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.WebDAV.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.WebDAV.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.WebDAV),
	}
}

func init() {
	register.AddCommand(WebDAVCommand)
}
