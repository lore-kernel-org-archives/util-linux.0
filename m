Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:41478 "EHLO
	Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcEaWpy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 May 2016 18:45:54 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
	by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id u4VMaBZq044475
	for <util-linux@vger.kernel.org>; Tue, 31 May 2016 15:36:14 -0700
Message-ID: <574E11DB.2010501@tlinx.org>
Date: Tue, 31 May 2016 15:36:11 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: bug: column assumes tabs every 8 columns & ttywidth=80 
Content-Type: multipart/mixed;
 boundary="------------030002030002060200050901"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030002030002060200050901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In util-linux2.25, the "column" command isn't written for Linux using a
Linux-console (among others).  It assumes 8-column
fixed-width tabs and screen width of 80).

The Linux-console (or any emulator) and terminals supporting
the EMCA-48 standard (vt-100-emulating terms, as well as "xterm")
can have tabs set to arbitrary spacing.

Attached is a bash-script that can show current tab settings
as well as set them to a new value.

It only supports setting tabs to fixed-width, but there is nothing
preventing tabs from being set to variable width expansions.

Ex:
>  tty_tab 8
>  tty_tab
(from 1, tabs skip to column: 9 17 25 33 41 49 57 65 73 80
>  tty_tab 2
>  tty_tab
(from 1, tabs skip to column: 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 
33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 80

Suggestions to fix column (or other progs that deal
w/the console and use tabs):

1) allow -i (-t is taken) to specify width of terminal tab expansion
   -i 8 (default)
   -i 4 (some like 4-column indents)
   -i 2 (and some use 2 to keep down line length).  I've seen "1" used
   as a tabsize in javascript files...

1a) (low priority) -- have "-i" take a list of numbers, like
   -i 18 36 44 54
    (might be reasonable for /etc/fstab?) -- any tabs beyond the
     last would use the last specified interval (in above case, "10")
2) --no-tabs
    A "Don't use tabs" option for lining up columns, use spaces.
    AFAIK, spaces are a fixed size on tty's.

----

There's a tab-set program in the ncurses-utils as well called 'tabs'.










--------------030002030002060200050901
Content-Type: text/plain;
 name="tty_tab"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="tty_tab"

IyEvYmluL2Jhc2ggIC11CiNjb25zb2xlX2NvZGVzKDQpIG1hbiBwYWdlLi4uIHZ0MTAwLzIg
ZXQgJiYgRU1DQS00OCBzdGFuZGFyZAojIChjKSBsYSB3YWxzaCAoMjAxMykgLS0gZnJlZSB0
byB1c2UgYW5kIG1vZGlmeSBmb3IgcGVyc29uYWwgdXNlLgojICAgICAgICAgICAgICAgICAg
ICAgLS0gb3B0aW9uYWxseSBsaWNlbmNlZCB1bmRlciBHbnUgdjMgbGljZW5zZS4KCiMgdjAu
MC4zCQktIHRyeSB0byByZWR1Y2UgdGFiY29scyB0byBtaW5pbWFsIHNldCB0byByZXByb2R1
Y2UuCiMgdjAuMC4yCQktIHNldCB0YWJzIGZvciBmdWxsIHRlcm1pbmFsIHdpZHRoICh0cnkg
dG8gZ2V0IHRlcm0gd2lkdGgpCgpzaG9wdCAtcyBleHBhbmRfYWxpYXNlcyBleHRnbG9iCmFs
aWFzCW15PWRlY2xhcmUJCQkJc3ViPWZ1bmN0aW9uCmFsaWFzIGludD0nbXkgLWknCQkJCWFy
cmF5PSdteSAtYScgaW50QXJyYXk9J215IC1pYScgCXN0cmluZz1teQpteSBfUHQ9JCh0eXBl
IC10IFApCltbICRfUHQgJiYgJF9QdCA9PSBmdW5jdGlvbiBdXSAmJiB1bnNldCAtZiBQCmFs
aWFzIFA9cHJpbnRmCnVuc2V0IF9QdAoKUCAtdiBjbHJhbGx0cyAgIlx4MWJbM2ciClAgLXYg
c3RzICAgICAgICJcMDMzSCIKUCAtdiBjcHIgICAgICAgIlx4MWJbNm4iCgoKc3ViIGdldGNv
bHMoKSB7Cglsb2NhbCBzdHR5b3V0PSIkKHN0dHkgc2l6ZSA8L2Rldi90dHkpIgoJaW50IGRl
ZmF1bHRfY29scz04MAoJaWYgW1sgLW4gJHtDT0xVTU5TOi0iIn0gJiYgJENPTFVNTlMgPX4g
XlswLTldKyQgXV07IHRoZW4gCgkJZGVmYXVsdF9jb2xzPSRDT0xVTU5TOyBmaQoJW1sgLXog
JHtzdHR5b3V0Oi0iIn0gXV0gJiYgeyBlY2hvICRkZWZhdWx0X2NvbHM7IHJldHVybiAwOyB9
IAoJaW50IGNvbHM9IiR7c3R0eW91dCMqXCB9IgoJZWNobyAtbiAkW2NvbHM8Mj9kZWZhdWx0
X2NvbHM6Y29sc10KCXJldHVybiAwCn0KCnN1YiBnZXRwb3MgKCkgewoJc3RyaW5nIGFucwkJ
d2FudGVkPSR7MToteHl9CglpbnQgYXR0ZW1wdD0wIG1heF9hdHRlbXB0PTEJCSMgaW4gY2Fz
ZSBvZiByYXJlIGZhaWx1cmUgY2FzZQoJCQkJCQkJCQkJCQkJCQkJIyB1c2UgJ2F0dGVtcHQn
IHZhbHVlIGFzIGFkZGl0aW9uYWwKCQkJCQkJCQkJCQkJCQkJCSMgdGltZSB0byB3YWl0IGZv
ciByZXNwb25zZQoJd2hpbGUgOiA7IGRvCQoJCSggKCBQICJceDFiWzZuIiA+L2Rldi90dHkp
ICYgMj4vZGV2L251bGwgKSAgCgkJcmVhZCAgLXNkIFIgLXIgLXQgJFsyICsgYXR0ZW1wdF0g
YW5zIDwvZGV2L3R0eTsgCgkJYW5zPSR7YW5zOjJ9OyAKCQlpbnQgeD0wLTEgeT0wLTEKCQlp
ZiAhIHg9IiR7YW5zIyo7fSIgeT0iJHthbnMlOyp9IiAyPi9kZXYvbnVsbCAgfHwgCgkJCSgo
eD09LTF8fHk9PS0xKSk7IHRoZW4KCQkJKChhdHRlbXB0Kz0xIDwgbWF4X2F0dGVtcHQpKSAm
JiBjb250aW51ZQoJCWZpCQoJYnJlYWs7IGRvbmUKICBzdHJpbmcgb3V0PSIiCiAgW1sgJHdh
bnRlZCA9fiB4IF1dICYmIG91dD0iJHgiCiAgW1sgJHdhbnRlZCA9fiB5IF1dICYmIG91dD0i
JHtvdXQ6KyR4IH0keSIKICBbWyAkb3V0IF1dICYmIGVjaG8gLW4gIiRvdXQiCn0KCmRlY2xh
cmUgLWlhIHRhYnMKCgpzdWIgZ2V0X3RhYnMgKCkgewogIFAgIlxyIgoJdGFicz0oKQogIGlu
dCBwb3M9MCBvbGRwb3M9MC0xCiAgd2hpbGUgKChvbGRwb3MhPXBvcykpO2RvCgkJKChwb3Mp
KSAmJiB0YWJzKz0oJHBvcykKICAgIG9sZHBvcz1wb3MKICAgIFAgIlx0IgogICAgcG9zPSQo
Z2V0cG9zIHgpCiAgZG9uZQoJUCAiXHIiCiAgcmV0dXJuIDAKfQoKIyBOb3RlOiB0aGlzIHN1
YiB1c2VzIGFiaWxpdHkgdG8gX3JlYWRfIHRhYnN0b3BzIGFzIF9wcm94eV8gZm9yIHNldHRp
bmcgdGhlbQojIChpLmUuIGl0IG1ha2VzIG5vIHNlbnNlIHRvIGJlIGFibGUgdG8gcmVhZCB0
aGVtIGlmIHlvdSBjYW4ndCBzZXQgdGhlbSkKCnN1YiB0ZXN0X3RhYnNldF9hYmlsaXR5ICgp
IHsKCXN0cmluZyBwcm9tcHQ9InR0eV90YWI6IgoJaW50IG5ld2NvbD0keyNwcm9tcHR9KzEK
CVAgIlxyJHByb21wdCIKCWludCBteWNvbD0kKGdldHBvcyB4KQoJKChteWNvbCAmJiBteWNv
bD09bmV3Y29sKSkgJiYgcmV0dXJuIDAJCSMjIHJldHVybiBPSwkKCQoJeyBQICIgVGVybSB0
YWJzZXQgYWJpbGl0eSBub3QgZGV0ZWN0ZWQgbXljb2w9JHtteWNvbDotJyd9LCIKCQlQICIg
cHJvbXB0bGVuPSRuZXdjb2wpXG4iOyB9ID4mMgoJZXhpdCAtMSAKfQoKc3ViIGRvX2hlbHBf
bl9kaXNwbGF5X2N1cnRhYnMgKCkgewkKICBQICIgPG4+ICAgLSBzZXQgdGFiIHN0b3AgdG8g
TlxyIgoJaW50QXJyYXkgZGlmZnM7CglpbnQgbGFzdD0xCWN1ciBpCglzdHJpbmcgZW9sPSIi
CglnZXRfdGFicyAmJiB7CgkJZm9yICgoaT0wOyBpPCR7I3RhYnNbQF19OyArK2kpKTsgZG8K
CQkJY3VyPSR7dGFic1tpXX0KCQkJZGlmZnNbaV09Y3VyLWxhc3QKCQkJbGFzdD1jdXIKCQlk
b25lCQoJCWludEFycmF5IHJldmVyc2VfdGFic19zZXQ9KCkKCQlpbnQgcHJldnRhYj0wLTEK
CQlmb3IgKChpPSR7I2RpZmZzW0BdfS0yOyBpPjA7IC0taSkpOyBkbwoJCQlpbnQgdGhpc3Rh
Yj0ke2RpZmZzW2ldfQoJCQlpZiAoKHRoaXN0YWIhPSBwcmV2dGFiKSkgO3RoZW4gCgkJCQly
ZXZlcnNlX3RhYnNfc2V0Kz0oJHRoaXN0YWIpCgkJCQlwcmV2dGFiPXRoaXN0YWIKCQkJZmkK
CQlkb25lCgkJUCAiY3VycmVudCB2YWx1ZTogdHR5X3RhYiAiCgkJCWZvciAoKGk9JHsjcmV2
ZXJzZV90YWJzX3NldFtAXX0tMTsgaT49MDsgLS1pKSk7IGRvCgkJCQlQICIlZCAiICIke3Jl
dmVyc2VfdGFic19zZXRbaV19IjsgZG9uZQoJCVAgIlxyIjsKCX0KICBnZXRfdGFicyAgJiYg
ewogICAgUCAiKGZyb20gMSwgdGFicyBza2lwIHRvIGNvbHVtbjogIgogICAgUCAiJXMgIiAi
JHt0YWJzW0BdfSIKCQlQICJcclxuIgogIH0KfQoKc3ViIHNldF90YWJzICgpIHsKCWludCBt
YXhfY29sPSR7MTo9MC04MH0JCQoJaW50IHRhYnN0b3A9JHsyOi0/Im5lZWQgYSBwYXJhbSBm
b3IgdGFic3RvcCJ9CglpbnQgdGFiPSR0YWJzdG9wCQkJCXBvcz0wCglzdHJpbmcgc3RyPSIi
CglQICRjbHJhbGx0cwkJCQkJCQkJIyMgcmVzZXQgb2xkIHRhYnMKCXdoaWxlICgoKytwb3M8
Y29scykpIDtkbwkjIyBtb3ZlIGFjcm9zcyBzY3JlZW4gc2V0dGluZyB0YWJzCgkJc3RyKz0i
ICIKCQkoKHBvcyV0YWIpKSB8fCBzdHIrPSIkc3RzIgoJZG9uZQoJUCAiXHIkc3RyXHIiCn0K
CgppbnQgY29scz0kKGdldGNvbHMpCgp0ZXN0X3RhYnNldF9hYmlsaXR5IAkJCQkjIyBleGl0
cyBpZiBubyBhYmlsaXR5CgoKaWYgKCgkIz09MCkpIDsgdGhlbgoJZG9faGVscF9uX2Rpc3Bs
YXlfY3VydGFicwogIGV4aXQgMQplbHNlCglzZXRfdGFicyAiJGNvbHMiICIkQCIKZmkKCiMg
dmltOiB0cz0yIHN3PTIKCg==
--------------030002030002060200050901--
