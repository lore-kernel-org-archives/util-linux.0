Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34301 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbFUDlk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 20 Jun 2015 23:41:40 -0400
Received: by wicnd19 with SMTP id nd19so48860123wic.1
        for <util-linux@vger.kernel.org>; Sat, 20 Jun 2015 20:41:39 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 20 Jun 2015 20:41:38 -0700
Message-ID: <CA+jjjYT6T0A=bY5=Kbga+WhR0FZse1LdHLmDCxFqhRspvS-gdw@mail.gmail.com>
Subject: mkfs.minix misbehaves on 4GB filesystems
From: Joshua Hudson <joshudson@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a11c268f84bcb160518feeff8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--001a11c268f84bcb160518feeff8
Content-Type: text/plain; charset=UTF-8

mkfs.minix misbehaves when attempting to create a large v2 or v3
filesystem. I finally traced it down to attempting to create too many
inodes so that the first zone is past 65535 blocks in. This obviously
doesn't work as the on-disk superblock says this is a 16 bit integer.

I wrote a patch that catches this, clamps to the absolute v2/v3 limit
(like it already does for v1), and sets the blocks per inode to a more
reasonable ratio when exceeding half a gigabyte. Having a half-gig
filesystem with most files being smaller than 3k isn't really
reasonable.

I suppose if you don't want to adjust inode sizes automatically you
could take that part out, and it will just crab sooner.

Given the non-attention in the code, I suspect nobody ever had cause
to try such a big minix filesystem. Well I have my reasons involving
some deeply embedded work where ext2 would place too much strain on
the hardware.

Note that 1) I'm not on the mailing list and 2) I'm on vacation for a
week. Consider patch signed off. Have fun.

--001a11c268f84bcb160518feeff8
Content-Type: text/x-diff; charset=US-ASCII; name="mkfs.minix.largedevice.patch"
Content-Disposition: attachment; filename="mkfs.minix.largedevice.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LS0tIGRpc2stdXRpbHMvbWtmcy5taW5peC5jLm9yaWcJMjAxNS0wNi0yMCAxMzo1MDo0NS41MDkz
MjU3MzYgLTA3MDAKKysrIGRpc2stdXRpbHMvbWtmcy5taW5peC5jCTIwMTUtMDYtMjAgMjA6Mjc6
MTEuNzMyNDM2NjQwIC0wNzAwCkBAIC00OSw2ICs0OSw5IEBACiAgKiAwNi4yOS4xMSAgLSAgT3Zl
cmFsbCBjbGVhbnVwcyBmb3IgdXRpbC1saW51eCBhbmQgdjMgc3VwcG9ydAogICogICAgICAgICAg
ICAgIERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBnbnUub3JnPgogICoKKyAqIDA2LjIwLjE1ICAtICBE
byBub3QgaW5maW5pdGUgbG9vcCBvciBjcmFzaCBvbiBsYXJnZSBkZXZpY2VzCisgKiAgICAgICAg
ICAgICAgSm9zaHVhIEh1ZHNvbiA8am9zaHVkc29uQGdtYWlsLmNvbT4KKyAqCiAgKiBVc2FnZTog
IG1rZnMgWy1jIHwgLWwgZmlsZW5hbWUgXSBbLTEydjNdIFstblhYXSBbLWlYWF0gZGV2aWNlIFtz
aXplLWluLWJsb2Nrc10KICAqCiAgKgktYyBmb3IgcmVhZGFibGlsaXR5IGNoZWNraW5nIChTTE9X
ISkKQEAgLTUwNCw5ICs1MDcsMTYgQEAKIAlzdXBlcl9zZXRfbnpvbmVzKCk7CiAJem9uZXMgPSBn
ZXRfbnpvbmVzKCk7CiAKLQkvKiBzb21lIG1hZ2ljIG5yczogMSBpbm9kZSAvIDMgYmxvY2tzICov
Ci0JaWYgKCByZXFfbnJfaW5vZGVzID09IDAgKSAKLQkJaW5vZGVzID0gQkxPQ0tTLzM7CisJLyog
c29tZSBtYWdpYyBucnM6IDEgaW5vZGUgLyAzIGJsb2NrcyBmb3Igc21hbGxlciBmaWxlc3lzdGVt
cywKKwkgKiBmb3Igb25lIGlub2RlIC8gMTYgYmxvY2tzIGZvciBsYXJnZSBvbmVzLiBta2ZzIHdp
bGwgZXZlbnR1YWxseQorCSAqIGNyYWIgYWJvdXQgdG9vIGZhciB3aGVuIGdldHRpbmcgY2xvc2Ug
dG8gdGhlIG1heGltdW0gc2l6ZS4gKi8KKwlpZiAoIHJlcV9ucl9pbm9kZXMgPT0gMCApCisJCWlm
IChCTE9DS1MgPiAyMDQ4ICogMTAyNCkgLyogMkdCICovCisJCQlpbm9kZXMgPSBCTE9DS1MvMTY7
CisJCWVsc2UgaWYgKEJMT0NLUyA+IDUxMiAqIDEwMjQpIC8qIDAuNUdCICovCisJCQlpbm9kZXMg
PSBCTE9DS1MvODsKKwkJZWxzZQorCQkJaW5vZGVzID0gQkxPQ0tTLzM7CiAJZWxzZQogCQlpbm9k
ZXMgPSByZXFfbnJfaW5vZGVzOwogCS8qIFJvdW5kIHVwIGlub2RlIGNvdW50IHRvIGZpbGwgYmxv
Y2sgc2l6ZSAqLwpAQCAtNTI2LDYgKzUzNiwxMiBAQAogCX0KIAogCXN1cGVyX3NldF9tYXBfYmxv
Y2tzKGlub2Rlcyk7CisJaWYgKGZpcnN0X3pvbmVfZGF0YSgpID49IDY1NTM2KQorCQllcnJ4KE1L
RlNfRVhfRVJST1IsIF8oIkZpcnN0IGRhdGEgYmxvY2sgYXQgJWpkLCB3aGljaCBpcyB0b28gZmFy
IgorCQkJIiAobWF4IDY1NTM1KS5cbiIKKwkJCSJUcnkgc3BlY2lmeWluZyBmZXdlciBpbm9kZXMg
YnkgcGFzc2luZyAtaSMjIyMjIy5cbiIpLAorCQkJZmlyc3Rfem9uZV9kYXRhKCkpOworCQkJCiAJ
aW1hcHMgPSBnZXRfbmltYXBzKCk7CiAJem1hcHMgPSBnZXRfbnptYXBzKCk7CiAKQEAgLTc5Myw2
ICs4MDksOCBAQAogCX0gZWxzZSAvKiBmc192ZXJzaW9uID09IDEgKi8KIAkJaWYgKEJMT0NLUyA+
IE1JTklYX01BWF9JTk9ERVMpCiAJCQlCTE9DS1MgPSBNSU5JWF9NQVhfSU5PREVTOworCWlmIChC
TE9DS1MgPiA0ICsgNjU1MzEgKiBCSVRTX1BFUl9CTE9DSykKKwkJQkxPQ0tTID0gNCArIDY1NTMx
ICogQklUU19QRVJfQkxPQ0s7IC8qIFV0dGVyIG1heGltdW06IENsaXAuICovCiAJc2V0dXBfdGFi
bGVzKCk7CiAJaWYgKGNoZWNrKQogCQljaGVja19ibG9ja3MoKTsK
--001a11c268f84bcb160518feeff8--
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
