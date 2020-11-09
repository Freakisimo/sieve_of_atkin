# Sieve of Atkin

![Elixir CI](https://github.com/Cantido/sieve_of_atkin/workflows/Elixir%20CI/badge.svg)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg)](https://github.com/RichardLitt/standard-readme)

Generates prime numbers using the [Sieve of Atkin] algorithm.

The Sieve of Atkin is a modern algorithm for finding prime numbers that has better asymptotic complexity than the ancient [Sieve of Eratosthenes].
The Sieve of Eratosthenes has a time complexity of *O*(*n* log log *n*),
whereas the Sieve of Atkin has a time complexity of *O*(*n*).
That means the Sieve of Atkin will take twice as much time to compute twice as many primes.

This library was also designed to utilize as much CPU as is available,
thanks to Elixir's wonderful concurrency tools as well as the [Flow] library.

[Sieve of Atkin]: https://en.wikipedia.org/wiki/Sieve_of_Atkin
[Sieve of Eratosthenes]: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
[Flow]: https://github.com/dashbitco/flow

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sieve_of_atkin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sieve_of_atkin, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sieve_of_atkin](https://hexdocs.pm/sieve_of_atkin).

## Usage

This project defines only one module with one function: `SieveOfAtkin.generate_primes/1`.
It generates prime numbers up to a given limit.

```elixir
SieveOfAtkin.generate_primes(30) |> Enum.sort() == [
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29
]
```

## Maintainer

This project was developed by [Rosa Richter](https://github.com/Cantido).
You can get in touch with her on [Keybase.io](https://keybase.io/cantido).

## Contributing

Questions and pull requests are more than welcome.
I follow Elixir's tenet of bad documentation being a bug,
so if anything is unclear, please [file an issue](https://github.com/Cantido/sieve_of_atkin/issues/new)!
Ideally, my answer to your question will be in an update to the docs.

## License

MIT License

Copyright 2020 Rosa Richter

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
