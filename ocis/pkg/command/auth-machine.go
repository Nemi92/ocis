package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/auth-machine/pkg/command"
	"github.com/urfave/cli/v2"
)

// AuthMachineCommand is the entrypoint for the AuthMachine command.
func AuthMachineCommand(cfg *config.Config) *cli.Command {
	return &cli.Command{
		Name:     cfg.AuthMachine.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.AuthMachine.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.AuthMachine.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.AuthMachine),
	}
}

func init() {
	register.AddCommand(AuthMachineCommand)
}
