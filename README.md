jotform-api-ruby
===============
[JotForm API](http://api.jotform.com/docs/) - RubyGem wrapper for JotForm's ruby client.


### Installation

Via RubyGems:

        $ gem install jotform-api

Via Bundler:

Add the following to your Gemfile:

        gem 'jotform-api'

Then run:

        $ bundle install

### Beware!

This wrapper is the dumbest thing that can work. We're using it to fetch the questions for forms over the API, but if you try to use it for anything else, it will almost definitely break.

### Differences to Jotform's vanilla version

The gem is structured so that all code is inside the JotForm namespace. To avoid having to use JotForm::JotForm all over the place, use the API class, which wraps the JotForm class and memoizes the connection so it can be used internally.

This will only work if you're interacting with a single API key/connection.

### Form Rendering

The gem also includes a *very* basic rendering helper, designed to output a form ready to submit to JotForm. This uses HAML to build the form, because that's what we're using. Not all field types are supported yet, and you don't get anything fancy like validations, etc.

### Documentation

You can find the docs for the API of this client at [http://api.jotform.com/docs/](http://api.jotform.com/docs)

### Authentication

JotForm API requires API key for all user related calls. You can create your API Keys at  [API section](http://www.jotform.com/myaccount/api) of My Account page.

### Examples

Print all forms of the user

```ruby
require 'JotForm'

jotform = JotForm::API.new("APIKey")
forms = jotform.getForms()

forms.each do |form|
    puts form["title"]
end
```

First the _JotForm_ class is included from the _jotform-api-ruby/JotForm.rb_ file. This class provides access to JotForm's API. You have to create an API client instance with your API key.
In case of an exception (wrong authentication etc.), you can catch it or let it fail with a fatal error.
