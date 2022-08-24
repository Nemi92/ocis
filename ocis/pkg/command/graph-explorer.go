package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/graph-explorer/pkg/command"
	"github.com/urfave/cli/v2"
)

// GraphExplorerCommand is the entrypoint for the graph-explorer command.
func GraphExplorerCommand(cfg *config.Config) *cli.Command {
	return &cli.Command{
		Name:     cfg.GraphExplorer.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.GraphExplorer.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.GraphExplorer.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.GraphExplorer),
	}
}

func init() {
	register.AddCommand(GraphExplorerCommand)
}
