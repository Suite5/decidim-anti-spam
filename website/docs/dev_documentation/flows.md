---
sidebar_position: 4
description: Understand the code
---

# Understand Flows

A flow in anti-spam is triggered at some point of the application (an update of user profile), and will under conditions, do actions. 

From the administration side, you can define for a flow what to actions to take under what conditions. 

- A flow starts from a trigger (`update user`, `add comments`), etc
  - This trigger lays inside a model or a form validation. Triggers are fixed, and validations are injected by the module. 
- A triggered flows will run all the configured conditions.
  - A condition result can be `invalid` if the tested content is invalid, and `valid` otherwise.
- If one or more condition is `invalid`, the flow run actions

<iframe style={{ border: "none" }} width="800" height="450" src="https://whimsical.com/embed/NQdNLkdBRD542bQinuhJVi@or4CdLRbgroa49wxU6JqtA38yckqDjveTkauaxjKV"></iframe>


## Triggers
Triggers are injected in models or form, they use a common interface, `Decidim::SpamSignal::Flows::FlowValidator`. Very roughtly, it does this: 

```
module MyAntispamTrigger
  include Decidim::SpamSignal::Flows::FlowValidator
  validate :detect_spam!

  # .... methods required by Decidim::SpamSignal::Flows::FlowValidator to works
end

# In an intiailizer
Decidim::User.include(MyAntispamTrigger)
```
## Registry
The module works with two registries: 

1. `actions_registry`: Keep configurations of actions commands and admin settings form. 
2. `conditions_registry`: Keep conditions commands and admin settings form. 

This registries are accessible through `Decidim::SpamSignal.config`, and are both instances of the same class, `Decidim::SpamSignal::ManifestRegistry::SpamManifestRegistry`. 

A registry have some usefull methods: 

- `register(name, form, command)`: register a (form,command) tuple with the identifier `name`.
- `command_for(name)`: The command class for the given name
- `form_for(name)`: The admin settings form for the given name. 

## Conditions
Conditions are registred in `Decidim::SpamSignal.config.conditions_registry`, with a form and command. 

Command:
- A condition command will have the tested content, and some context to be able to run
- A condition can return `valid` or `invalid` 


Form: 
- A condition form can define attribute like any Decidim::Form. We add through `SpamSettingsFormBuilder` some conventions to build faster forms in this specific modules, as described in [Add Condition](./add_condition) documentation.
