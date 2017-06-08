# be_moderate

## A Problem to be solved
Sometimes there is a traffic spike on my IIJMio mobile lines.

I want to limit traffic usage of a modile line when the line's data traffic over 500MB/day.

## Implementation ideas
* Use [IIJMio Coupon Swith API](https://www.iijmio.jp/hdd/coupon/mioponapi.jsp).
* Check the traffic usage each 4 hours.
  * If a mobile line's traffic usage is under 500MB/day then make a coupon on the line enable.
  * If a mobile line's traffic usage is over 500MB/day then make a coupon on the line disable.
