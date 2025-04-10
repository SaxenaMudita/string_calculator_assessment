# String Calculator

A Ruby implementation of a String Calculator that supports addition of numbers from a string input with various delimiters, including custom delimiters.

## Features

- Handles default delimiters (`,` and `\n`).
- Supports custom single and multiple delimiters.
- Ignores numbers greater than 1000.
- Raises errors for negative numbers with a list of negatives.
- Validates custom delimiter formats.

## Requirements

- **Ruby version**: 3.2.6
- **Bundler**: Ensure you have Bundler installed to manage dependencies.

## Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd string_calculator_assessment
    ```
   
2. Install dependencies:
   ```bash
    bundle install
    ```
3. Run the tests:
    ```bash
    bundle exec rspec
    ```
   
**Usage**

```ruby
require './app/services/string_calculator'

## Example usage

result = StringCalculator.add("1,2,3") # Returns 6
result_with_custom_delimiter = StringCalculator.add("//;\n1;2;3") # Returns 6
result_with_large_numbers = StringCalculator.add("2,1001") # Returns 2
result_with_negative_numbers = StringCalculator.add("1,-2,3") # Raises an error with a message "Negatives not allowed: -2"
```
