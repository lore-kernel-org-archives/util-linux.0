Return-Path: tg@mirbsd.de
Date: Thu, 9 Oct 2014 13:25:12 +0000 (UTC)
From: Thorsten Glaser <tg@mirbsd.de>
To: Karel Zak <kzak@redhat.com>
cc: Adam Sampson <ats@offog.org>, util-linux@vger.kernel.org
Subject: Fwd: script from 2.25.1 may be broken (hangs)
In-Reply-To: <20141009122123.GG8057@x2.net.home>
Message-ID: <Pine.BSM.4.64L.1410091324420.17740@herc.mirbsd.org>
References: <loom.20141009T001730-172@post.gmane.org> <y2a7g09a50k.fsf@cartman.at.offog.org>
 <20141009122123.GG8057@x2.net.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-623807649-1412861137=:17740"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-623807649-1412861137=:17740
Content-Type: TEXT/PLAIN; charset=US-ASCII

From: Andreas Henriksson <andreas@fatal.se>
Message-ID: <20141009130557.GA20938@fatal.se>
To: 764547@bugs.debian.org
Date: Thu, 9 Oct 2014 15:05:57 +0200
Subject: Re: Bug#764547: Fwd: script from 2.25.1 may be broken (hangs)

Thanks for the improved testcase.

Spent 2 seconds looking and the finish indeed looks like it should
not be using WNOHANG (atleast) when explicitly called. Eg. like
the attached patch.

Would be great if someone was willing to take charge of looking
over this and getting a fix merged upstream. Poke me once merged
and a backport should be a trivial matter.

Regards,
Andreas Henriksson
--0-623807649-1412861137=:17740
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=script-hang.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSM.4.64L.1410091325120.17740@herc.mirbsd.org>
Content-Description: 
Content-Disposition: attachment; filename=script-hang.patch

ZGlmZiAtLWdpdCBhL3Rlcm0tdXRpbHMvc2NyaXB0LmMgYi90ZXJtLXV0aWxz
L3NjcmlwdC5jDQppbmRleCBiOWY4NzM4Li5iMTJiN2ZkIDEwMDY0NA0KLS0t
IGEvdGVybS11dGlscy9zY3JpcHQuYw0KKysrIGIvdGVybS11dGlscy9zY3Jp
cHQuYw0KQEAgLTgwLDYgKzgwLDcgQEANCiANCiAjZGVmaW5lIERFRkFVTFRf
T1VUUFVUICJ0eXBlc2NyaXB0Ig0KIA0KK3ZvaWQgc2lnX2ZpbmlzaChpbnQp
Ow0KIHZvaWQgZmluaXNoKGludCk7DQogdm9pZCBkb25lKHZvaWQpOw0KIHZv
aWQgZmFpbCh2b2lkKTsNCkBAIC0yNTgsNyArMjU5LDcgQEAgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpIHsNCiAJLyogc2V0dXAgU0lHQ0hMRCBoYW5k
bGVyICovDQogCXNpZ2VtcHR5c2V0KCZzYS5zYV9tYXNrKTsNCiAJc2Euc2Ff
ZmxhZ3MgPSAwOw0KLQlzYS5zYV9oYW5kbGVyID0gZmluaXNoOw0KKwlzYS5z
YV9oYW5kbGVyID0gc2lnX2ZpbmlzaDsNCiAJc2lnYWN0aW9uKFNJR0NITEQs
ICZzYSwgTlVMTCk7DQogDQogCS8qIGluaXQgbWFzayBmb3IgU0lHQ0hMRCAq
Lw0KQEAgLTM4NSwxNyArMzg2LDE4IEBAIGRvaW5wdXQodm9pZCkgew0KIAl9
DQogDQogCWlmICghZGllKQ0KLQkJZmluaXNoKDApOwkvKiB3YWl0IGZvciBj
aGlsZGVybiAqLw0KKwkJZmluaXNoKDEpOwkvKiB3YWl0IGZvciBjaGlsZHJl
biAqLw0KIAlkb25lKCk7DQogfQ0KIA0KIHZvaWQNCi1maW5pc2goaW50IGR1
bW15IF9fYXR0cmlidXRlX18gKChfX3VudXNlZF9fKSkpIHsNCitmaW5pc2go
aW50IHdhaXQpIHsNCiAJaW50IHN0YXR1czsNCiAJcGlkX3QgcGlkOw0KIAlp
bnQgZXJyc3YgPSBlcnJubzsNCisJaW50IG9wdGlvbnMgPSB3YWl0ID8gMCA6
IFdOT0hBTkc7DQogDQotCXdoaWxlICgocGlkID0gd2FpdDMoJnN0YXR1cywg
V05PSEFORywgMCkpID4gMCkNCisJd2hpbGUgKChwaWQgPSB3YWl0Mygmc3Rh
dHVzLCBvcHRpb25zLCAwKSkgPiAwKQ0KIAkJaWYgKHBpZCA9PSBjaGlsZCkg
ew0KIAkJCWNoaWxkc3RhdHVzID0gc3RhdHVzOw0KIAkJCWRpZSA9IDE7DQpA
QCAtNDA1LDYgKzQwNywxMSBAQCBmaW5pc2goaW50IGR1bW15IF9fYXR0cmli
dXRlX18gKChfX3VudXNlZF9fKSkpIHsNCiB9DQogDQogdm9pZA0KK3NpZ19m
aW5pc2goaW50IGR1bW15IF9fYXR0cmlidXRlX18gKChfX3VudXNlZF9fKSkp
IHsNCisJZmluaXNoKDApOw0KK30NCisNCit2b2lkDQogcmVzaXplKGludCBk
dW1teSBfX2F0dHJpYnV0ZV9fICgoX191bnVzZWRfXykpKSB7DQogCXJlc2l6
ZWQgPSAxOw0KIH0NCg==

--0-623807649-1412861137=:17740--
