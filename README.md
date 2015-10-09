# Tips
CodePath iOS Project – First Exercise

I spent about 3 hours on Tips.

I built all the functionality in the video, then amended / added as follows:

* Keyboard launches right away (making the text field first responder) and can't be dismissed, as it makes sense being permanently available in this context.
* Changed keyboard to numeric keypad and I'm inserting the decimal point in the string, so you can just type the bill value. Also I limited to max $999.99 and if you type more digits I begin overwriting (by removing first index).
* Added gesture so you can swipe across bill amount to clear all.
* I look for device's local currency and change symbol accordingly (though I had a scope issue leading to some undesirable duplication).
* Added app icon and did some basic styling.
