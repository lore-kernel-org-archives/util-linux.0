Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32905 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbFJGiS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2015 02:38:18 -0400
Received: by qkhg32 with SMTP id g32so20655180qkh.0
        for <util-linux@vger.kernel.org>; Tue, 09 Jun 2015 23:38:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 10 Jun 2015 14:38:17 +0800
Message-ID: <CAGnHSEksSynfOvBMuPAMdFxgdip8=wfUFKhVM5ZeYjiP7x102w@mail.gmail.com>
Subject: making `blkid -lt NAME=value -o device` equivalent to `findfs` for PART{UUID,LABEL}
From: Tom Yan <tom.ty89@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In commit c48508c2, findfs was given ability to work with PARTUUID and
PARTLABEL. It works on all four types with blkid_evaluate_tag().

When blkid is run in form of `blkid -lt NAME=value -o device` for UUID
and LABEL, it works the same way as findfs:

    /* convert LABEL/UUID lookup to evaluate request */
    if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
        (!strcmp(search_type, "LABEL") || !strcmp(search_type, "UUID"))) {
        eval++;
        lookup = 0;
    }

but not always for PARTUUID and PARTLABEL.

Would it be a good idea to add them in the test as well, so that
`findfs` can be considered an equivalence/shortcut as blkid in that
form?

[tom@localhost ~]$ blkid -t PARTLABEL="EFI System" -o device
/dev/sda1
/dev/sdb1
[tom@localhost ~]$ blkid -t LABEL=TEST -o device
/dev/sda1
/dev/sdb1
[tom@localhost ~]$ blkid -lt PARTLABEL="EFI System" -o device
/dev/sda1
[tom@localhost ~]$ findfs PARTLABEL="EFI System"
/dev/sdb1
[tom@localhost ~]$ blkid -lt LABEL=TEST -o device
/dev/sdb1
[tom@localhost ~]$ findfs LABEL=TEST
/dev/sdb1
