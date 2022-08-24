package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/storage-system/pkg/command"
	"github.com/urfave/cli/v2"
)

// StorageSystemCommand is the entrypoint for the StorageSystem command.
func StorageSystemCommand(cfg *config.Config) *cli.Command {
	return &cli.Command{
		Name:     cfg.StorageSystem.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.StorageSystem.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.StorageSystem.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.StorageSystem),
	}
}

func init() {
	register.AddCommand(StorageSystemCommand)
}
