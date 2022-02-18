Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6840FC433EF
	for <util-linux@archiver.kernel.org>; Fri, 18 Feb 2022 21:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiBRVoU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:44:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBRVoS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 18 Feb 2022 16:44:18 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F3853723
        for <util-linux@vger.kernel.org>; Fri, 18 Feb 2022 13:43:58 -0800 (PST)
Received: (Authenticated sender: eric.estievenart@tecwec.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 5973620004
        for <util-linux@vger.kernel.org>; Fri, 18 Feb 2022 21:43:55 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------extMifm2LMMZtMb64GfPGcV0"
Message-ID: <465e6a29-ddae-2df5-647b-42abcb672034@tecwec.eu>
Date:   Fri, 18 Feb 2022 22:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     util-linux@vger.kernel.org
From:   Eric Estievenart <eric.estievenart@tecwec.eu>
Subject: [PATCH] dmesg: handle colorization of emerg/notice/info/debug levels
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a multi-part message in MIME format.
--------------extMifm2LMMZtMb64GfPGcV0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
please find attached a very simple patch which allows consistent customization
of the coloring schemes  of the emerg, notice, info and debug levels in dmesg.
(currently only alert, crit, err and warn coloring schemes could be customized).

output changes (when coloring enabled):
	emerg level takes a default reverse+red, as alert and crit.
	debug level takes dark gray (seems reasonable)

As my color choices might not suit the masses (or even offend them!),
notice and info levels are unaffected and keep a default reset vt100 sequence.
Afterall, they could then be customized via /etc/terminal-colors.d/dmesg.scheme

== LEGAL STUFF ==
Due to the triviality of the patch, I HEREBY EXPLICITELY DISMISS any right, copyrights, whatsoever,
applying to this patch, with or without changes, and grant the right to the maintainers, authors,
or whoever, to have it applied, even on his/her own name, without even mentioning me,
hoping this will make things faster and paperless, and useful to the community.
(If this is not sufficient or explicit enough, please tell, but, honestly...)

Regards, Thanks & Happy new year, if not too late.

-- 
Steve

--------------extMifm2LMMZtMb64GfPGcV0
Content-Type: text/x-patch; charset=UTF-8; name="dmesg-colors.patch"
Content-Disposition: attachment; filename="dmesg-colors.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtcnUgc3lzLXV0aWxzLm9yaWcvZG1lc2cuMS5hZG9jIHN5cy11dGlscy9kbWVzZy4x
LmFkb2MKLS0tIHN5cy11dGlscy5vcmlnL2RtZXNnLjEuYWRvYwkyMDIyLTAyLTAyIDIxOjIz
OjM5LjIyMDkwMTI1NiArMDEwMAorKysgc3lzLXV0aWxzL2RtZXNnLjEuYWRvYwkyMDIyLTAy
LTAyIDIxOjI4OjU1LjM1NTE5MTYzMSArMDEwMApAQCAtMTU5LDYgKzE1OSw5IEBACiAqdGlt
ZWJyZWFrKjo6CiBUaGUgbWVzc2FnZSB0aW1lc3RhbXAgaW4gc2hvcnQgY3RpbWUgZm9ybWF0
IGluICotLXJlbHRpbWUqIG9yICotLWh1bWFuKiBvdXRwdXQuCiAKKyplbWVyZyo6OgorVGhl
IHRleHQgb2YgdGhlIG1lc3NhZ2Ugd2l0aCB0aGUgZW1lcmcgbG9nIHByaW9yaXR5LgorCiAq
YWxlcnQqOjoKIFRoZSB0ZXh0IG9mIHRoZSBtZXNzYWdlIHdpdGggdGhlIGFsZXJ0IGxvZyBw
cmlvcml0eS4KIApAQCAtMTcxLDYgKzE3NCwxNSBAQAogKndhcm4qOjoKIFRoZSB0ZXh0IG9m
IHRoZSBtZXNzYWdlIHdpdGggdGhlIHdhcm5pbmcgbG9nIHByaW9yaXR5LgogCisqbm90aWNl
Kjo6CitUaGUgdGV4dCBvZiB0aGUgbWVzc2FnZSB3aXRoIHRoZSBub3RpY2UgbG9nIHByaW9y
aXR5LgorCisqaW5mbyo6OgorVGhlIHRleHQgb2YgdGhlIG1lc3NhZ2Ugd2l0aCB0aGUgaW5m
byBsb2cgcHJpb3JpdHkuCisKKypkZWJ1Zyo6OgorVGhlIHRleHQgb2YgdGhlIG1lc3NhZ2Ug
d2l0aCB0aGUgZGVidWcgbG9nIHByaW9yaXR5LgorCiAqc2VnZmF1bHQqOjoKIFRoZSB0ZXh0
IG9mIHRoZSBtZXNzYWdlIHRoYXQgaW5mb3JtIGFib3V0IHNlZ21lbnRhdGlvbiBmYXVsdC4K
IApkaWZmIC1ydSBzeXMtdXRpbHMub3JpZy9kbWVzZy5jIHN5cy11dGlscy9kbWVzZy5jCi0t
LSBzeXMtdXRpbHMub3JpZy9kbWVzZy5jCTIwMjItMDItMDIgMjE6MjM6MzkuMjI0OTAxMjgz
ICswMTAwCisrKyBzeXMtdXRpbHMvZG1lc2cuYwkyMDIyLTAyLTAyIDIyOjAyOjU2LjkxODY0
MDA5MyArMDEwMApAQCAtNzEsMTAgKzcxLDE0IEBACiAJRE1FU0dfQ09MT1JfU1VCU1lTLAog
CURNRVNHX0NPTE9SX1RJTUUsCiAJRE1FU0dfQ09MT1JfVElNRUJSRUFLLAorCURNRVNHX0NP
TE9SX0VNRVJHLAogCURNRVNHX0NPTE9SX0FMRVJULAogCURNRVNHX0NPTE9SX0NSSVQsCiAJ
RE1FU0dfQ09MT1JfRVJSLAogCURNRVNHX0NPTE9SX1dBUk4sCisJRE1FU0dfQ09MT1JfTk9U
SUNFLAorCURNRVNHX0NPTE9SX0lORk8sCisJRE1FU0dfQ09MT1JfREVCVUcsCiAJRE1FU0df
Q09MT1JfU0VHRkFVTFQKIH07CiAKQEAgLTgzLDEwICs4NywxNCBAQAogCVtETUVTR19DT0xP
Ul9TVUJTWVNdICAgID0geyAic3Vic3lzIiwJVUxfQ09MT1JfQlJPV04gfSwKIAlbRE1FU0df
Q09MT1JfVElNRV0JPSB7ICJ0aW1lIiwgICAgIFVMX0NPTE9SX0dSRUVOIH0sCiAJW0RNRVNH
X0NPTE9SX1RJTUVCUkVBS10JPSB7ICJ0aW1lYnJlYWsiLFVMX0NPTE9SX0dSRUVOIFVMX0NP
TE9SX0JPTEQgfSwKKwlbRE1FU0dfQ09MT1JfRU1FUkddCT0geyAiZW1lcmciLCAgICBVTF9D
T0xPUl9SRVZFUlNFIFVMX0NPTE9SX1JFRCB9LAogCVtETUVTR19DT0xPUl9BTEVSVF0JPSB7
ICJhbGVydCIsICAgIFVMX0NPTE9SX1JFVkVSU0UgVUxfQ09MT1JfUkVEIH0sCiAJW0RNRVNH
X0NPTE9SX0NSSVRdCT0geyAiY3JpdCIsICAgICBVTF9DT0xPUl9CT0xEIFVMX0NPTE9SX1JF
RCB9LAogCVtETUVTR19DT0xPUl9FUlJdICAgICAgID0geyAiZXJyIiwgICAgICBVTF9DT0xP
Ul9SRUQgfSwKIAlbRE1FU0dfQ09MT1JfV0FSTl0JPSB7ICJ3YXJuIiwgICAgIFVMX0NPTE9S
X0JPTEQgfSwKKwlbRE1FU0dfQ09MT1JfTk9USUNFXQk9IHsgIm5vdGljZSIsICAgICBVTF9D
T0xPUl9SRVNFVCB9LAorCVtETUVTR19DT0xPUl9JTkZPXQk9IHsgImluZm8iLCAgICAgVUxf
Q09MT1JfUkVTRVQgfSwKKwlbRE1FU0dfQ09MT1JfREVCVUddCT0geyAiZGVidWciLCAgICAg
VUxfQ09MT1JfREFSS19HUkFZIH0sCiAJW0RNRVNHX0NPTE9SX1NFR0ZBVUxUXQk9IHsgInNl
Z2ZhdWx0IiwgVUxfQ09MT1JfSEFMRkJSSUdIVCBVTF9DT0xPUl9SRUQgfQogfTsKIApAQCAt
MjM1LDYgKzI0Myw5IEBACiAJaW50IGlkID0gLTE7CiAKIAlzd2l0Y2ggKGxvZ19sZXZlbCkg
eworCWNhc2UgTE9HX0VNRVJHOgorCQlpZCA9IERNRVNHX0NPTE9SX0VNRVJHOworCQlicmVh
azsKIAljYXNlIExPR19BTEVSVDoKIAkJaWQgPSBETUVTR19DT0xPUl9BTEVSVDsKIAkJYnJl
YWs7CkBAIC0yNDcsNiArMjU4LDE1IEBACiAJY2FzZSBMT0dfV0FSTklORzoKIAkJaWQgPSBE
TUVTR19DT0xPUl9XQVJOOwogCQlicmVhazsKKwljYXNlIExPR19OT1RJQ0U6CisJCWlkID0g
RE1FU0dfQ09MT1JfTk9USUNFOworCQlicmVhazsKKwljYXNlIExPR19JTkZPOgorCQlpZCA9
IERNRVNHX0NPTE9SX0lORk87CisJCWJyZWFrOworCWNhc2UgTE9HX0RFQlVHOgorCQlpZCA9
IERNRVNHX0NPTE9SX0RFQlVHOworCQlicmVhazsKIAlkZWZhdWx0OgogCQlicmVhazsKIAl9
Cg==

--------------extMifm2LMMZtMb64GfPGcV0--
