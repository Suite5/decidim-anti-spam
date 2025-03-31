---
sidebar_position: 6
description: How to develop a new condition
---
# Develop your own Condition
A condition is made up of two classes: a Command class and a Form class (for settings).

1. The `Form` will define admin settings to customize the condition
2. The `Command` will define how you run the condition. 

These two classes will be the registred through `Decidim::SpamSignal.config.conditions_manifest`. 

## Condition Form
A Condition Form will define admin settings. 
Inherit from `Decidim::Form` and include `Decidim::SpamSignal::SettingsForm`. 
```ruby
class CustomSettingsForm < Decidim::Form
    include Decidim::SpamSignal::SettingsForm
    attribute :foo_enabled, Boolean, default: false
end
```

The form attributes have some rules, to let you have a better form: 

* If it starts with `is_` or ends with `_enabled`, it will generate a checkbox.
* If it ends with `_csv`, it will generate a textarea.
* The rest follows Decidim's default form builder conventions.

## Condition Command 

A condition command inherit from `Decidim::SpamSignal::Conditions::ConditionHandler` and will implement a `call` method. 
This `call` method can return: 

- `invalid`: The submitted content is not ok, and should trigger the condition
- `valid`: The submitted content is ok, and should not trigger the condition. 


```ruby
class CustomConditionCommand < Decidim::SpamSignal::Conditions::ConditionHandler
    def call
        return broadcast(:invalid) if suspicious_content.include? "maga"
        broadcast(:ok)
    end
end
```

In a Condition command, you have access to these attributes: 

| Attribute | Description |
| ========= | =========== |
| suspicious_content | The content that is suspicious |
| config | The current command settings |
| context.current_user | The  current organization |
| context.suspicious_user | The current user author of the suspicious_content |


## Register the condition
Now, you can register your condition in an initializer:
```ruby
Decidim::SpamSignal.config.conditions_registry.register(
    :custom_condition, # The identifier of your condition
    CustomSettingsForm,
    CustomConditionCommand
)
```

And set the i18n fields: 

* `decidim.spam_signal.conditions.custom_condition.name`
* `decidim.spam_signal.conditions.custom_condition.description`
* `decidim.spam_signal.conditions.custom_condition.custom_settings_form.foo_enabled`
