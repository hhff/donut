# :doughnut: Donut

[![Build Status](https://travis-ci.org/hhff/donut.svg)](https://travis-ci.org/hhff/donut)

Donut is a minimal command line tool for orchestrating tooling across "mono-repo" projects in Testing, CI and Development.  If your app repo looks like this...

```
-- ROOT
    |-- api
    |-- frontend
    |-- backend
    |-- core
```
... Donut will make your life easier.

## Installation

    $ gem install donut

## Usage

All Donut commands are run from the project root.

```
cd path/to/my/project
```

#### Generate your Donutfile.rb
Donut requires you to describe your repo inside a `Donutfile.rb`, located at the root of the project.

```
donut init
```

#### Customize your Donutfile.rb
Use `install`, `serve`, `test` and `deploy` to describe your project.

```
class JavascriptApp < Donut::App
  def install
    run 'npm install'
    run 'bower install'
  end
end

class EmberAddon < JavascriptApp
  def test
    run 'ember test'
  end
end

class EmberApp < EmberAddon
  def serve
    run 'ember serve'
  end
end

class RailsApp < Donut::App
  def install
    bundle_exec 'bundle install'
    bundle_exec 'rake db:migrate'
    bundle_exec 'rake db:seed'
  end
  
  def serve
    bundle_exec 'rails s'
  end
  
  def test
    bundle_exec 'rspec'
  end
  
  def deploy
    run 'git push heroku master'
  end
  
  private
  bundle_exec(cmd)
    run "bundle exec #{cmd}"
  end
end

DONUTS = {
  api:        RailsApp.new('api'),
  admin_ui:   JavascriptApp.new('backend'),
  frontend:   EmberApp.new('frontend'),
  core_addon: EmberAddon.new('core')
}
```

Now simply run `donut [COMMAND]` and watch that command propogate across your whole project!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/donut/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
