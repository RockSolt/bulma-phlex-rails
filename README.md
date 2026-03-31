[![Gem Version](https://badge.fury.io/rb/bulma-phlex-rails.svg)](https://badge.fury.io/rb/bulma-phlex-rails)
[![Tests](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/test.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/test.yml)
[![RuboCop](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/rubocop.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/rubocop.yml)

# Bulma Phlex Rails

Simplify the view layer with a component library built on Phlex and styled with Bulma CSS framework. The code is simple
and the UI is clean.

Let's take a look at an example:

<img width="752" height="510" alt="Example form" src="https://github.com/user-attachments/assets/04dce8ba-c4c2-427f-b1f6-87d7c073e6e8" />

The first row has three fields, in columns, with labels:

```ruby
form.columns do
  form.collection_select :customer_id, @customers, :id, :name, {}, { autofocus: true }
  form.date_field :invoice_date
  form.text_field :number
end
```

There's a nested form, with delete buttons and an add button. Those are built in.

```ruby
ff.nested_form_delete_button(row_selector: "tr",
                             icon: "fas fa-trash",
                             color: "danger",
                             rounded: true,
                             outlined: true)
```

You do not need a template for the new row, just add a button:

```ruby
form.nested_form_add_button(:lines,
                            label: "Add Line",
                            container: "#invoice-lines tbody",
                            color: "success",
                            rounded: true,
                            outlined: true,
                            icon: "fas fa-plus")
```

If you like clean UI, if you like clean code, you are in the right place. Take the power of Bulma CSS and Phlex for a spin today!

## Installation

Add this line to your application's Gemfile:

```ruby
gem "bulma-phlex-rails"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install bulma-phlex-rails
```

### Dependencies

This gem requires:

- Ruby 3.2.10 or higher
- Rails 7.2 or higher
- Phlex Rails 2.4 or higher
- Bulma CSS (which you'll need to include in your application)

### Required Setup

1. Include Bulma CSS in your application. You can [add it via npm/yarn, CDN](https://bulma.io/documentation/start/installation/), or the [bulma-rails](https://github.com/joshuajansen/bulma-rails) gem.

2. Require the gem in your code:

```ruby
require "bulma-phlex-rails"
```

## Form Builder

The custom form builder that simplifies the process of creating forms with Bulma styles. It overrides the form helpers to generate Bulma-compatible HTML.

For example, use the standard `text_field` form helper:

```ruby
form.text_field :name
```

It generates the following HTML (assuming a form object for a Project model):

```html
<div class="field">
  <label class="label" for="project_name">Name</label>
  <div class="control">
    <input type="text" id="project_name" name="project[name]" class="input" />
  </div>
</div>
```

All of the standard Rails form helpers are supported. Under the hood the form builder still uses Rails form helpers, so all standard options are supported as well and you get the full power of Rails forms.

In addition to the standard options, the following options are supported for inputs:

- `suppress_label`: Do not render the label tag
- `help`: Render a help text below the field
- `icon_left`: Add an icon to the left of the input field
- `icon_right`: Add an icon to the right of the input field
- `column`: Specify a Bulma column size when inside a `columns` block
- `grid`: Specify a Bulma grid cell size when inside a `grid` block

For example, want your name field to include a user icon?

```ruby
form.text_field :name, icon_left: "fas fa-user"
```

#### Checkbox

The checkbox method on the Form Builder generates a Bulma-styled checkbox input. If the label needs to be HTML instead of plain text, pass a block to the method.

```ruby
form.checkbox :terms_of_service do
  span { "I agree to the " }
  a(href: '/terms') { 'the Terms' }
end
```

#### Collection Radio Buttons and Checkboxes

Both the `collection_radio_buttons` and `collection_checkboxes` methods wrap the inputss with the Bulma structure and styles including a label. Add option `stacked: true` to stack the inputs vertically.

```ruby
form.collection_radio_buttons(:author_id, Author.all, :id, :name_with_initial)
```

#### File Field

The `file_field` method supports the following additional Bulma-specific options:

- `color`: Bulma color modifier (e.g., `"primary"`, `"info"`, `"success"`, `"danger"`)
- `size`: Bulma size modifier (`"small"`, `"normal"`, `"medium"`, `"large"`)
- `align`: Set to `"right"` to right-align the file input label
- `fullwidth`: (Boolean) Makes the file input span the full width of its container
- `boxed`: (Boolean) Uses Bulma's boxed file upload style
- `show_selections`: (Boolean) Displays the selected filename next to the button

```ruby
form.file_field :avatar, color: "info", boxed: true, show_selections: true
```

#### Submit

The `submit` method accepts the following Bulma button styling options:

- `color`: (String) Bulma color modifier such as `"primary"`, `"link"`, `"info"`, `"success"`, `"warning"`, or `"danger"`
- `size`: (String) `"small"`, `"normal"`, `"medium"`, or `"large"`
- `mode`: (String) `"light"` or `"dark"`
- `responsive`: (Boolean) Makes the button size responsive
- `fullwidth`: (Boolean) Makes the button full-width
- `outlined`: (Boolean) Renders the button as outlined
- `inverted`: (Boolean) Renders the button as inverted
- `rounded`: (Boolean) Renders the button with rounded corners

```ruby
form.submit "Save", color: "primary", rounded: true
```

#### Button

The `button` method renders a Bulma-styled button and accepts the same Bulma styling options as `submit`, plus icon options:

- `icon_left`: Add an icon to the left of the button label
- `icon_right`: Add an icon to the right of the button label

```ruby
form.button "Preview", color: "info", icon_left: "fas fa-eye"
```


### Nested Forms

Add and remove rows from nested forms with form builder methods `nested_form_add_button` and `nested_form_delete_button`. These work with Rails' `fields_for` helper to create dynamic nested forms.

There's no need to define anything else. Just use the methods in your form:

```ruby
form.fields_for :tasks do |task_form|
  task_form.text_field :name
  task_form.nested_form_delete_button icon: "fas fa-trash", row_selector: "tr"
end

form.nested_form_add_button :tasks, label: "Add Task", container: "#tasks-list"
```

The delete button will either hide the row and mark it for deletion (for existing records) or remove it from the DOM (for new records).

Both methods accept the following options:

**`nested_form_delete_button`**:
- `row_selector`: (String, required) CSS selector passed to `closest()` to identify the row to delete
- `label`: (String, optional) Button label text
- `icon`: (String, optional) Icon class displayed on the left (shorthand for `icon_left`)
- `icon_left`: (String, optional) Icon class displayed on the left of the button
- `icon_right`: (String, optional) Icon class displayed on the right of the button

**`nested_form_add_button`**:
- `record_name`: (Symbol, required) The name of the nested association (e.g., `:tasks`)
- `container`: (String, required) CSS selector for the container where new rows are appended
- `label`: (String, optional) Button label text
- `icon`: (String, optional) Icon class displayed on the left (shorthand for `icon_left`)
- `icon_left`: (String, optional) Icon class displayed on the left of the button
- `icon_right`: (String, optional) Icon class displayed on the right of the button

Both methods also accept Bulma button styling options: `color`, `size`, `mode`, `responsive`, `fullwidth`, `outlined`, `inverted`, and `rounded`.


### Columns and Grids

Bulma provides simple ways to build responsive layouts using [columns](https://bulma.io/documentation/columns/basics/) and [grids](https://bulma.io/documentation/grid/smart-grid/). The form builder includes helpers to leverage those features.

Need three columns on your form?

```ruby
form.columns do
  form.text_field :city
  form.text_field :state
  form.text_field :zip
end
```

You can use the following options for the Bulma columns:

- `minimum_breakpoint`: (Symbol, optional) Sets the minimum breakpoint for the columns; default is `:tablet`.
- `multiline`: (Boolean, optional) If true, allows the columns to wrap onto multiple lines.
- `gap`: (optional) Use an integer (0-8) to set the gap size between columns; use a hash keyed by breakpoints
  to set responsive gap sizes.
- `centered`: (Boolean, optional) If true, centers the columns.
- `vcentered`: (Boolean, optional) If true, vertically centers the columns.

You can also size the individual columns, using either the names like "half", "two-thirds", etc., or the numeric values 1-12.

```ruby
form.columns do
  form.text_field :city, column: "half"
  form.text_field :state, column: 2
  form.text_field :zip, column: "narrow"
end
```

Bulma allows columns to be assigned different widths at different viewport sizes. Pass in a hash to the `column` option to specify those:

```ruby
form.columns do
  form.text_field :city, column: { mobile: "full", tablet: "half", desktop: "one-third" }
  form.text_field :state, column: { mobile: "full", tablet: "one-quarter", desktop: "one-sixth" }
  form.text_field :zip, column: { mobile: "full", tablet: "one-quarter", desktop: "one-sixth" }
end
```

Grids let your form be extremely responsive to the viewport size:

```ruby
form.grid do
  form.telephone_field :phone
  form.email_field :email
  form.text_field :city
  form.text_field :state
  form.text_field :zip
end
```

You can use the following options for the Bulma grids:

- `fixed_columns`: (Integer, optional) Specifies a fixed number of columns for the grid.
- `auto_count`: (Boolean, optional) If true, the grid will automatically adjust the number
   of columns based on the content.
- `minimum_column_width`: (Integer 1-32, optional) Sets a minimum width for the columns in the grid.
- `gap`: (optional) Sets the gap size between grid items from 1-8 with 0.5 increments.
- `column_gap`: (optional) Sets the column gap size between grid items from 1-8 with 0.5 increments.
- `row_gap`: (optional) Sets the row gap size between grid items from 1-8 with 0.5 increments.

You can still provide guidance on the individualgrid cell sizes:

```ruby
form.grid do
  form.telephone_field :phone, column: "col-span-2"
  form.email_field :email, column: "col-span-3"
  form.text_field :city, column: "col-span-2"
  form.text_field :state
  form.text_field :zip
end
```

All of the power of Bulma columns and grids are at your fingertips with an easy-to-use, Rails-friendly API.


### Form Addons and Groups--Coming Soon!

> [!IMPORTANT]
> This feature has not yet been implemented.

Bulma can [attach inputs, buttons, and dropdowns](https://bulma.io/documentation/form/general/#form-addons) or [group controls together](https://bulma.io/documentation/form/general/#form-group). Helper methods make those easy, too.

```ruby
form.addon do
  form.text_field :username, placeholder: "Username"
  form.button "Check Availability", class: "button is-info"
end
```

```ruby
form.group do
  form.text_field :first_name, placeholder: "First Name"
  form.text_field :last_name, placeholder: "Last Name"
end
```


## Display Components and Helpers

The utilities and clean look of forms is also available for displaying data. The Phlex mixin `BulmaPhlex::Rails::DisplayableFormFields` makes it easy to show and organize fields.

<img width="741" height="171" alt="Displayable form fields" src="https://github.com/user-attachments/assets/c75c4ab4-a1dd-4bab-ac26-c2c00d164eb0" />


```ruby
with_options model: invoice do
  in_columns do
    show_text :customer_name
    show_date :invoice_date
    show_text :number
    show_currency :amount
  end

  in_columns do
    show_text :notes, column: "three-quarters"
    show_text :payment_status, &:titleize
  end
end
```

### Show Text

Method `show_text` renders a label and read-only input field for displaying text data. An optional block can be provided to format the value.

#### Arguments

- `model`: ActiveRecord Model - The model containing the text attribute. This can also be passed
  via the `options` (helpful when using `with_options`).
- `method`: Symbol or String - The attribute method name for the text field.
- `options`: Hash - Additional Bulma form field options can be passed, such as `:help`, `:icon_left`, `:icon_right`,
  `:column`, and `:grid`.


### Show Date

Method `show_date` renders a label and read-only date field. An optional `format` key can be provided with the options to specify the date format. This is passed to the Rails `to_fs` method.

#### Arguments

- `model`: ActiveRecord Model - The model containing the date attribute. This can also be passed
  via the `options` (helpful when using `with_options`).
- `method`: Symbol or String - The attribute method name for the date field.
- `options`: Hash - Additional options for the display field. This can include the `format` key, which gets to the Rails `to_fs` method.


### Show Currency

Method `show_currency` renders a label and read-only currency field. An optional `currency_options` key can be provided with the options. It is passed to the Rails `number_to_currency` helper method.

#### Arguments

- `model`: ActiveRecord Model - The model containing the currency attribute. This can also be passed
  via the `options` (helpful when using `with_options`).
- `method`: Symbol or String - The attribute method name for the currency field.
- `options`: Hash - Additional options for the display field. This can include the
  `currency_options` key, which should be a hash of options passed to `number_to_currency`.


### Columns

Method `in_columns` creates a Bulma columns container for organizing display fields. Individual fields can optionally specify their column sizes via the `column` option.


### Grids

Method `in_grid` creates a Bulma grid container for organizing display fields. Individual fields can optionally specify their grid cell sizes via the `grid` option.


## Bulma Components

Bulma provides a wide variety of components to make you applications look great. This extends the `bulma-phlex` gem, bringing in the all those components to make it easy to add a Navigation Bar, Table, Cards, and more to your Rails application. See the [bulma-phlex gem](https://github.com/RockSolt/bulma-phlex?tab=readme-ov-file#usage) for the full list of components.

In some cases, the components are extended here with Rails features.

### Turbo-Powered Cards

For example, the `BulmaPhlex::Card` component provides the standard card. With the Rails extension, your card can now use Turbo Frames for dynamic content loading.

```ruby
render BulmaPhlex::Card.new do |card|
  card.head("Product Info")
  card.turbo_frame_content("product", src: product_path(@product), pending_message: "Loading product...")
end
```

### ActiveSupport Backed Amount Columns

Rails provides great support for rendering currency amounts with the `number_to_currency` helper. The `BulmaPhlex::Table` component is extended with an `amount_column` method to make it easy to show amounts in your tables.

```ruby
render BulmaPhlex::Table.new(invoices) do |table|
  table.column "Invoice No", &:invoice_number
  table.column "Customer", &:customer_name
  table.amount_column "Amount Due", &:total_amount
  table.date_colum "Due Date", &:due_date
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

To test across different versions of Rails, use the `appraisal` gem. Run `bundle exec appraisal install` to set up the different test environments, then `bundle exec appraisal rake test` to run the tests across all versions.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex-rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

This leverages the [Bulma CSS library](https://bulma.io/documentation/) and [Phlex](https://www.phlex.fun/) but is not endorsed or certified by either. We are fans of the both and this makes using them together easier.
