Return-Path: util-linux-owner@vger.kernel.org
Received: from [201.191.100.135] ([201.191.100.135]:54195 "EHLO
	bruno.wildbear.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab3CREzx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Mar 2013 00:55:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id C75DD1BE1432
	for <util-linux@vger.kernel.org>; Sun, 17 Mar 2013 22:48:57 -0600 (CST)
Date: Sun, 17 Mar 2013 22:48:57 -0600 (CST)
From: Joseph Parmelee <jparmele@wildbear.com>
To: util-linux@vger.kernel.org
Subject: PATCH Make hwclock leap-second-aware
Message-ID: <alpine.LNX.2.00.1303172227410.3487@bruno>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1162217029-1363582162=:3487"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1162217029-1363582162=:3487
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Hello:

Attached is a patch file leap_seconds.patch against util-linux-2.22.2
that allows leap seconds to be included in hwclock --show or --hctosys. 
The current code uses the default UTC zonefile in reading the hardware
RTC with mktime().  This zonefile usually does not include leap
seconds.  As of this date there have been a total of 25 leap seconds
added since the epoch (start of 1970).  This is particularly a problem
for systems using ntp to maintain their system clocks because ntp does
take leap seconds into account.  A user can specify a leap-second-aware
zonefile via /etc/localtime.  By defining the environment variable
TZUTC, mktime() can be induced to use a matching UTC zonefile that
includes leap seconds.  The default behavior (TZUTC undefined) is
unchanged.

Regards,

Joseph Parmelee
jparmele at wildbear.com
---1463811328-1162217029-1363582162=:3487
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=leap_seconds.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.2.00.1303172248570.3487@bruno>
Content-Description: Leap seconds patch for hwclock
Content-Disposition: attachment; filename=leap_seconds.patch

LS0tIHN5cy11dGlscy9od2Nsb2NrLmMub3JpZwkyMDEyLTEyLTEyIDE0OjA0
OjIyLjk3NjM1NTc0NCAtMDYwMA0KKysrIHN5cy11dGlscy9od2Nsb2NrLmMJ
MjAxMy0wMy0xNiAxODo1Nzo0OC43NzQ2MDY3NjggLTA2MDANCkBAIC0zODIs
OCArMzgyLDE1IEBADQogCSAqLw0KIAl6b25lID0gZ2V0ZW52KCJUWiIpOwkv
KiByZW1lbWJlciBvcmlnaW5hbCB0aW1lIHpvbmUgKi8NCiAJaWYgKHVuaXZl
cnNhbCkgew0KLQkJLyogU2V0IHRpbWV6b25lIHRvIFVUQyAqLw0KLQkJc2V0
ZW52KCJUWiIsICIiLCBUUlVFKTsNCisJCS8qIFNldCB0aW1lem9uZSB0byBV
VEMgYXMgZGVmaW5lZCBieSB0aGUgZW52aXJvbm1lbnQNCisJCSAqIHZhcmlh
YmxlIFRaVVRDLiAgVFpVVEMgdW5kZWZpbmVkIGdpdmVzIHRoZSBkZWZhdWx0
IFVUQw0KKwkJICogem9uZWZpbGUgd2hpY2ggdXN1YWxseSBkb2VzIG5vdCB0
YWtlIGludG8gYWNjb3VudCBsZWFwDQorCQkgKiBzZWNvbmRzLiAgRGVmaW5l
IFRaVVRDIHRvIHNlbGVjdCB5b3VyIFVUQyB6b25lZmlsZSB3aGljaA0KKwkJ
ICogZG9lcyBpbmNsdWRlIGxlYXAgc2Vjb25kcy4gIEZvciBleGFtcGxlLCB3
aXRoIHJlY2VudCBHTlUNCisJCSAqIGxpYmMnczoNCisJCSAqICAgIFRaVVRD
PTovdXNyL3NoYXJlL3pvbmVpbmZvL3JpZ2h0L1VUQw0KKwkJICovDQorCQlz
ZXRlbnYoIlRaIiwgZ2V0ZW52KCJUWlVUQyIpLCBUUlVFKTsNCiAJCS8qDQog
CQkgKiBOb3RlOiB0enNldCgpIGdldHMgY2FsbGVkIGltcGxpY2l0bHkgYnkg
dGhlIHRpbWUgY29kZSwNCiAJCSAqIGJ1dCBvbmx5IHRoZSBmaXJzdCB0aW1l
LiBXaGVuIGNoYW5naW5nIHRoZSBlbnZpcm9ubWVudA0K

---1463811328-1162217029-1363582162=:3487--
