Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:59468 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEBBBl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 May 2018 21:01:41 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w420d3lj009785
        for <util-linux@vger.kernel.org>; Tue, 1 May 2018 17:39:05 -0700
Message-ID: <5AE908A7.2010900@tlinx.org>
Date: Tue, 01 May 2018 17:39:03 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: configure output seems confusing in util-linux-2.32
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Looked at configure help, saw:

Optional packages:
...
  --with-systemd          build with support for systemd

to me, this means systemd is optional and may be
included using a 'with'.

Conversely, one could use:
  --without-systemd

which, in this configure, should have no effect (default
is 'without'), right?

I included the --without-systemd flag (as a future protection
should the default change), but configure's output
had: (relative numbers added for ref):

       1. checking for syscall sched_getaffinity... SYS_sched_getaffinity
       2. checking for syscall sched_setattr... SYS_sched_setattr
       3. Package systemd was not found in the pkg-config search path.
       4. Perhaps you should add the directory containing `systemd.pc'
       5. to the PKG_CONFIG_PATH environment variable
       6. No package 'systemd' found
       7. checking that generated files are newer than configure... done


Lines 3-6 suggest that I should add support for systemd so it
can be built.  Why does it even test for systemd when I
specified '--without-systemd'?

FWIW, configure finished but I haven't tried to build it yet.



