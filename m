Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33151 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdAYRaO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Jan 2017 12:30:14 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B72CDAB5D
        for <util-linux@vger.kernel.org>; Wed, 25 Jan 2017 17:30:11 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 0/1] fstrim: de-duplication of btrfs subvolumes
Message-ID: <bebe5a12-6927-b602-22ea-ea8e62b7f4ce@suse.cz>
Date: Wed, 25 Jan 2017 18:30:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I got a report that TRIM is called many times on btrfs with subvolumes.
I did a research and found that sys-utils/fstrim.c: uniq_fs_source_cmp()
contains a code that compares not only file system sources (i. e.
devices), but also roots.

I doubt that it is needed in any situation. We just care about source,
i. e. device node. I think that if it matches, it is always particular
device duplicate.

Root does not equal for btrfs subvolumes, but also it does not equal for
bind mounts. And btrfs subvolumes remain duplicated after the whole
de-duplication process.

The patch assumes that the root comparison is not needed here at all. If
it is not true, I will prepare another patch ignoring root specifically
for btrfs.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
