# be_moderate
[![Build Status](https://travis-ci.org/ninoseki/be_moderate.svg?branch=master)](https://travis-ci.org/ninoseki/be_moderate)
[![Code Climate](https://codeclimate.com/github/ninoseki/be_moderate/badges/gpa.svg)](https://codeclimate.com/github/ninoseki/be_moderate)

## A Problem to be solved
Sometimes there is a traffic spike on my IIJMio mobile lines.
I need a notice or automate traffic shaping.

## Implementation ideas
* Use [IIJMio Coupon Swith API](https://www.iijmio.jp/hdd/coupon/mioponapi.jsp).
* Check the traffic usage each 4 hours.
  * If a mobile line's traffic usage is under 500MB/day then make a coupon on the line enable.
  * If a mobile line's traffic usage is over 500MB/day then make a coupon on the line disable.
