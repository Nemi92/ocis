package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/sharing/pkg/command"
	"github.com/urfave/cli/v2"
)

// SharingCommand is the entrypoint for the Sharing command.
func SharingCommand(cfg *config.Config) *cli.Command {
	return &cli.Command{
		Name:     cfg.Sharing.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.Sharing.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.Sharing.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.Sharing),
	}
}

func init() {
	register.AddCommand(SharingCommand)
}
