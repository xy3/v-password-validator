module passwordvalidator

import math

const (
	replace_chars       = '!@$&*'
	sep_chars           = '_-., '
	other_special_chars = '"#%\'()+/:;<=>?[]^{|}~'
	lowercase           = 'abcdefghijklmnopqrstuvwxyz'
	uppercase           = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	numbers             = '0123456789'
	keyboard0           = 'qwertyuiop'
	keyboard1           = 'asdfghjkl'
	keyboard2           = 'zxcvbnm'
)

fn remove_more_than_two(input string, seq string) string {
	mut runes := input.runes()
	mut matches := 0
	for i := 0; i < runes.len; i++ {
		for seq_rune in seq.runes() {
			if i >= runes.len {
				break
			}
			if runes[i] != seq_rune {
				matches = 0
				continue
			}
			matches++
			if matches > 2 {
				runes.delete(i)
			} else {
				i++
			}
		}
	}
	return runes.string()
}

fn remove_more_than_two_repeating_chars(input string) string {
	mut runes := input.runes()
	for i := 1; i < runes.len - 1; i++ {
		if runes[i - 1] == runes[i] && runes[i] == runes[i + 1] {
			runes.delete(i)
			i--
		}
	}
	return runes.string()
}

fn get_length(input string) int {
	mut password := input
	password = remove_more_than_two_repeating_chars(password)
	for seq in [numbers, keyboard0, keyboard1, keyboard2, lowercase] {
		password = remove_more_than_two(password, seq)
		password = remove_more_than_two(password, seq.reverse())
	}
	return password.len
}

fn get_base(password string) int {
	chars := password.runes()

	mut base := 0

	mut seqs := map[string]bool{}
	for c in chars {
		if c in replace_chars.runes() {
			seqs[replace_chars] = true
		} else if c in sep_chars.runes() {
			seqs[sep_chars] = true
		} else if c in other_special_chars.runes() {
			seqs[other_special_chars] = true
		} else if c in lowercase.runes() {
			seqs[lowercase] = true
		} else if c in uppercase.runes() {
			seqs[uppercase] = true
		} else if c in numbers.runes() {
			seqs[numbers] = true
		} else {
			base++
		}
	}

	return seqs.keys().join('').len + base
}

fn log_x(base f64, n f64) f64 {
	if base == 0 {
		return 0
	}
	return math.log2(n) / math.log2(base)
}

fn log_pow(exp_base f64, pow int, log_base f64) f64 {
	mut total := 0.0
	for i := 0; i < pow; i++ {
		total += log_x(log_base, exp_base)
	}
	return total
}

// get_entropy returns the entropy in bits for the given password
pub fn get_entropy(password string) f64 {
	base := get_base(password)
	length := get_length(password)

	// calculate log2(base^length)
	return log_pow(f64(base), length, 2)
}

pub fn validate(password string, min_entropy f64) ? {
	entropy := get_entropy(password)
	if entropy >= min_entropy {
		return
	}

	mut messages := []string{}

	if !password.contains_any(sep_chars) || !password.contains_any(replace_chars)
		|| !password.contains_any(other_special_chars) {
		messages << 'including more special characters'
	}
	if !password.contains_any(lowercase) {
		messages << 'using lowercase letters'
	}
	if !password.contains_any(uppercase) {
		messages << 'using uppercase letters'
	}
	if !password.contains_any(numbers) {
		messages << 'using numbers'
	}

	if messages.len > 0 {
		return error('insecure password, try ' + messages.join(', ') + ' or using a longer password')
	}

	return error('insecure password, try using a longer password')
}
