# DevX CMS

[![Build Status](https://travis-ci.org/jcwproductions/devx.svg?branch=master)](https://travis-ci.org/jcwproductions/devx)

By [JCW Productions](https://jcwproductions.com)

DevX is an open source content management system.

## Getting started

DevX can be added to your Gemfile using the following:

```ruby
gem 'devx'
```

Run the bundle command to install it.

After you install DevX and add it to your Gemfile, you will need to run the generator:

```bash
rails generate devx:install
```

This will install all required migrations and mount the Engine to the routes.


## Shortcodes

DevX makes use of shortcodes (similar to Wordpress) that pull from a repository of custom plugins.

#### Slideshow

The slideshow plugin can be called using the following shortcode with `id` as an argument.


    [slideshow id="1"]


#### Media

The media plugin can be called using the following shortcode with `id`, `size`, `classes`, and `styles` as arguments.


    [media id="2" size="300x150" classes="blog_image" styles="margin-top:15px"]


#### Latest Articles
The latest article plugin can be called using the following shortcode with `limit` as an argument.

    [latest_articles limit="4"]


## Support

Submit bugs and feature requests to [JCW Support](mailto:support@jcwproductions.com).