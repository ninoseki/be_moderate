# be_moderate

[![Build Status](https://travis-ci.org/ninoseki/be_moderate.svg?branch=master)](https://travis-ci.org/ninoseki/be_moderate)
[![Code Climate](https://codeclimate.com/github/ninoseki/be_moderate/badges/gpa.svg)](https://codeclimate.com/github/ninoseki/be_moderate)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/be_moderate/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/be_moderate?branch=master)

## An issue to be solved

Sometimes there is a traffic spike on my IIJMio mobile lines.
I need a notice or automate traffic shaping for my mental health.

## Implementation ideas

* Use [IIJMio Coupon Swith API](https://www.iijmio.jp/hdd/coupon/mioponapi.jsp).
* Check the traffic usage each 4 hours.
  * If a mobile line's traffic usage is under 300MB/day, then allow it to use a coupon.
  * If a mobile line's traffic usage is over 300MB/day,  then disallow it to use a coupon.
