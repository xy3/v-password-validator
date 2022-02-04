module v_password_validator

import math

fn test_remove_more_than_two() {
	assert remove_more_than_two('12345678', '0123456789') == '12'
	assert remove_more_than_two('abcqwertyabc', 'qwertyuiop') == 'abcqwabc'
	assert remove_more_than_two('', '') == ''
	assert remove_more_than_two('', '12345') == ''
}

fn test_remove_repeating_chars() {
	mut actual := remove_more_than_two_repeating_chars('aaaa')
	mut expected := 'aa'
	assert actual == expected

	actual = remove_more_than_two_repeating_chars('bbbbbbbaaaaaaaaa')
	expected = 'bbaa'
	assert actual == expected

	actual = remove_more_than_two_repeating_chars('ab')
	expected = 'ab'
	assert actual == expected

	actual = remove_more_than_two_repeating_chars('')
	expected = ''
	assert actual == expected
}

fn test_get_length() {
	mut actual := get_length('aaaa')
	mut expected := 2
	assert actual == expected

	actual = get_length('11112222')
	expected = 4
	assert actual == expected

	actual = get_length('aa123456')
	expected = 4
	assert actual == expected

	actual = get_length('876543')
	expected = 2
	assert actual == expected

	actual = get_length('qwerty123456z')
	expected = 5
	assert actual == expected
}

fn test_log_pow() {
	mut expected := math.round(math.log2(math.pow(7, 8)))
	mut actual := math.round(log_pow(7, 8, 2))
	assert actual == expected

	expected = math.round(math.log2(math.pow(10, 11)))
	actual = math.round(log_pow(10, 11, 2))
	assert actual == expected

	expected = math.round(math.log2(math.pow(11, 17)))
	actual = math.round(log_pow(11, 17, 2))
	assert actual == expected

	expected = math.round(math.log10(math.pow(13, 21)))
	actual = math.round(log_pow(13, 21, 10))
	assert actual == expected
}

fn test_validate() {
	mut err_msg := ''
	validate('mypass', 50) or { err_msg = err.msg }
	mut expected_error := 'insecure password, try including more special characters, using uppercase letters, using numbers or using a longer password'
	assert err_msg == expected_error

	err_msg = ''
	validate('MYPASS', 50) or { err_msg = err.msg }
	expected_error = 'insecure password, try including more special characters, using lowercase letters, using numbers or using a longer password'
	assert err_msg == expected_error

	err_msg = ''
	validate('mypassword', 4) or { err_msg = err.msg }
	assert err_msg == ''

	err_msg = ''
	validate('aGoo0dMi#oFChaR2', 80) or { err_msg = err.msg }
	assert err_msg == ''

	err_msg = ''
	expected_error = 'insecure password, try including more special characters, using lowercase letters, using uppercase letters or using a longer password'
	validate('123', 60) or { err_msg = err.msg }
	assert err_msg == expected_error
}

fn test_get_base() {
	mut actual := get_base('abcd')
	mut expected := lowercase.len
	assert actual == expected

	actual = get_base('abcdA')
	expected = lowercase.len + uppercase.len
	assert actual == expected

	actual = get_base('A')
	expected = uppercase.len
	assert actual == expected

	actual = get_base('^_')
	expected = other_special_chars.len + sep_chars.len
	assert actual == expected

	actual = get_base('^')
	expected = other_special_chars.len
	assert actual == expected

	actual = get_base('!')
	expected = replace_chars.len
	assert actual == expected

	actual = get_base('123')
	expected = numbers.len
	assert actual == expected

	actual = get_base('123ü')
	expected = numbers.len + 1
	assert actual == expected
}
