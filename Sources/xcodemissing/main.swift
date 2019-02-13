import Commandant

let registry = CommandRegistry<CommandantError<()>>()
registry.register(DeleteCommand())
registry.register(FindCommand())

let helpCommand = HelpCommand(registry: registry)
registry.register(helpCommand)

registry.main(defaultVerb: helpCommand.verb) { error in
    print(error)
}
