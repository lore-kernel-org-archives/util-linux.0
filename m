Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33695 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbdHANZm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2017 09:25:42 -0400
Received: by mail-oi0-f43.google.com with SMTP id d71so10067786oih.0
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2017 06:25:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Tue, 1 Aug 2017 15:25:40 +0200
Message-ID: <CACna6rwn+Kf+DCqRS_TQTdv5WakGCNaEqQgc3QwibuyV3KM5=A@mail.gmail.com>
Subject: libblkid: broken calculation of blkid_probe size for ubiN_M
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Today I discovered libblkid can't recognize my UBI volume with ubifs
filesystem. The code in libblkid/src/superblocks/ubifs.c seems
alright, but it's never used because of:
# LIBBLKID_DEBUG=3Dlowprobe,buffer blkid /dev/ubi0_0
(...)
4166: libblkid: LOWPROBE: [59] ubifs:
4166: libblkid:   BUFFER:         ignore: request out of probing area

Above error comes from blkid_probe_get_buffer and its
pr->off + pr->size < real_off + len
condition. In my case its evaulated as:
0 + 1 < 0 + 4
(pr->size is 1 which looks wrong obviously).

My UBI MTD partition is detected as:
[    0.834197] Creating 1 MTD partitions on "brcmnand.0":
[    0.839318] 0x000000000000-0x000008000000 : "ubi"

And attached using:
ubiattach -m 0

If you take a look at blkid_verify, you can see it calls:
blkid_probe_set_device(cache->probe, fd, 0, 0)
(the last 0 argument is "size" variable). So the source of the problem
seems to be "size" calculation inside blkid_probe_set_device. It has
something like:
if (S_ISCHR(sb.st_mode))
        devsiz =3D 1; /* UBI devices are char... */
pr->size =3D size ? (uint64_t)size : devsiz;

While I managed to debug and track down this issue, I'm not familiar
enough with libblkid to fix it. Could someone take a look at this and
help me, please?

--=20
Rafa=C5=82
