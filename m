Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59461 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab1FITbU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Jun 2011 15:31:20 -0400
Received: by qwk3 with SMTP id 3so889201qwk.19
        for <util-linux@vger.kernel.org>; Thu, 09 Jun 2011 12:31:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1307573568-23643-4-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
	<1307573568-23643-4-git-send-email-josiahw@gmail.com>
Date: Thu, 9 Jun 2011 21:31:19 +0200
Message-ID: <BANLkTi=Az7mO0=E=jSuCqRY20S9ExYnXdQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] checktty: Use NGROUPS_MAX instead of NGROUPS
From: Sami Kerola <kerolasa@iki.fi>
To: Josiah Worcester <josiahw@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/mixed; boundary=0016e64cd58e560acd04a54c7f4e
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--0016e64cd58e560acd04a54c7f4e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 9, 2011 at 00:52, Josiah Worcester <josiahw@gmail.com> wrote:
> -static gid_t mygroups[NGROUPS];
> +static gid_t mygroups[NGROUPS_MAX];

That might fix issue with musl libc, but is that truly an enhancement?
How about using sysconf(_SC_NGROUPS_MAX), e.g. see attachment.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/

--0016e64cd58e560acd04a54c7f4e
Content-Type: text/plain; charset=US-ASCII; name="0001-checktty-NGROUP-sysconf.txt"
Content-Disposition: attachment; filename="0001-checktty-NGROUP-sysconf.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goq3r6120

RnJvbSBiZjQzODJmMmY0OWM5OWY4Y2IzZGIzNjBiNTRkODgyNTUyNWMxNTNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW1pIEtlcm9sYSA8a2Vyb2xhc2FAaWtpLmZpPgpEYXRlOiBU
aHUsIDkgSnVuIDIwMTEgMjE6MjM6MTMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBjaGVja3R0eTog
TkdST1VQIC0+IHN5c2NvbmYKClVzZSBzeXNjb25mIHJldHVybiB2YWx1ZSBpbnN0ZWFkIG9mIE5H
Uk9VUCBkZWZpbml0aW9uIHRvIGRldGVybWluZSBzaXplIG9mCmdyb3VwbGlzdCBhcnJheS4KCmh0
dHA6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy8wMDk2OTUzOTkvZnVuY3Rpb25zL2dl
dGdyb3Vwcy5odG1sCgpTaWduZWQtb2ZmLWJ5OiBTYW1pIEtlcm9sYSA8a2Vyb2xhc2FAaWtpLmZp
PgotLS0KIGxvZ2luLXV0aWxzL2NoZWNrdHR5LmMgfCAgICA1ICsrKystCiAxIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9sb2dpbi11
dGlscy9jaGVja3R0eS5jIGIvbG9naW4tdXRpbHMvY2hlY2t0dHkuYwppbmRleCBmODQ5MDU3Li5l
MzlkMWUyIDEwMDY0NAotLS0gYS9sb2dpbi11dGlscy9jaGVja3R0eS5jCisrKyBiL2xvZ2luLXV0
aWxzL2NoZWNrdHR5LmMKQEAgLTMzLDEzICszMywxNCBAQAogI2luY2x1ZGUgInBhdGhuYW1lcy5o
IgogI2luY2x1ZGUgImxvZ2luLmgiCiAjaW5jbHVkZSAic3RydXRpbHMuaCIKKyNpbmNsdWRlICJ4
YWxsb2MuaCIKICNpbmNsdWRlICJjLmgiCiAKICNpZm5kZWYgVFRZX01BSk9SCiAjZGVmaW5lIFRU
WV9NQUpPUiA0CiAjZW5kaWYKIAotc3RhdGljIGdpZF90IG15Z3JvdXBzW05HUk9VUFNdOworc3Rh
dGljIGdpZF90ICpteWdyb3VwczsKIHN0YXRpYyBpbnQgICBudW1fZ3JvdXBzOwogCiAjZGVmaW5l
IE5BTUVMRU4gMTI4CkBAIC0zMTEsNiArMzEyLDcgQEAgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpCiAJCXsgTlVMTCwgTlVMTCB9CiAJfSwgKml0ZW07CiAKKwlteWdyb3VwcyA9IHhtYWxsb2Mo
c2l6ZW9mKGdpZF90KSAqIHN5c2NvbmYoX1NDX05HUk9VUFNfTUFYKSk7CiAJbWVtc2V0KCZoaW50
cywgMCwgc2l6ZW9mKGhpbnRzKSk7CiAJaGludHMuYWlfZmFtaWx5ID0gQUZfVU5TUEVDOwogCWhp
bnRzLmFpX2ZsYWdzID0gQUlfTlVNRVJJQ0hPU1QgfCAgQUlfUEFTU0lWRSB8IEFJX0FERFJDT05G
SUc7CkBAIC0zNDIsNiArMzQ0LDcgQEAgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCQlw
cmludGYoImdldGFkZHJpbmZvKCkgZmFpbGVkXG4iKTsKIAogCX0KKwlmcmVlKG15Z3JvdXBzKTsK
IAlyZXR1cm4gRVhJVF9TVUNDRVNTOwogfQogI2VuZGlmIC8qIE1BSU5fVEVTVF9DSEVDS1RUWSAq
LwotLSAKMS43LjUuMgoK
--0016e64cd58e560acd04a54c7f4e--
