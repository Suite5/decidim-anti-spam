---
sidebar_position: 2
slug: /install
title: Installation
description: How to install the module
---

### Support Table
| Decidim Version | Supported?  |
|-----------------|-------------|
| 0.24            | no          |
| 0.26            | yes         |
| 0.27            | yes         |
| 0.28            | no          |
| 0.29            | yes         |

# Install the anti-spam

**Add the gem to your Gemfile**<br />
```ruby
gem "decidim-spam_signal", "~> 0.2.0"
```

**Install the module**<br />
```ruby
bundle install
```

**Copy migrations files**<br />
```ruby
bundle exec rails decidim_spam_signal_admin:install:migrations
```

**Migrate**<br />
```ruby
bundle exec rails db:migrate
```
(you can make sure migrations pass with bundle exec rails db:migrate:status)

# Configure Nginx GeoIP

The 0.29 version introduces country and continent verification to prevent certain actions from locations where spam could originate.

To do this, the module requires additional headers, which can be configured through Nginx.

In the file `#/etc/nginx/nginx.conf`<br />
Insert in the section `server/location`
```bash
#/etc/nginx/nginx.conf
proxy_set_header X-Country $geoip2_data_country_code;
proxy_set_header X-Continent $geoip2_data_continent_code;
proxy_set_header GEOIP "enabled";
proxy_set_header COUNTRY $geoip2_data_country_code;
proxy_set_header CONTINENT $geoip2_data_continent_code;
```

In the file `/etc/nginx/conf.d/geoip2-mapping.conf`
```bash
#/etc/nginx/conf.d/geoip2-mapping.conf
geoip2 /usr/local/share/GeoIP/GeoLite2-City.mmdb {
    auto_reload                    5m;
    $geoip2_metadata_country_build metadata build_epoch;
    $geoip2_data_country_code      default=US source=$http_x_forwarded_for country iso_code;
    $geoip2_data_country_name      source=$http_x_forwarded_for country names en;
    $geoip2_data_continent_code    source=$http_x_forwarded_for continent code;
}

map $geoip2_data_country_code $allowed_country {
    default yes;
    include includes/geoip2-defaultlist.conf;
}
```

In the file `/etc/nginx/includes/geoip2-server.conf`
```bash
#/etc/nginx/includes/geoip2-server.conf
set $country_code $geoip2_data_country_code;
set $country_name $geoip2_data_country_name;
```
