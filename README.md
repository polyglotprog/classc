# ClassC
A tool for transpiling classes to object-oriented C code. The source language
is a simplified subset of C++; output is plain C header files.[^1]

ClassC is written in [Perl], using [Dist::Zilla] as its build tool.

> [!WARNING]  
> This project is **experimental**, not production-ready. Use at your own risk.

## Rationale
- C++ is very complex.
- Object-oriented C requires a lot of boilerplate.[^2]

## Requirements
- [Perl] v5.38[^2]
- [Dist::Zilla] for building/testing

## Building and Testing
Clone the project and install required modules:

```console
$ git clone git@github.com:polyglotprog/classc.git
$ cd classc
$ dzil authordeps --missing | cpanm
```

### Building
```console
$ dzil build
```

### Testing
```console
$ dzil test
```

Alternatively, run tests using [prove]:
```console
$ prove -r t
```

### Formatting with [perltidy]
```console
$ dzil perltidy
```

# Features
- [ ] Classes
  - [x] Fields
  - [x] Methods
- [ ] Inheritance
  - [x] Single Inheritance
  - [ ] Multiple Inheritance (Limited)
- [ ] Polymorphism
  - [x] Overridable Methods
  - [ ] Virtual Methods
  - [ ] Interfaces
- [ ] Encapsulation

<!------------------------------------------------------------------------------
  Footnotes
------------------------------------------------------------------------------->
[^1]: This is how C++ &mdash; originally ["C with Classes"] &mdash; started out.
  Before it had its own compiler, it compiled to C.
[^2]: See [Object Oriented Programming in C], which laid the groundwork for this
  project.
[^3]: ClassC was developed using Perl v5.38 but may still work with earlier
  versions of Perl, with some adjustments.

<!------------------------------------------------------------------------------
  Links
------------------------------------------------------------------------------->
["C with Classes"]: https://www.stroustrup.com/bs_faq.html#invention
[Dist::Zilla]: https://dzil.org
[Object Oriented Programming in C]: https://github.com/polyglotprog/oop-c
[Perl]: https://www.perl.org
[perltidy]: http://perltidy.sourceforge.net
[prove]: https://perldoc.perl.org/prove
