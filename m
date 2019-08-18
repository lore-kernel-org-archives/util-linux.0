Return-Path: <SRS0=wyQU=WO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC8C3A589
	for <util-linux@archiver.kernel.org>; Sun, 18 Aug 2019 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8823421773
	for <util-linux@archiver.kernel.org>; Sun, 18 Aug 2019 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYKaPiGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRMRn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Aug 2019 08:17:43 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33864 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRMRn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Aug 2019 08:17:43 -0400
Received: by mail-ed1-f54.google.com with SMTP id s49so8869523edb.1
        for <util-linux@vger.kernel.org>; Sun, 18 Aug 2019 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72S8i14+QKk3szZcE4U0NmSHWn4TvlZqPU/9cBu83PY=;
        b=FYKaPiGwldm04Lz3Q3pL3Kz1B+118ksNrOtO9vogZRKkLv4apWptOjG4Kz90WxStRu
         uk4SxRnNu0ZL5qtSn243nVXgFI8h9ycSfVAToubjQvJ2w0tlgM5ODPqBWkkRS6RVOO7s
         77UvsKJruMbFr1FA6gY+lrMV9qDaq1+UVkiSakinYGbGn0vaNMv5dHbeEvhOvtu+KMn3
         0821qDxZWUPuZ1IBx08PM59JuBF+nDoF/Rd8ZcXagr4w8pC8wpwUi2Lh2dQ+XvFXiqwf
         T/9/ZR7Y9/AdBDdgil8mN6S2Jh4EaKYEncVHokjFfyTxhWBI3JvDVVgQPpGDbxwOmlB+
         uJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72S8i14+QKk3szZcE4U0NmSHWn4TvlZqPU/9cBu83PY=;
        b=UV6fGjBJhjJiNs84h6ds2yUsqGL8//hgpuglCfX0jK7GxEAD6KMVTmwN0B5w4HQjDw
         qc4h76h1d0HESFzA/5ujkrQRnI+sTDkf+7dp1DDQeS6v0eWEJ0Ob1HAWP+mpzF2Tk4L4
         wVWjwQ/2c5t+1G7pUPgHa5QBillx61i+x3ZVVHYa0xyoutQPUGXLmITLuEiGan7PZEqX
         mDnVS3Sh6PlxVZZc4IqMDMj8U7+u7ae5ZmGSQ1S1LA//uZYkdHAFk79rR+fImk6av+Fx
         zITeJ/2UBiaMT3ZMxs19zIlTwFB9Ky49p6ukAAAK2H+FbESGBx6gnLvSE3ZgDjIgZBuS
         7Iig==
X-Gm-Message-State: APjAAAUAOT0RyZFLCHmMOd04HjY+vJds0Vf+YKB/nVLJUP1lGnDF9eMW
        hZokSc4BtyoAYFou2y5nzIN4ziW8hLYeg1HNBcCV9Yql
X-Google-Smtp-Source: APXvYqxH6yRgGVAR7EZsZ0pX6HvLYHOuWrK4EvAQPO19cqCFTxGpYDC3s/+HbMYQvarFn7gfoKVnfhummK7FTlbujiw=
X-Received: by 2002:a17:906:8392:: with SMTP id p18mr16878895ejx.17.1566130661773;
 Sun, 18 Aug 2019 05:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <59067dd2-e0c5-c320-041c-07b0d7090e34@physik.fu-berlin.de> <b32d25f6-ac5a-94e4-11fd-49ad71dd8a13@physik.fu-berlin.de>
In-Reply-To: <b32d25f6-ac5a-94e4-11fd-49ad71dd8a13@physik.fu-berlin.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sun, 18 Aug 2019 15:17:31 +0300
Message-ID: <CADxRZqyga7QKSD16NcGaSx9oGGor0SRORuE7fMStOhcD4Ck5EQ@mail.gmail.com>
Subject: Re: Testsuite failures on Linux/sparc64
To:     util-linux <util-linux@vger.kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: multipart/mixed; boundary="000000000000c4b74d05906335eb"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--000000000000c4b74d05906335eb
Content-Type: text/plain; charset="UTF-8"

On Sun, Jul 28, 2019 at 11:02 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/28/19 9:59 PM, John Paul Adrian Glaubitz wrote:
> > The util-linux testsuite from git currently fails on Linux/sparc64 with:
> >
> >         fdisk: MBR - non-dos mode: [11] 1nd-primary-delete   ... FAILED (fdisk/mbr-nondos-mode-1nd-primary-delete)
> >         blkid: superblocks probing: [31] fat32_mkdosfs_none_dosfslabel_label1_xp_label2 ... OK
> >         minix: mkfs fsck                                     ... OK
> >         fdisk: MBR - dos mode                                ... OK
> >         blkid: superblocks probing: [32] fat32_mkdosfs_none_xp_label1 ... OK
> >         blkid: superblocks probing: [33] fat32_mkdosfs_none_xp_label1_dosfslabel_label2 ... OK
> >         fdisk: MBR - non-dos mode: [12] extended-delete      ... FAILED (fdisk/mbr-nondos-mode-extended-delete)
> >         blkid: superblocks probing: [34] fat32_xp_label1     ... OK
> > Value out of range.
> >         fdisk: MBR - non-dos mode: [13] first-sector-at-end  ... FAILED (fdisk/mbr-nondos-mode-first-sector-at-end)

fdisk non-dos mode tests are not suited (written) for sparc, since
default fdisk partition table/mode on sparc is 'sun'.
So disable this test on sparc. Patch attached. Tested locally and on gcc202.
Thanks.

--000000000000c4b74d05906335eb
Content-Type: application/octet-stream; 
	name="0001-tests-Skip-fdisk-mbr-nondos-mode-on-Sparc-as-unsuppo.patch"
Content-Disposition: attachment; 
	filename="0001-tests-Skip-fdisk-mbr-nondos-mode-on-Sparc-as-unsuppo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzgxpt000>
X-Attachment-Id: f_jzgxpt000

RnJvbSAwMDhhZTk2MzFmNzY1MDllMjI1YjM5NWQ1NjYzOWYwYmU4YTY2NTUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmF0b2x5IFB1Z2FjaGV2IDxtYXRvcm9sYUBnbWFpbC5jb20+
CkRhdGU6IFN1biwgMTggQXVnIDIwMTkgMTU6MDA6MDQgKzAzMDAKU3ViamVjdDogW1BBVENIXSB0
ZXN0czogU2tpcCBmZGlzay9tYnItbm9uZG9zLW1vZGUgb24gU3BhcmMgYXMgdW5zdXBwb3J0ZWQu
CgpmZGlzayBub24tZG9zIG1vZGUgdGVzdHMgYXJlIG5vdCBzdWl0ZWQgKHdyaXR0ZW4pIGZvciBz
cGFyYywKc2luY2UgZGVmYXVsdCBmZGlzayBwYXJ0aXRpb24gdGFibGUgb24gc3BhcmMgaXMgJ3N1
bicuClNvIGRpc2FibGUgdGhpcyB0ZXN0IG9uIHNwYXJjLgoKU2lnbmVkLW9mZi1ieTogQW5hdG9s
eSBQdWdhY2hldiA8bWF0b3JvbGFAZ21haWwuY29tPgotLS0KIHRlc3RzL3RzL2ZkaXNrL21ici1u
b25kb3MtbW9kZSB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvdGVzdHMvdHMvZmRpc2svbWJyLW5vbmRvcy1tb2RlIGIvdGVzdHMvdHMvZmRpc2svbWJy
LW5vbmRvcy1tb2RlCmluZGV4IGQzYjM1ZmEzOS4uNzY5NmNlOTU3IDEwMDc1NQotLS0gYS90ZXN0
cy90cy9mZGlzay9tYnItbm9uZG9zLW1vZGUKKysrIGIvdGVzdHMvdHMvZmRpc2svbWJyLW5vbmRv
cy1tb2RlCkBAIC00Miw2ICs0Miw3IEBAIEFSQ0g9JCh1bmFtZSAtbSkKIGNhc2UgJEFSQ0ggaW4K
IAkqc3BhcmMqICkKIAkJQVJDSF9FWFQ9Ii5zcGFyYyIKKwkJdHNfc2tpcCAidW5zdXBwb3J0ZWQi
CiAJCTs7CiAJKikKIAkJQVJDSF9FWFQ9IiIKLS0gCjIuMjMuMC5yYzEKCg==
--000000000000c4b74d05906335eb--
