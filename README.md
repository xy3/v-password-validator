# v-password-validator

Simple password validator using raw entropy values, written in [V](https://vlang.io/).

-

Heavily influenced by [go-password-validator](https://github.com/wagslane/go-password-validator)

## 🚀 Quick Start

```v
import xy3.passwordvalidator

fn main(){
    entropy := passwordvalidator.GetEntropy("a longer password")
    // entropy is a f64, representing the strength in base 2 (bits)

    min_entropy_bits := 60
    passwordvalidator.Validate("some password", min_entropy_bits) or { panic(err) }
    // if the password has enough entropy, nothing is returned
    // otherwise, a formatted error message is provided explaining
    // how to increase the strength of the password
    // (safe to show to the client)
}
```

## What Entropy Value Should I Use?

It's up to you. That said, here is a graph that shows some common timings for different values, somewhere in the 50-70 range seems "reasonable".

Keep in mind that attackers likely aren't just brute-forcing passwords, if you want protection against common passwords or [PWNed passwords](https://haveibeenpwned.com/) you'll need to do additional work. This library is lightweight, doesn't load large datasets, and doesn't contact external services.

