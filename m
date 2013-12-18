Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47242 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752395Ab3LRWr4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Dec 2013 17:47:56 -0500
Message-Id: <1387406874.28811.61304297.734D6974@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
Cc: kerolasa@gmail.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1387406874288117";
 charset="utf-8"
In-Reply-To: <CAG27Bk096iW65aEUApwHtJqMRY9zyiN0MpHao+jvJvjkEcP-jA@mail.gmail.com>
References: <1387274534.32475.60577705.14EC62A9@webmail.messagingengine.com>
 <CAG27Bk096iW65aEUApwHtJqMRY9zyiN0MpHao+jvJvjkEcP-jA@mail.gmail.com>
Subject: [patch] adding --no-wrap to msgmerge
Date: Wed, 18 Dec 2013 23:47:54 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1387406874288117
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


Attached an updated patch, that avoids unneeded churn in PO files in git
(wrapping and subsequent unwrapping of long lines).  Works for me.

On Tue, Dec 17, 2013, at 18:16, Sami Kerola wrote:
> I think the change should include configure.ac update to require
> gettext version 0.18.
> 
> -AM_GNU_GETTEXT_VERSION([0.14.1])
> +AM_GNU_GETTEXT_VERSION([0.18])

Thank you, Sami.  That worked.

Although, now, during ./autogen.sh, I get the following warning:

configure.ac:149: warning: The 'AM_PROG_MKDIR_P' macro is deprecated, and its use is discouraged.
configure.ac:149: You should use the Autoconf-provided 'AC_PROG_MKDIR_P' macro instead,
configure.ac:149: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your Makefile.am fi

Something from gettext, apparently, because line 149 is:

AM_GNU_GETTEXT([external])

Regards,

Benno

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free


--_----------=_1387406874288117
Content-Disposition: attachment; filename="0001-po-add-no-wrap-to-msgmerge-to-not-wrap-long-message-.patch"
Content-Id: <1387406840.28731.d80c5305ae7f75daa3a381516a0ebb6baf48507e.205947F9@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-po-add-no-wrap-to-msgmerge-to-not-wrap-long-message-.patch"

RnJvbSA0Y2I1ZDRjY2Q1MjliYzU1MjFlMjNiODE3ZDIzMjk1ZjE0NTZlMWVm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogTW9uLCAxNiBE
ZWMgMjAxMyAyMjo0MTo1NiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHBvOiBh
ZGQgJy0tbm8td3JhcCcgdG8gbXNnbWVyZ2UsIHRvIG5vdCB3cmFwIGxvbmcg
bWVzc2FnZSBsaW5lcwoKVGhpcyBhdm9pZHMgdW5uZWVkZWQgY2h1cm4gZHVy
aW5nIFBPVC1maWxlIHJlbmV3YWwgYW5kIFBPLWZpbGUgdXBkYXRlcywKYXMg
dGhlIFBPIGZpbGVzIGF0IHRoZSBUUCBhcmUgbWFkZSB3aXRoICctLW5vLXdy
YXAnLgoKU2lnbmVkLW9mZi1ieTogQmVubm8gU2NodWxlbmJlcmcgPGJlbnNi
ZXJnQGp1c3RlbWFpbC5uZXQ+CkFja2VkLWJ5OiBTYW1pIEtlcm9sYSA8a2Vy
b2xhc2FAaWtpLmZpPgotLS0KIGNvbmZpZ3VyZS5hYyB8ICAgIDIgKy0KIHBv
L01ha2V2YXJzICB8ICAgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb25m
aWd1cmUuYWMgYi9jb25maWd1cmUuYWMKaW5kZXggODY2NTc4MC4uNTQ0NGNk
MyAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5h
YwpAQCAtMTQ1LDcgKzE0NSw3IEBAIFVMX1NFVF9BUkNIKFtIUFBBXSwgW2hw
cGEqXSkKIAogQUNfU1lTX0xBUkdFRklMRQogCi1BTV9HTlVfR0VUVEVYVF9W
RVJTSU9OKFswLjE0LjFdKQorQU1fR05VX0dFVFRFWFRfVkVSU0lPTihbMC4x
OF0pCiBBTV9HTlVfR0VUVEVYVChbZXh0ZXJuYWxdKQogCiBBU19JRihbdGVz
dCAtZCAiJHNyY2Rpci9wbyJdLCBbCmRpZmYgLS1naXQgYS9wby9NYWtldmFy
cyBiL3BvL01ha2V2YXJzCmluZGV4IDk5MzhlNDQuLjRkNTYyOWMgMTAwNjQ0
Ci0tLSBhL3BvL01ha2V2YXJzCisrKyBiL3BvL01ha2V2YXJzCkBAIC0xMCw2
ICsxMCw5IEBAIHRvcF9idWlsZGRpciA9IC4uCiAjIFRoZXNlIG9wdGlvbnMg
Z2V0IHBhc3NlZCB0byB4Z2V0dGV4dC4KIFhHRVRURVhUX09QVElPTlMgPSAt
LWtleXdvcmQ9XyAtLWtleXdvcmQ9Tl8gLS1rZXl3b3JkPVBfOjEsMgogCisj
IFRoaXMgb3B0aW9uIGdldHMgcGFzc2VkIHRvIG1zZ21lcmdlLgorTVNHTUVS
R0VfT1BUSU9OUyA9IC0tbm8td3JhcAorCiAjIFRoaXMgaXMgdGhlIGNvcHly
aWdodCBob2xkZXIgdGhhdCBnZXRzIGluc2VydGVkIGludG8gdGhlIGhlYWRl
ciBvZiB0aGUKICMgJChET01BSU4pLnBvdCBmaWxlLiAgU2V0IHRoaXMgdG8g
dGhlIGNvcHlyaWdodCBob2xkZXIgb2YgdGhlIHN1cnJvdW5kaW5nCiAjIHBh
Y2thZ2UuICAoTm90ZSB0aGF0IHRoZSBtc2dzdHIgc3RyaW5ncywgZXh0cmFj
dGVkIGZyb20gdGhlIHBhY2thZ2UncwotLSAKMS43LjAuNAoK

--_----------=_1387406874288117--

