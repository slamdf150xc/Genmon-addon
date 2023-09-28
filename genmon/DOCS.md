# Home Assistant Community Add-on: GenMon

This is a GenMon add-on for Home Assistant.

## Configuration

All of the following configurations are optional. These settings were the common
settings that I needed for my environment. Any settings set here on the inital run
of the addon will be set in the config files. All of these settings can also be
set in the GUI.

All config files are accessable in the /addons/genmon directory in Home Assistant.
This will allow the config changes to persist across updates.

**Note**: _Currently, any settings changed after the inital run won't be reflected in the app._

GenMon add-on configuration:

```yaml
sitename: Testing
serial_tcp_ip_address: 10.10.10.35
serial_tcp_port: 6638
enable_mqtt: true
mqtt_ip_address: 172.17.0.2
mqtt_username: mqtt
mqtt_password: MySuperS3retP@ssw0rd!
mqtt_port: 1883
fuel_type: Natural Gas
generator_size: 26
```

### Option: `sitename`

The `sitename` option sets the Site Name for the Genmon software.

### Option: `serial_tcp_ip_address`

Sets IP address of the Genmon rs232 bridge.

### Option: `serial_tcp_port`

Sets the port the Genmon rs232 bridge exposes.

### Option: `fuel_type`

The fuel type your generator runs on.

### Option: `generator_size`

The kWh of your generator.

### Option: `enable_mqtt`

If enabled, MQTT will be set to `True` in genloader.conf.

### Option: `mqtt_ip_address`

The IP address of your MQTT server.

### Option: `mqtt_username`

The user name to authenticate to your MQTT server.

### Option: `mqtt_password`

The password for the MQTT user.

### Option: `mqtt_port`

The port exposed by your MQTT server.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Community Add-ons Discord chat server][discord] for add-on
  support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

## Authors & contributors

The original setup of this repository is by [Randy Brown][randy].

## License

MIT License

Copyright (c) 2023 Randy Brown

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=a0d7b954_example&repository_url=https%3A%2F%2Fgithub.com%2Fhassio-addons%2Frepository
[contributors]: https://github.com/hassio-addons/addon-example/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord]: https://discord.me/hassioaddons
[forum]: https://community.home-assistant.io/t/repository-community-hass-io-add-ons/24705?u=frenck
[randy]: https://github.com/slamdf150xc/
[issue]: https://github.com/hassio-addons/addon-example/issues
[reddit]: https://reddit.com/r/homeassistant
[releases]: https://github.com/hassio-addons/addon-example/releases
[semver]: http://semver.org/spec/v2.0.0.html
