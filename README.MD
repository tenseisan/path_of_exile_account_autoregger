# Path of Exile Account Autoregger

Some simple script for full cycle of registration account for Path of Exile game
1. Captcha resolve
2. Email account confirmation
3. Use GetNada mail service

**Important notice:** Script use only https://anti-captcha.com/ api for captcha resolving

**Important notice#2:** Your IP is will be temporary banned after 10-20 accounts, use proxy/vpn (script isnt support it yet)
### Require

```
ruby 2.7+
anti-captcha.com
```
### Installing

```
bundle install
```

## How To Run

```
ruby script_runner.rb
```

## TODO
- rspec
- some other mail services
- update captcha class to be more universal with another captcha types
- add some other service for auto reg, like twitch, etc etc...
- add proxy functional
- refactor script_runner to be more universal
- threads?
## Author

* https://t.me/tenseisan