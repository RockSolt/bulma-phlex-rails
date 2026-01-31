[![Gem Version](https://badge.fury.io/rb/bulma-phlex-rails.svg)](https://badge.fury.io/rb/bulma-phlex-rails)
[![Tests](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/test.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/test.yml)
[![RuboCop](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/rubocop.yml/badge.svg)](https://github.com/RockSolt/bulma-phlex-rails/actions/workflows/rubocop.yml)

# Bulma Phlex Rails

Simplify the view layer with a component library built on Phlex and styled with Bulma CSS framework. The code is simple
and the UI is clean.

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

> [!NOTE]
> The following form helpers are still under construction:
>
> - collection_checkboxes
> - collection_radio_buttons
> - file_field
> - radio_button


In addition to the standard options, the following options are supported for inputs:

- suppress_label: Do not render the label tag
- icon_left: Add an icon to the left of the input field
- icon_right: Add an icon to the right of the input field
- column: Specify Bulma column classes for responsive layouts
- cell: Specify Bulma grid cell classes for responsive layouts

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

You can also size the columns, using either the names like "half", "two-thirds", etc., or the numeric values 1-12.

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

You can still provide guidance on the grid cell sizes:

```ruby
form.grid do
  form.telephone_field :phone, column: "col-span-2"
  form.email_field :email, column: "col-span-3"
  form.text_field :city, column: "col-span-2"
  form.text_field :state
  form.text_field :zip
end
```

Or use a fixed grid to quickly create a uniform layout:

```ruby
form.fixed_grid(columns: 3) do
  form.telephone_field :phone
  form.email_field :email
  form.text_field :city
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

```ruby
with_options model: invoice do
  in_columns do
    show_text :customer_name
    show_date :invoice_date
    show_text :number
    show_amount :amount
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

Method `show_text` renders a label and read-only date field. An optional `format` key can be provided with the options to specify the date format. This is passed to the Rails `to_fs` method.

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
Bulma::Card() do |card|
  card.head("Product Info")
  card.turbo_frame_content("product", src: product_path(@product), pending_message: "Loading product...")
end
```

### ActiveSupport Backed Amount Columns

Rails provides great support for rendering currency amounts with the `number_to_currency` helper. The `BulmaPhlex::Table` component is extended with an `amount_column` method to make it easy to show amounts in your tables.

```ruby
BulmaPhlex::Table(invoices) do |table|
  table.column "Invoice No", &:invoice_number
  table.column "Customer", &:customer_name
  table.amount_column "Amount Due", &:total_amount
  table.date_colum "Due Date", &:due_date
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RockSolt/bulma-phlex-rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

This leverages the [Bulma CSS library](https://bulma.io/documentation/) and [Phlex](https://www.phlex.fun/) but is not endorsed or certified by either. We are fans of the both and this makes using them together easier.
