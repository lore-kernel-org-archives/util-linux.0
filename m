Return-Path: util-linux-owner@vger.kernel.org
Received: from fe3.lbl.gov ([128.3.41.68]:13063 "EHLO fe3.lbl.gov"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932636AbdKOPV7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Nov 2017 10:21:59 -0500
Received: by mail-it0-f70.google.com with SMTP id y15so1590563ita.3
        for <util-linux@vger.kernel.org>; Wed, 15 Nov 2017 07:21:57 -0800 (PST)
Received: from DOE8019603.domain (75-166-200-76.hlrn.qwest.net. [75.166.200.76])
        by smtp.gmail.com with ESMTPSA id s16sm6716909itb.15.2017.11.15.07.21.55
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2017 07:21:55 -0800 (PST)
To: util-linux@vger.kernel.org
From: Douglas Jacobsen <dmjacobsen@lbl.gov>
Subject: mnt_is_readonly() call to utimensat() has serious performance
 consequences
Message-ID: <e1932cb6-9c28-5cfd-29d2-78d39ade41b2@lbl.gov>
Date: Wed, 15 Nov 2017 08:21:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,


Some time ago we traced a large scale booting issue back to the 
utimensat() call that mnt_is_readonly() makes when mounting a 
read-write, but root-squashed parallel filesystem.

This is caused by many clients mounting nearly simultaneously, failing 
the access() call earlier (because the FS is root-squashed) and then 
calling utimensat() at about the same time.  Because it attempts to 
write to the mount point, the remote filesystem manager serializes the 
passage through utimensat().

The filesystem is already mounted at this point and it appears that the 
utimensat() call is really only used to append a "ro" to the apparent 
mount flags for /etc/mtab, it seems that this is a high cost to make 
this determination.

It seems this was discussed in this thread previously: 
https://marc.info/?l=util-linux-ng&m=148405286532392&w=2 
<https://marc.info/?l=util-linux-ng&m=148405286532392&w=2>

However, I think it would be preferable to not be required to have a 
custom-build of util-linux to avoid this problem.  Is this secondary 
check with utimensat() really necessary?  Perhaps an alternative to 
removing it would be to have a check to see if /etc/mtab is writable 
before aggressively collecting data that may not be able to be outputted 
to it, for example, in the case that /etc/mtab is a symlink to 
/proc/mounts this logic could be skipped.  Skimming through the libmount 
code, perhaps adding a check against mnt_context_mtab_writable() here:

https://github.com/karelzak/util-linux/blob/master/libmount/src/context_mount.c#L1001 
<https://github.com/karelzak/util-linux/blob/master/libmount/src/context_mount.c#L1001>

would be feasible.

Thank you,
Doug
