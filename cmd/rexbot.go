/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"log"
	"os"
	"time"

	telebot "gopkg.in/telebot.v3"
)

var (
	//TELETOKEN
	teletoken = os.Getenv("TELE_TOKEN")
)


// rexbotCmd represents the rexbot command
var rexbotCmd = &cobra.Command{
	Use:   "rexbot",
	Aliases: []string{"start"},
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("rexbot %s started", version)

		rexbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  teletoken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatal("Please check TELE_TOKEN env variable, %s", err)
			return
		}

		rexbot.Handle(telebot.OnText, func(c telebot.Context) error {
			// All the text messages that weren't
			// captured by existing handlers.
			log.Print(c.Message().Payload, c.Text)
			payload := c.Message().Payload

			switch(payload) {
			case "hello":
				err = c.Send(fmt.Sprintf("Hello! I'm RexBot, %s", version))
			}

			return err

		})

		rexbot.Start()
	},
}

func init() {
	rootCmd.AddCommand(rexbotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// rexbotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// rexbotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
