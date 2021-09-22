Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E930C433EF
	for <util-linux@archiver.kernel.org>; Wed, 22 Sep 2021 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CE761019
	for <util-linux@archiver.kernel.org>; Wed, 22 Sep 2021 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhIVRjD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbhIVRjC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 22 Sep 2021 13:39:02 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D7C061574
        for <util-linux@vger.kernel.org>; Wed, 22 Sep 2021 10:37:32 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id b67so1474023vkb.13
        for <util-linux@vger.kernel.org>; Wed, 22 Sep 2021 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=bT1JKxWMg0yoC34Ciyt3PfgonLSssofDwnbgR8LM1pU=;
        b=hKT20lhigYgpV5747uuvN2GhSYIgQTr10YBdn+QIptFh9zwzbmy7+E560lZCVGostD
         H6dgY6z3xSdRRgqwqTchGm1Lz0iDMiKTzJtHNgjKIGP8REhpITQGcxqjttBHqGqoqW3N
         Cd5cZ43rEzV6E/cdOQ1EjH42oZnsxf38gkEbmiAFZ0SkjqfSP/RoDkkmvAV2zvo+m03p
         lDYNw136LB5fVZZghHZ8d7S+w3vO7fji72Qxphu8wh9s3hc2Skvsqzv3gwwgRVvCcRo8
         J7jNYmv9Vrn7K4fbzpLCKQHHvxn4riGlVJHgZjxMwGIprfnhzJPQSeXFkwQEsYZsKkLU
         YjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bT1JKxWMg0yoC34Ciyt3PfgonLSssofDwnbgR8LM1pU=;
        b=AXd8YycwZp+AgWEmOj9RwYUSDa5NuSKpUQ6c/9+pxgVDcfTI8UBZVGSK/sCN0ShKCY
         Txel4etAl8M3Qkn3CReIpgkO1GzIACXjpQprtDTc1J9q77awBxliJQrr0DJCdkRd+Y7a
         dlVu/c9ZRjo4IBrYc5QIfVm+zjTNd2YIoEKUQpZJZmo3Vz/GTBwnIYX8J9THpe697M3P
         7RrvROPLd0Q4Q7gOztY60n+ZCewUzbGflmDpPIFhllwJj8joHifwOBrODW9JM3pgTvF0
         uDod6I9wKnT82KqZVfTWJgmcrEKC9W132aN3xUrvDW/KQt9ojnKxG4/HApBsJDu7AKZQ
         dNiA==
X-Gm-Message-State: AOAM53067FPcAau0Q1ue1q4J767s+3oeUfHv05AT6EiRJOE7gZL2AkfB
        dxUAuQr9kkXoEl67Qg1Rm0av8/c+GWyXr2iWADjUFszmEHk=
X-Google-Smtp-Source: ABdhPJwdKsumfLD7OSeqxyT+1DJphlzbkTq/OgafgYuK5FOH5ZkHeWz42LvfP8OXXlcGX2moorKzcZg88VlE9lvxOKA=
X-Received: by 2002:a1f:ac0e:: with SMTP id v14mr922947vke.3.1632332251525;
 Wed, 22 Sep 2021 10:37:31 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Wed, 22 Sep 2021 19:37:20 +0200
Message-ID: <CAHi0vA8dhcyzDUAfCjuo=vwEGK2Y_8K5GFZC9f8aaFUbO-hK1A@mail.gmail.com>
Subject: Man page lsfd(1)
To:     util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000022f3f05cc98f887"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--000000000000022f3f05cc98f887
Content-Type: text/plain; charset="UTF-8"

Hello,

although lsfd isn't official part of util-linux, this mailing list is
probably the right channel, because I assume it will become part of it
one day.

In the pull request I read "The man page is not available yet". See
the attached file: The diff contains an Asciidoctor man page mostly
based on the output with the --help option. Admittedly, not all info
what users need (in comparison with the current lsof(8)), but better
than nothing for the time being. Besides that, I've fixed two typos in
lsfd.c.

Best Regards,
Mario

--000000000000022f3f05cc98f887
Content-Type: text/x-patch; charset="US-ASCII"; name="lsfd-manpage.diff"
Content-Disposition: attachment; filename="lsfd-manpage.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ktvsdgmf0>
X-Attachment-Id: f_ktvsdgmf0

ZGlmZiAtLWdpdCBhL21pc2MtdXRpbHMvbHNkZi4xLmFkb2MgYi9taXNjLXV0aWxzL2xzZGYuMS5h
ZG9jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uNDUwYjI1Y2UwCi0tLSAv
ZGV2L251bGwKKysrIGIvbWlzYy11dGlscy9sc2RmLjEuYWRvYwpAQCAtMCwwICsxLDE1NiBAQAor
Ly9wbzRhOiBlbnRyeSBtYW4gbWFudWFsCisvLy8vCitDb3B5cmlnaHQgMjAyMSBSZWQgSGF0LCBJ
bmMuCisKK1RoaXMgZmlsZSBtYXkgYmUgY29waWVkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IFB1YmxpYyBMaWNlbnNlLgorLy8vLworPSBsc2ZkKDEpCis6ZG9jdHlwZTogbWFucGFnZQorOm1h
biBtYW51YWw6IFVzZXIgQ29tbWFuZHMKKzptYW4gc291cmNlOiB1dGlsLWxpbnV4IHtyZWxlYXNl
LXZlcnNpb259Cis6cGFnZS1sYXlvdXQ6IGJhc2UKKzpjb21tYW5kOiBsc2ZkCisKKz09IE5BTUUK
KworbHNmZCAtIGxpc3QgZmlsZSBkZXNjcmlwdG9ycworCis9PSBTWU5PUFNJUworCisqbHNmZCog
W29wdGlvbl0KKworPT0gREVTQ1JJUFRJT04KKworKmxzZmQqIGlzIGludGVuZGVkIHRvIGJlIGEg
ZHJvcC1pbiByZXBsYWNlbWVudCBmb3IgKmxzb2YqKDgpIG9uIExpbnV4IHN5c3RlbXMuIEl0IHVz
ZXMgTGlic21hcnRjb2xzIGZvciBvdXRwdXQgZm9ybWF0dGluZy4KKworQXZhaWxhYmxlIG91dHB1
dCBjb2x1bW5zOgorCitBU1NPQzo6CitBc3NvY2lhdGlvbiBiZXR3ZWVuIGZpbGUgYW5kIHByb2Nl
c3MuCisKK0NIUkRSVjo6CitDaGFyYWN0ZXIgZGV2aWNlIGRyaXZlciBuYW1lIHJlc29sdmVkIGJ5
IF8vcHJvYy9kZXZpY2VzXy4KKworQ09NTUFORDo6CitDb21tYW5kIG9mIHRoZSBwcm9jZXNzIG9w
ZW5pbmcgdGhlIGZpbGUuCisKK0RFTEVURUQ6OgorUmVhY2hhYmlsaXR5IGZyb20gdGhlIGZpbGUg
c3lzdGVtLgorCitERVY6OgorSUQgb2YgdGhlIGRldmljZSBjb250YWluaW5nIHRoZSBmaWxlLgor
CitERVZUWVBFOjoKK0RldmljZSB0eXBlIChfYmxrXywgX2NoYXJfLCBvciBfbm9kZXZfKS4KKwor
RkQ6OgorRmlsZSBkZXNjcmlwdG9yIGZvciB0aGUgZmlsZS4KKworRkxBR1M6OgorRmxhZ3Mgc3Bl
Y2lmaWVkIHdoZW4gb3BlbmluZyB0aGUgZmlsZS4KKworSU5PREU6OgorSW5vZGUgbnVtYmVyLgor
CitNQUo6TUlOOjoKK0RldmljZSBJRCBmb3Igc3BlY2lhbCwgb3IgSUQgb2YgZGV2aWNlIGNvbnRh
aW5pbmcgZmlsZS4KKworTUFQTEVOOjoKK0xlbmd0aCBvZiBmaWxlIG1hcHBpbmcgKGluIHBhZ2Up
LgorCitNSVNDREVWOjoKK01pc2MgY2hhcmFjdGVyIGRldmljZSBuYW1lIHJlc29sdmVkIGJ5IF8v
cHJvYy9taXNjXy4KKworTU5USUQ6OgorTW91bnQgSUQuCisKK01PREU6OgorQWNjZXNzIG1vZGUg
KHJ3eCkuCisKK05BTUU6OgorTmFtZSBvZiB0aGUgZmlsZS4KKworTkxJTks6OgorTGluayBjb3Vu
dC4KKworUEFSVElUSU9OOjoKK0Jsb2NrIGRldmljZSBuYW1lIHJlc29sdmVkIGJ5IF8vcHJvYy9w
YXJ0aXRpb25fLgorCitQSUQ6OgorUElEIG9mIHRoZSBwcm9jZXNzIG9wZW5pbmcgdGhlIGZpbGUu
CisKK1BPUzo6CitGaWxlIHBvc2l0aW9uLgorCitQUk9UT05BTUU6OgorUHJvdG9jb2wgbmFtZS4K
KworUkRFVjo6CitEZXZpY2UgSUQgKGlmIHNwZWNpYWwgZmlsZSkuCisKK1NJWkU6OgorRmlsZSBz
aXplLgorCitTT1VSQ0U6OgorRmlsZSBzeXN0ZW0sIHBhcnRpdGlvbiwgb3IgZGV2aWNlIGNvbnRh
aW5pbmcgdGhlIGZpbGUuCisKK1RJRDo6CitUaHJlYWQgSUQgb2YgdGhlIHByb2Nlc3Mgb3Blbmlu
ZyB0aGUgZmlsZS4KKworVFlQRTo6CitGaWxlIHR5cGUuCisKK1VJRDo6CitVc2VyIElEIG51bWJl
ci4KKworVVNFUjo6CitVc2VyIG9mIHRoZSBwcm9jZXNzLgorCis9PSBPUFRJT05TCisKKyotbCos
ICotLXRocmVhZHMqOjoKK0xpc3QgaW4gdGhyZWFkcyBsZXZlbC4KKworKi1KKiwgKi0tanNvbioK
K1VzZSBKU09OIG91dHB1dCBmb3JtYXQuCisKKyotbiosICotLW5vaGVhZGluZ3MqCitEb24ndCBw
cmludCBoZWFkaW5ncy4KKworKi1vKiwgKi0tb3V0cHV0KiBfbGlzdF8KK091dHB1dCBjb2x1bW5z
LgorCisqLXIqLCAqLS1yYXcqCitVc2UgcmF3IG91dHB1dCBmb3JtYXQuCisKKyotLXN5c3Jvb3Qq
IF9kaXJfCitVc2Ugc3BlY2lmaWVkIGRpcmVjdG9yeSBhcyBzeXN0ZW0gcm9vdC4KKworKi0tbm90
cnVuY2F0ZSoKK0Rvbid0IHRydW5jYXRlIHRleHQgaW4gY29sdW1ucy4KKworKi1WKiwgKi0tdmVy
c2lvbio6OgorRGlzcGxheSB2ZXJzaW9uIGluZm9ybWF0aW9uIGFuZCBleGl0LgorCisqLWgqLCAq
LS1oZWxwKjo6CitEaXNwbGF5IGhlbHAgdGV4dCBhbmQgZXhpdC4KKworPT0gSElTVE9SWQorCitU
aGUgKmxzZmQqIGNvbW1hbmQgaXMgcGFydCBvZiB0aGUgdXRpbC1saW51eCBwYWNrYWdlIHNpbmNl
IHYyLjM4LgorCis9PSBBVVRIT1JTCisKK21haWx0bzp5YW1hdG9AcmVkaGF0LmNvbVtNYXNhdGFr
ZSBZQU1BVE9dCisKKz09IFNFRSBBTFNPCisKKypsc29mKig4KQorCitpbmNsdWRlOjptYW4tY29t
bW9uL2J1Z3JlcG9ydHMuYWRvY1tdCisKK2luY2x1ZGU6Om1hbi1jb21tb24vZm9vdGVyLmFkb2Nb
XQorCitpZmRlZjo6dHJhbnNsYXRpb25bXQoraW5jbHVkZTo6bWFuLWNvbW1vbi90cmFuc2xhdGlv
bi5hZG9jW10KK2VuZGlmOjpbXQpkaWZmIC0tZ2l0IGEvbWlzYy11dGlscy9sc2ZkLmMgYi9taXNj
LXV0aWxzL2xzZmQuYwppbmRleCAzNWFiZDdkOGMuLjNiOTcxNDYyMCAxMDA2NDQKLS0tIGEvbWlz
Yy11dGlscy9sc2ZkLmMKKysrIGIvbWlzYy11dGlscy9sc2ZkLmMKQEAgLTg5LDcgKzg5LDcgQEAg
c3RhdGljIHN0cnVjdCBjb2xpbmZvIGluZm9zW10gPSB7CiAJW0NPTF9BU1NPQ10gICA9IHsgIkFT
U09DIiwgICAgMCwgU0NPTFNfRkxfUklHSFQsIFNDT0xTX0pTT05fU1RSSU5HLAogCQlOXygiYXNz
b2NpYXRpb24gYmV0d2VlbiBmaWxlIGFuZCBwcm9jZXNzIikgfSwKIAlbQ09MX0NIUkRSVl0gID0g
eyAiQ0hSRFJWIiwgICAwLCBTQ09MU19GTF9SSUdIVCwgU0NPTFNfSlNPTl9TVFJJTkcsCi0JCU5f
KCJjaGFyY3RlciBkZXZpY2UgZHJpdmVyIG5hbWUgcmVzb2x2ZWQgYnkgL3Byb2MvZGV2aWNlcyIp
IH0sCisJCU5fKCJjaGFyYWN0ZXIgZGV2aWNlIGRyaXZlciBuYW1lIHJlc29sdmVkIGJ5IC9wcm9j
L2RldmljZXMiKSB9LAogCVtDT0xfQ09NTUFORF0gPSB7ICJDT01NQU5EIiwwLjMsIFNDT0xTX0ZM
X1RSVU5DLCBTQ09MU19KU09OX1NUUklORywKIAkJTl8oImNvbW1hbmQgb2YgdGhlIHByb2Nlc3Mg
b3BlbmluZyB0aGUgZmlsZSIpIH0sCiAJW0NPTF9ERUxFVEVEXSA9IHsgIkRFTEVURUQiLCAgMCwg
U0NPTFNfRkxfUklHSFQsIFNDT0xTX0pTT05fQk9PTEVBTiwKQEAgLTEwOSw3ICsxMDksNyBAQCBz
dGF0aWMgc3RydWN0IGNvbGluZm8gaW5mb3NbXSA9IHsKIAlbQ09MX01BUExFTl0gID0geyAiTUFQ
TEVOIiwgICAwLCBTQ09MU19GTF9SSUdIVCwgU0NPTFNfSlNPTl9OVU1CRVIsCiAJCU5fKCJsZW5n
dGggb2YgZmlsZSBtYXBwaW5nIChpbiBwYWdlKSIpIH0sCiAJW0NPTF9NSVNDREVWXSA9IHsgIk1J
U0NERVYiLCAgMCwgU0NPTFNfRkxfUklHSFQsIFNDT0xTX0pTT05fU1RSSU5HLAotCQlOXygibWlz
YyBjaGFyYWN0ZXIgZGV2aWNlIG5hbWUgcmVzb2x2ZWQgYnkgL3Byb2NtaXNjIikgfSwKKwkJTl8o
Im1pc2MgY2hhcmFjdGVyIGRldmljZSBuYW1lIHJlc29sdmVkIGJ5IC9wcm9jL21pc2MiKSB9LAog
CVtDT0xfTU5UX0lEXSAgPSB7ICJNTlRJRCIsICAgIDAsIFNDT0xTX0ZMX1JJR0hULCBTQ09MU19K
U09OX05VTUJFUiwKIAkJTl8oIm1vdW50IGlkIikgfSwKIAlbQ09MX01PREVdICAgID0geyAiTU9E
RSIsICAgICAwLCBTQ09MU19GTF9SSUdIVCwgU0NPTFNfSlNPTl9TVFJJTkcsCg==
--000000000000022f3f05cc98f887--
