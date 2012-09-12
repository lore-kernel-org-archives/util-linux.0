Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697Ab2ILKW5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 06:22:57 -0400
Message-ID: <5050627A.2030009@redhat.com>
Date: Wed, 12 Sep 2012 12:22:50 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
CC: util-linux@vger.kernel.org
Subject: Re: segfault message supressed with su -c
References: <504F5246.4030304@redhat.com> <504F72A9.1090704@draigBrady.com>
In-Reply-To: <504F72A9.1090704@draigBrady.com>
Content-Type: multipart/mixed;
 boundary="------------010101020905060204060509"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010101020905060204060509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> You'll need to key on WTERMSIG (status).
> "Segmentation fault" will not always be appropriate.
> You'll get a core just with Ctrl-\ (SIGQUIT) too for example.
> Something along the lines of:
>
> "%s (core dumped)", strsignal (WTERMSIG (status))
>
> cheers,
> Pádraig.
I've redone the patch to reflect your proposition :) .
Cheers,
   Ondrej.


--------------010101020905060204060509
Content-Type: text/plain; charset=UTF-8;
 name="DIFF"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="DIFF"

RnJvbSA2NWU3MzU5MWZjZTJmYTk2MWJmNmRlMWNiYzkzNGY2YWE3YTIyNzQ1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbmRyZWogT3ByYWxhIDxvb3ByYWxhQHJlZGhhdC5j
b20+CkRhdGU6IFR1ZSwgMTEgU2VwIDIwMTIgMTY6Mzk6MTcgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBzdTogYWRkIHNlZ21lbnRhdGlvbiBmYXVsdCByZXBvcnRpbmcgb2YgdGhlIGNoaWxk
IHByb2Nlc3MKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBj
aGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCkNoaWxkIHBy
b2Nlc3NlcyB0aGF0IGVuZGVkIHdpdGggc2VnbWVudGF0aW9uIGZhdWx0IHByZXZpb3VzbHkK
aW5kaWNhdGVkIHRoaXMgd2l0aCByZXR1cm4gc3RhdHVzIG9ubHkuIFRoZSByZXBvcnQgaXMg
bm93IG1vcmUKdmVyYm9zZSBpZiBjb3JlIGR1bXAgaXMgYWxsb3dlZC4KCkltcHJvdmVkLWJ5
OiBQw6FkcmFpZyBCcmFkeS4KLS0tCiBsb2dpbi11dGlscy9zdS1jb21tb24uYyB8IDcgKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2xvZ2luLXV0aWxzL3N1LWNvbW1vbi5jIGIvbG9naW4tdXRpbHMvc3Ut
Y29tbW9uLmMKaW5kZXggMjNhZDU3ZC4uMjc0OTMwMyAxMDA2NDQKLS0tIGEvbG9naW4tdXRp
bHMvc3UtY29tbW9uLmMKKysrIGIvbG9naW4tdXRpbHMvc3UtY29tbW9uLmMKQEAgLTMwMCw3
ICszMDAsMTIgQEAgY3JlYXRlX3dhdGNoaW5nX3BhcmVudCAodm9pZCkKIAl9CiAgICAgICBp
ZiAocGlkICE9IChwaWRfdCktMSkKIAlpZiAoV0lGU0lHTkFMRUQgKHN0YXR1cykpCi0JICBz
dGF0dXMgPSBXVEVSTVNJRyAoc3RhdHVzKSArIDEyODsKKwkgIHsKKwkgICAgc3RhdHVzID0g
V1RFUk1TSUcgKHN0YXR1cykgKyAxMjg7CisJICAgIGlmIChXQ09SRURVTVAgKHN0YXR1cykp
CisJICAgICAgZnByaW50ZiAoc3RkZXJyLCBfKCIlcyAoY29yZSBkdW1wZWQpXG4iKSwKKyAg
ICAgICAgICAgICAgICAgc3Ryc2lnbmFsIChXVEVSTVNJRyAoc3RhdHVzKSkpOworCSAgfQog
CWVsc2UKIAkgIHN0YXR1cyA9IFdFWElUU1RBVFVTIChzdGF0dXMpOwogICAgICAgZWxzZQot
LSAKMS43LjExLjQKCg==
--------------010101020905060204060509--
