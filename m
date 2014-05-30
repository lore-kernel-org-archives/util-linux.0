Return-Path: csaba.kos@gmail.com
MIME-Version: 1.0
In-Reply-To: <20140530091503.GE9000@x2.net.home>
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com>
	<20140530091503.GE9000@x2.net.home>
Date: Fri, 30 May 2014 18:52:20 +0900
Message-ID: <CADhtO=8Kj763OzRRSFgOXcD+h1QUeRn7uJXqCms0TBY8=RWEBA@mail.gmail.com>
Subject: Re: [PATCH] deadlock in script
From: Csaba Kos <csaba.kos@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a11c1ec1c6ecf7504fa9b00b3
List-ID: <util-linux.vger.kernel.org>

--001a11c1ec1c6ecf7504fa9b00b3
Content-Type: text/plain; charset=UTF-8

On Fri, May 30, 2014 at 6:15 PM, Karel Zak <kzak@redhat.com> wrote:
> On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
>> diff --git a/term-utils/script.c b/term-utils/script.c
>> index e5d239c..32906d0 100644
>> --- a/term-utils/script.c
>> +++ b/term-utils/script.c
>> @@ -36,6 +36,9 @@
>>   * - added Native Language Support
>>   *
>>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added "q"-option
>> + *
>> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
>> + * - fixed a rare deadlock after child termination
>>   */
>>
>>  /*
>> @@ -114,6 +117,8 @@ int       tflg = 0;
>>  int  forceflg = 0;
>>  int  isterm;
>>
>> +sigset_t block_mask, unblock_mask;
>
>  This declaration shadows declaration in main() where is also block_mask and
>  unblock_mask -- I guess it's not expected.

Sorry, I goofed when updating my patch to the current master. Thanks
for the careful review! Updated patch attached.

>> +     /* block SIGCHLD */
>> +     sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
>
>  the initialization is where? in main()?

Yes, the sigprocmask() and sigaddset() calls initialize block_mask in main().

Best regards,

Csaba

>> +             /* wait for input or signal (including SIGCHLD) */
>> +             if ((cc = pselect(STDIN_FILENO + 1, &readfds, NULL, NULL, NULL,
>> +                     &unblock_mask)) > 0) {
>
>  probably good idea, I have thought about something like this (or
>  signalfd()), but I have never found time to try it... thanks!
>
>> +                     if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
>> +                             if (write_all(master, ibuf, cc)) {
>> +                                     warn (_("write failed"));
>> +                                     fail();
>> +                             }
>
>   Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

--001a11c1ec1c6ecf7504fa9b00b3
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-script-fix-a-rare-deadlock-after-child-termination.patch"
Content-Disposition: attachment;
	filename="0001-script-fix-a-rare-deadlock-after-child-termination.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hvtayjqq0

RnJvbSA4NTJjNmRhZTZlMzk3OTM3ZWE4YmRhZDE4YjYzMDQ2ZjE2OTUxNGUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDc2FiYSBLb3MgPGNzYWJhLmtvc0BnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMzAgTWF5IDIwMTQgMTQ6MzM6MzIgKzA5MDAKU3ViamVjdDogW1BBVENIIDEvMl0gc2Ny
aXB0OiBmaXggYSByYXJlIGRlYWRsb2NrIGFmdGVyIGNoaWxkIHRlcm1pbmF0aW9uCgotLS0KIHRl
cm0tdXRpbHMvc2NyaXB0LmMgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVybS11dGlscy9zY3JpcHQuYyBiL3Rlcm0tdXRp
bHMvc2NyaXB0LmMKaW5kZXggZTVkMjM5Yy4uNDdiYjE4NiAxMDA2NDQKLS0tIGEvdGVybS11dGls
cy9zY3JpcHQuYworKysgYi90ZXJtLXV0aWxzL3NjcmlwdC5jCkBAIC0zNiw2ICszNiw5IEBACiAg
KiAtIGFkZGVkIE5hdGl2ZSBMYW5ndWFnZSBTdXBwb3J0CiAgKgogICogMjAwMC0wNy0zMCBQZXIg
QW5kcmVhcyBCdWVyIDxwZXJAbGlucHJvLm5vPiAtIGFkZGVkICJxIi1vcHRpb24KKyAqCisgKiAy
MDE0LTA1LTMwIENzYWJhIEtvcyA8Y3NhYmEua29zQGdtYWlsLmNvbT4KKyAqIC0gZml4ZWQgYSBy
YXJlIGRlYWRsb2NrIGFmdGVyIGNoaWxkIHRlcm1pbmF0aW9uCiAgKi8KIAogLyoKQEAgLTExNCw2
ICsxMTcsOCBAQCBpbnQJdGZsZyA9IDA7CiBpbnQJZm9yY2VmbGcgPSAwOwogaW50CWlzdGVybTsK
IAorc2lnc2V0X3QgYmxvY2tfbWFzaywgdW5ibG9ja19tYXNrOworCiBpbnQgZGllOwogaW50IHJl
c2l6ZWQ7CiAKQEAgLTE2Miw3ICsxNjcsNiBAQCB1c2FnZShGSUxFICpvdXQpCiAKIGludAogbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsKLQlzaWdzZXRfdCBibG9ja19tYXNrLCB1bmJsb2Nr
X21hc2s7CiAJc3RydWN0IHNpZ2FjdGlvbiBzYTsKIAlpbnQgY2g7CiAKQEAgLTMwNiw2ICszMTAs
NyBAQCBkb2lucHV0KHZvaWQpIHsKIAlpbnQgZXJyc3YgPSAwOwogCXNzaXplX3QgY2MgPSAwOwog
CWNoYXIgaWJ1ZltCVUZTSVpdOworCWZkX3NldCByZWFkZmRzOwogCiAJLyogY2xvc2UgdGhpbmdz
IGlycmVsZXZhbnQgZm9yIHRoaXMgcHJvY2VzcyAqLwogCWlmIChmc2NyaXB0KQpAQCAtMzE0LDE0
ICszMTksMjcgQEAgZG9pbnB1dCh2b2lkKSB7CiAJCWZjbG9zZSh0aW1pbmdmZCk7CiAJZnNjcmlw
dCA9IHRpbWluZ2ZkID0gTlVMTDsKIAorCUZEX1pFUk8oJnJlYWRmZHMpOworCisJLyogYmxvY2sg
U0lHQ0hMRCAqLworCXNpZ3Byb2NtYXNrKFNJR19TRVRNQVNLLCAmYmxvY2tfbWFzaywgJnVuYmxv
Y2tfbWFzayk7CisKIAl3aGlsZSAoZGllID09IDApIHsKLQkJaWYgKChjYyA9IHJlYWQoU1RESU5f
RklMRU5PLCBpYnVmLCBCVUZTSVopKSA+IDApIHsKLQkJCWlmICh3cml0ZV9hbGwobWFzdGVyLCBp
YnVmLCBjYykpIHsKLQkJCQl3YXJuIChfKCJ3cml0ZSBmYWlsZWQiKSk7Ci0JCQkJZmFpbCgpOwor
CQlGRF9TRVQoU1RESU5fRklMRU5PLCAmcmVhZGZkcyk7CisKKwkJLyogd2FpdCBmb3IgaW5wdXQg
b3Igc2lnbmFsIChpbmNsdWRpbmcgU0lHQ0hMRCkgKi8KKwkJaWYgKChjYyA9IHBzZWxlY3QoU1RE
SU5fRklMRU5PICsgMSwgJnJlYWRmZHMsIE5VTEwsIE5VTEwsIE5VTEwsCisJCQkmdW5ibG9ja19t
YXNrKSkgPiAwKSB7CisKKwkJCWlmICgoY2MgPSByZWFkKFNURElOX0ZJTEVOTywgaWJ1ZiwgQlVG
U0laKSkgPiAwKSB7CisJCQkJaWYgKHdyaXRlX2FsbChtYXN0ZXIsIGlidWYsIGNjKSkgeworCQkJ
CQl3YXJuIChfKCJ3cml0ZSBmYWlsZWQiKSk7CisJCQkJCWZhaWwoKTsKKwkJCQl9CiAJCQl9CiAJ
CX0KLQkJZWxzZSBpZiAoY2MgPCAwICYmIGVycm5vID09IEVJTlRSICYmIHJlc2l6ZWQpCisKKwkJ
aWYgKGNjIDwgMCAmJiBlcnJubyA9PSBFSU5UUiAmJiByZXNpemVkKQogCQl7CiAJCQkvKiB0cmFu
c21pdCB3aW5kb3cgY2hhbmdlIGluZm9ybWF0aW9uIHRvIHRoZSBjaGlsZCAqLwogCQkJaWYgKGlz
dGVybSkgewpAQCAtMzMwLDEyICszNDgsMTUgQEAgZG9pbnB1dCh2b2lkKSB7CiAJCQl9CiAJCQly
ZXNpemVkID0gMDsKIAotCQl9IGVsc2UgeworCQl9IGVsc2UgaWYgKGNjIDw9IDApIHsKIAkJCWVy
cnN2ID0gZXJybm87CiAJCQlicmVhazsKIAkJfQogCX0KIAorCS8qIHVuYmxvY2sgU0lHQ0hMRCAq
LworCXNpZ3Byb2NtYXNrKFNJR19TRVRNQVNLLCAmdW5ibG9ja19tYXNrLCBOVUxMKTsKKwogCS8q
IFRvIGJlIHN1cmUgdGhhdCB3ZSBkb24ndCBtaXNzIGFueSBkYXRhICovCiAJd2FpdF9mb3JfZW1w
dHlfZmQoc2xhdmUpOwogCXdhaXRfZm9yX2VtcHR5X2ZkKG1hc3Rlcik7CkBAIC00MDQsNiArNDI1
LDcgQEAgZG9vdXRwdXQodm9pZCkgewogCXN0cnVjdCB0aW1ldmFsIHR2OwogCWRvdWJsZSBvbGR0
aW1lPXRpbWUoTlVMTCksIG5ld3RpbWU7CiAJaW50IGVycnN2ID0gMDsKKwlmZF9zZXQgcmVhZGZk
czsKIAogCWNsb3NlKFNURElOX0ZJTEVOTyk7CiAjaWZkZWYgSEFWRV9MSUJVVElMCkBAIC00MTYs
NiArNDM4LDggQEAgZG9vdXRwdXQodm9pZCkgewogCW15X3N0cmZ0aW1lKG9idWYsIHNpemVvZiBv
YnVmLCAiJWNcbiIsIGxvY2FsdGltZSgmdHZlYykpOwogCWZwcmludGYoZnNjcmlwdCwgXygiU2Ny
aXB0IHN0YXJ0ZWQgb24gJXMiKSwgb2J1Zik7CiAKKwlGRF9aRVJPKCZyZWFkZmRzKTsKKwogCWRv
IHsKIAkJaWYgKGRpZSB8fCBlcnJzdiA9PSBFSU5UUikgewogCQkJc3RydWN0IHBvbGxmZCBmZHNb
XSA9IHt7IC5mZCA9IG1hc3RlciwgLmV2ZW50cyA9IFBPTExJTiB9fTsKQEAgLTQyMywxMCArNDQ3
LDIzIEBAIGRvb3V0cHV0KHZvaWQpIHsKIAkJCQlicmVhazsKIAkJfQogCisJCS8qIGJsb2NrIFNJ
R0NITEQgKi8KKwkJc2lncHJvY21hc2soU0lHX1NFVE1BU0ssICZibG9ja19tYXNrLCAmdW5ibG9j
a19tYXNrKTsKKworCQlGRF9TRVQobWFzdGVyLCAmcmVhZGZkcyk7CiAJCWVycm5vID0gMDsKLQkJ
Y2MgPSByZWFkKG1hc3Rlciwgb2J1Ziwgc2l6ZW9mIChvYnVmKSk7CisKKwkJLyogd2FpdCBmb3Ig
aW5wdXQgb3Igc2lnbmFsIChpbmNsdWRpbmcgU0lHQ0hMRCkgKi8KKwkJaWYgKChjYyA9IHBzZWxl
Y3QobWFzdGVyKzEsICZyZWFkZmRzLCBOVUxMLCBOVUxMLCBOVUxMLAorCQkJJnVuYmxvY2tfbWFz
aykpID4gMCkgeworCisJCQljYyA9IHJlYWQobWFzdGVyLCBvYnVmLCBzaXplb2YgKG9idWYpKTsK
KwkJfQogCQllcnJzdiA9IGVycm5vOwogCisJCS8qIHVuYmxvY2sgU0lHQ0hMRCAqLworCQlzaWdw
cm9jbWFzayhTSUdfU0VUTUFTSywgJnVuYmxvY2tfbWFzaywgTlVMTCk7CisKIAkJaWYgKHRmbGcp
CiAJCQlnZXR0aW1lb2ZkYXkoJnR2LCBOVUxMKTsKIAotLSAKMS44LjUucmMzLjIuZ2MzMDI5NDEK
Cg==
--001a11c1ec1c6ecf7504fa9b00b3
Content-Type: text/x-diff; charset=US-ASCII;
	name="0002-script-fix-spurious-exit-from-input-read-loop-on-EIN.patch"
Content-Disposition: attachment;
	filename="0002-script-fix-spurious-exit-from-input-read-loop-on-EIN.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hvtayjvd1

RnJvbSA2NTdmMTM4MzIwYWZlMWE1ZjFkNTVmYjkyOGVkMTFiZWQ3ODE3ODk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDc2FiYSBLb3MgPGNzYWJhLmtvc0BnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMzAgTWF5IDIwMTQgMTg6NDA6MTUgKzA5MDAKU3ViamVjdDogW1BBVENIIDIvMl0gc2Ny
aXB0OiBmaXggc3B1cmlvdXMgZXhpdCBmcm9tIGlucHV0IHJlYWQgbG9vcCBvbiBFSU5UUi4KCi0t
LQogdGVybS11dGlscy9zY3JpcHQuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVybS11dGlscy9zY3JpcHQuYyBi
L3Rlcm0tdXRpbHMvc2NyaXB0LmMKaW5kZXggNDdiYjE4Ni4uMWFlMzQ2MiAxMDA2NDQKLS0tIGEv
dGVybS11dGlscy9zY3JpcHQuYworKysgYi90ZXJtLXV0aWxzL3NjcmlwdC5jCkBAIC0zMjcsNiAr
MzI3LDcgQEAgZG9pbnB1dCh2b2lkKSB7CiAJd2hpbGUgKGRpZSA9PSAwKSB7CiAJCUZEX1NFVChT
VERJTl9GSUxFTk8sICZyZWFkZmRzKTsKIAorCQllcnJubyA9IDA7CiAJCS8qIHdhaXQgZm9yIGlu
cHV0IG9yIHNpZ25hbCAoaW5jbHVkaW5nIFNJR0NITEQpICovCiAJCWlmICgoY2MgPSBwc2VsZWN0
KFNURElOX0ZJTEVOTyArIDEsICZyZWFkZmRzLCBOVUxMLCBOVUxMLCBOVUxMLAogCQkJJnVuYmxv
Y2tfbWFzaykpID4gMCkgewpAQCAtMzQ4LDcgKzM0OSw3IEBAIGRvaW5wdXQodm9pZCkgewogCQkJ
fQogCQkJcmVzaXplZCA9IDA7CiAKLQkJfSBlbHNlIGlmIChjYyA8PSAwKSB7CisJCX0gZWxzZSBp
ZiAoY2MgPD0gMCAmJiBlcnJubyAhPSBFSU5UUikgewogCQkJZXJyc3YgPSBlcnJubzsKIAkJCWJy
ZWFrOwogCQl9Ci0tIAoxLjguNS5yYzMuMi5nYzMwMjk0MQoK
--001a11c1ec1c6ecf7504fa9b00b3--
