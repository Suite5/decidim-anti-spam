---
sidebar_position: 1
id: my-home-doc
slug: /
---

# How does it work?

Behind the scenes, Decidim works with `Ruby on Rails`, which has a really nice way to validate things before saving them. For example:

- A user saves their profile
- Rails runs all validators
- If it's valid, it saves. If not, it shows an error

This module will __add dynamic and configurable validators through flows__, which will check a user’s action and validate the conditions for that action. The flow will then be able to trigger reactions for some of Decidim’s most critical resources.

- The user's profiles
- The user's personal URL
- The writing of comments
- The creating or updating a meeting
- The creating or updating a proposal
- Ability to login and register

With this anti-spam module, the flows will always perform like this:

- Check the user action
- Validates the conditions you have configured
- If your condition classify the action as `spam`, then executes the actions you have configured

This will allow you to add few conditions rules at the beginning of the installation and change your conditions according to spammers' pressure.


## With the support of

![City of Lausanne and State of Geneva](/decidim_anti_spam_supports.png)