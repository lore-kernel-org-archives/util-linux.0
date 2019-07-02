Return-Path: <SRS0=Z5ID=U7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32EC06510
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 10:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31642089C
	for <util-linux@archiver.kernel.org>; Tue,  2 Jul 2019 10:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iPc6/E0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbfGBKnr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:43:47 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:33543 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBKnr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Jul 2019 06:43:47 -0400
Received: by mail-yb1-f181.google.com with SMTP id x4so1148448ybk.0
        for <util-linux@vger.kernel.org>; Tue, 02 Jul 2019 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=30x+942yHxn30zp1qLmL1Ds5u5HQf3C/aTWyqPZt7PM=;
        b=iPc6/E0bPlVM7HbOkS4nRquR0U3ip+gLTlyCw6Hb03RLxCEEtsAt/ynen3osyEPOYJ
         8mo3NbnG13++elMYsibe5UNyOqpSFt+cL6bybXNoG4YLvA4C6O3jeyzPi7mghHFD5nM+
         Deh4J9tYh2hCMoFF63ObgRX/7lLg1g9PLZvbhDgXiOETNy3vv9yImeHZWkMZW1Dd3xhA
         RSqnnM8S3jjRfpuECgZpFCVnkF9nHxC2m7eZsGR/U+M38gvfXcVQwQMvYT70hnbeCADQ
         BO7yYaWkq72zi3CWyFf9fRTF6/IiTPV0/J6cE6w9N14HDdoj3kmFCTeYmdsixdUPu3TK
         UXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=30x+942yHxn30zp1qLmL1Ds5u5HQf3C/aTWyqPZt7PM=;
        b=RqQJKdXkE8PBLwCv79n8SEm8uEQY95N4xIDzjTiVPDpbkQy5ujyFyFOLjZ/Wkb6eqd
         nwpedtGTr+aVkViyYXzfP9bkPKKKhfRxgPcmjNnL5hkwGPTOmTZcwi91l7eVBzT3N2QT
         ViPUM/ZpFulp9xjyL8bnkudWfzCq0/tCY8XVSae39PZAGxTK96AAA/INY7Mt8vDEJkHC
         BRHVk3Zqm9JPr5I+efXcZPucz3tewN3uaoz0NAbuzAIDBGlH6cJmu5lMWibTVMRYBwHu
         nh7s3MkAr44CR4oHG4wsQ73JjutJ2xc1cWf/p95ef56rPBCCIocLOdk/1h33pncNOar1
         0fIA==
X-Gm-Message-State: APjAAAXwV41UUUfxOPwqyBrT4mpT77eY4hETrLN+ntvioJPqUuKllCSI
        OylHj4G4dQXoxlHXsRo2VvFEfZxlvmfpDao+ZLpBKEjA
X-Google-Smtp-Source: APXvYqy4MhyuLll2kPZdcoXnoRZS01ZXptzS+qBRAo3MUObjclIKgOc9p/bqPzZUWgQh8dAxpvuF8Q1bcSIoAKo5Iws=
X-Received: by 2002:a5b:48a:: with SMTP id n10mr17439800ybp.188.1562064226041;
 Tue, 02 Jul 2019 03:43:46 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Tue, 2 Jul 2019 11:43:34 +0100
Message-ID: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
Subject: blkid identifying whole disk ntfs as both ntfs and msdos partition table
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

Tested with mkntfs from ntfsprogs and blkid and wipefs from util-linux git =
HEAD.
Test case:

# cat /etc/fedora-release
Fedora release 30 (Thirty)
# dd if=3D/dev/zero bs=3D1M of=3D/dev/sdb
dd: error writing '/dev/sdb': No space left on device
8193+0 records in
8192+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 39.6128 s, 217 MB/s
#  mkntfs --version
mkntfs v2017.3.23 (libntfs-3g)
...
# mkntfs -Q -F /dev/sdb
/dev/sdb is entire device, not just one partition.
mkntfs forced anyway.
Cluster size has been automatically set to 4096 bytes.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.
# ./blkid --version
lt-blkid from util-linux 2.34.24-e3bb9  (libblkid 2.34.24, 14-Jun-2019)
# ./blkid /dev/sdb
/dev/sdb: UUID=3D"3B64D28A5CF89146" TYPE=3D"ntfs" PTTYPE=3D"dos"
# ./wipefs /dev/sdb
DEVICE OFFSET TYPE UUID             LABEL
sdb    0x3    ntfs 3B64D28A5CF89146
sdb    0x1fe  dos

Note that the test ntfs image in util-linux doesn't cause this.  Just file
systems created by mkntfs from ntfsprogs.

# dd if=3D/dev/zero bs=3D1M of=3D/dev/sdb
# xzcat tests/ts/blkid/images-fs/ntfs.img.xz > /dev/sdb
# ./blkid /dev/sdb
/dev/sdb: LABEL=3D"M-PM-^]M-PM->M-PM-2M-QM-^KM-PM-9 M-QM-^BM-PM->M-PM-<"
UUID=3D"09CBB6DE30C87310" TYPE=3D"ntfs"
# ./wipefs /dev/sdb
DEVICE OFFSET TYPE UUID             LABEL
sdb    0x3    ntfs 09CBB6DE30C87310 =D0=9D=D0=BE=D0=B2=D1=8B=D0=B9 =D1=82=
=D0=BE=D0=BC

Thanks,
Mike
