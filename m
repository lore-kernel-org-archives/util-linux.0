Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35350 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaKIULJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Nov 2014 15:11:09 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so6440935pde.36
        for <util-linux@vger.kernel.org>; Sun, 09 Nov 2014 12:11:09 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1415561366-3111-1-git-send-email-bensberg@justemail.net>
References: <1415561366-3111-1-git-send-email-bensberg@justemail.net>
Date: Sun, 9 Nov 2014 20:11:09 +0000
Message-ID: <CAG27Bk0005eqTS+vFCmTR7K0uT1T14kxn=88cxd5fcQYu1wzkg@mail.gmail.com>
Subject: Re: [PATCH] docs: improve wording and formatting of man page of hwclock
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7b15fb1995248b050772a5f8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--047d7b15fb1995248b050772a5f8
Content-Type: text/plain; charset=UTF-8

On 9 November 2014 19:29, Benno Schulenberg <bensberg@justemail.net> wrote:
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  sys-utils/hwclock.8.in |   74 ++++++++++++++++++++++++------------------------
>  1 files changed, 37 insertions(+), 37 deletions(-)

Hi Benno,

Good clean up. While looking the changes I started to wonder would a
bit more formatting make lists better. See an attachment that should
apply on top of your change. If you like the idea just incorporate my
change into yours with Reviewed-by line.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

--047d7b15fb1995248b050772a5f8
Content-Type: text/x-patch; charset=US-ASCII; name="to-benno.patch"
Content-Disposition: attachment; filename="to-benno.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2au6bw90

ZGlmZiAtLWdpdCBhL3N5cy11dGlscy9od2Nsb2NrLjguaW4gYi9zeXMtdXRpbHMvaHdjbG9jay44
LmluCmluZGV4IDBjNjU0YTUuLjBjOTAxMzUgMTAwNjQ0Ci0tLSBhL3N5cy11dGlscy9od2Nsb2Nr
LjguaW4KKysrIGIvc3lzLXV0aWxzL2h3Y2xvY2suOC5pbgpAQCAtNDUyLDE0ICs0NTIsMjIgQEAg
d2hlbiB5b3Ugc2V0IHRoZSBTeXN0ZW0gVGltZSB1c2luZyB0aGUKIC5CIFwtXC1oY3Rvc3lzCiBv
cHRpb24uCiAuUFAKLVRoZSB0aW1lem9uZSB2YWx1ZSBhY3R1YWxseSBjb25zaXN0cyBvZiB0d28g
cGFydHM6IDEpIGEgZmllbGQKLXR6X21pbnV0ZXN3ZXN0IGluZGljYXRpbmcgaG93IG1hbnkgbWlu
dXRlcyBsb2NhbCB0aW1lIChub3QgYWRqdXN0ZWQKLWZvciBEU1QpIGxhZ3MgYmVoaW5kIFVUQywg
YW5kIDIpIGEgZmllbGQgdHpfZHN0dGltZSBpbmRpY2F0aW5nCi10aGUgdHlwZSBvZiBEYXlsaWdo
dCBTYXZpbmdzIFRpbWUgKERTVCkgY29udmVudGlvbiB0aGF0IGlzIGluIGVmZmVjdAotaW4gdGhl
IGxvY2FsaXR5IGF0IHRoZSBwcmVzZW50IHRpbWUuCi1UaGlzIHNlY29uZCBmaWVsZCBpcyBub3Qg
dXNlZCB1bmRlciBMaW51eCBhbmQgaXMgYWx3YXlzIHplcm8uCi0oU2VlIGFsc28KK1RoZSB0aW1l
em9uZSB2YWx1ZSBhY3R1YWxseSBjb25zaXN0cyBvZiB0d28gcGFydHM6CisuUFAKKy5SUworLlBE
IDAKKy5UUAorMSkKK2EgZmllbGQgdHpfbWludXRlc3dlc3QgaW5kaWNhdGluZyBob3cgbWFueSBt
aW51dGVzIGxvY2FsIHRpbWUgKG5vdCBhZGp1c3RlZAorZm9yIERTVCkgbGFncyBiZWhpbmQgVVRD
LCBhbmQKKy5UUAorMikKK2EgZmllbGQgdHpfZHN0dGltZSBpbmRpY2F0aW5nIHRoZSB0eXBlIG9m
IERheWxpZ2h0IFNhdmluZ3MgVGltZSAoRFNUKQorY29udmVudGlvbiB0aGF0IGlzIGluIGVmZmVj
dCBpbiB0aGUgbG9jYWxpdHkgYXQgdGhlIHByZXNlbnQgdGltZS4gIFRoaXMKK3NlY29uZCBmaWVs
ZCBpcyBub3QgdXNlZCB1bmRlciBMaW51eCBhbmQgaXMgYWx3YXlzIHplcm8uICAoU2VlIGFsc28K
IC5CUiBzZXR0aW1lb2ZkYXkgKDIpLikKKy5QRAorLlJFCiAKIC5TUyBVc2VyIGFjY2VzcyBhbmQg
c2V0dWlkCiAuUFAKQEAgLTYxMywxMiArNjIxLDI0IEBAIGluIHJlbWVtYmVyaW5nIGluZm9ybWF0
aW9uIGZyb20gb25lIGludm9jYXRpb24gdG8gdGhlIG5leHQuCiAuUFAKIFRoZSBmb3JtYXQgb2Yg
dGhlIGFkanRpbWUgZmlsZSBpcywgaW4gQVNDSUk6CiAuUFAKLUxpbmUgMTogVGhyZWUgbnVtYmVy
cywgc2VwYXJhdGVkIGJ5IGJsYW5rczogMSkgdGhlIHN5c3RlbWF0aWMgZHJpZnQgcmF0ZQotaW4g
c2Vjb25kcyBwZXIgZGF5LCBmbG9hdGluZyBwb2ludCBkZWNpbWFsOyAyKSB0aGUgcmVzdWx0aW5n
IG51bWJlciBvZgotc2Vjb25kcyBzaW5jZSAxOTY5IFVUQyBvZiBtb3N0IHJlY2VudCBhZGp1c3Rt
ZW50IG9yIGNhbGlicmF0aW9uLAotZGVjaW1hbCBpbnRlZ2VyOyAzKSB6ZXJvIChmb3IgY29tcGF0
aWJpbGl0eSB3aXRoCitMaW5lIDE6IFRocmVlIG51bWJlcnMsIHNlcGFyYXRlZCBieSBibGFua3M6
CisuUFAKKy5SUworLlBEIDAKKy5UUAorMSkKK3RoZSBzeXN0ZW1hdGljIGRyaWZ0IHJhdGUgaW4g
c2Vjb25kcyBwZXIgZGF5LCBmbG9hdGluZyBwb2ludCBkZWNpbWFsOworLlRQCisyKQordGhlIHJl
c3VsdGluZyBudW1iZXIgb2Ygc2Vjb25kcyBzaW5jZSAxOTY5IFVUQyBvZiBtb3N0IHJlY2VudAor
YWRqdXN0bWVudCBvciBjYWxpYnJhdGlvbiwgZGVjaW1hbCBpbnRlZ2VyOworLlRQCiszKQoremVy
byAoZm9yIGNvbXBhdGliaWxpdHkgd2l0aAogLkJSIGNsb2NrICg4KSkKIGFzIGEgZGVjaW1hbCBp
bnRlZ2VyLgorLlBECisuUkUKIC5QUAogTGluZSAyOiBPbmUgbnVtYmVyOiB0aGUgcmVzdWx0aW5n
IG51bWJlciBvZiBzZWNvbmRzIHNpbmNlIDE5NjkgVVRDIG9mIG1vc3QKIHJlY2VudCBjYWxpYnJh
dGlvbi4gIFplcm8gaWYgdGhlcmUgaGFzIGJlZW4gbm8gY2FsaWJyYXRpb24geWV0IG9yIGl0Cg==
--047d7b15fb1995248b050772a5f8--
