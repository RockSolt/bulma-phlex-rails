[![Gem Version](https://badge.fury.io/rb/bulma-phlex-rails.svg)](https://badge.fury.io/rb/bulma-phlex-rails)

# Bulma Phlex Rails

Build Rails applications with the power of Phlex and the elegance of Bulma CSS framework. Use Bulma components and a Rails form builder to create clean, responsive applications.

> [!IMPORTANT]
> The Form Builder is still under development. The documentation below describes the planned functionality. See the issues list for progress.
>
> The BulmaPhlex components, with the Rails extensions as well as the related Stimulus controllers, are available now.


## Form Builder–Coming Soon!

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

The following form helpers are supported:

- text_field
- password_field
- telephone_field
- date_field
- time_field
- datetime_field
- datetime_local_field
- week_field
- month_field
- url_field
- email_field
- number_field
- search_field
- color_field
- range_field

The following form helpers are still under construction:

- checkbox
- checkbox_display
- select
- collection_select
- file_field
- text_area
- textarea
- submit_tag

In addition to the standard options, the following options are supported for inputs:

- suppress_label: Do not render the label tag
- icon_left: Add an icon to the left of the input field
- icon_right: Add an icon to the right of the input field
- column: Specify Bulma column classes for responsive layouts
- cell: Specify Bulma grid cell classes for responsive layouts

For example, want your amount input to include a dollar sign icon?

```ruby
form.text_field :amount, icon_left: "dollar-sign"
```

> [!NOTE]
> Under the hood the form builder still uses Rails form helpers, so all standard options are supported as well and you get the full power of Rails forms.

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

### Form Addons and Groups

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
