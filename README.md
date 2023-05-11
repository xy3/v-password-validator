<div align="center">
<h1>:space_invader: V password validator</h1>
</div>

<p align="center">
    Simple password validator using raw entropy values, written in <a href="https://vlang.io/">V</a>.
</p>


<p align="center">
⭐ If you like this project please give it a star! ⭐
</p>

---

Heavily influenced by [go-password-validator](https://github.com/wagslane/go-password-validator)

## Installation:

Install using `V`'s builtin `vpm`:

```bash
v install xy3.v-passvalid
```

Install using `git`:

```bash
cd path/to/your/project
git clone https://github.com/xy3/v-password-validator
```

Then in the wherever you want to use it:

```v
import xy3.passvalid
```

And that's it!

## Usage

## 🚀 Quick Start

```v
import xy3.passvalid

fn main(){
    entropy := passvalid.get_entropy("a longer password")
    // entropy is a f64, representing the strength in base 2 (bits)

    min_entropy_bits := 60
    passvalid.validate("some password", min_entropy_bits) or { panic(err) }
    // if the password has enough entropy, nothing is returned
    // otherwise, a formatted error message is provided explaining
    // how to increase the strength of the password
    // (safe to show to the client)
}
```

## What Entropy Value Should I Use?

It's up to you. That said, here is a graph that shows some common timings for different values, somewhere in the 50-70 range seems "reasonable".

![brute force diagram](https://blog.braincoke.fr/assets/images/security/password_entropy_small.png)

Keep in mind that attackers likely aren't just brute-forcing passwords, if you want protection against common passwords or [PWNed passwords](https://haveibeenpwned.com/) you'll need to do additional work. This library is lightweight, doesn't load large datasets, and doesn't contact external services.

