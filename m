Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:59588 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756478AbdKDJQm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Nov 2017 05:16:42 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id vA499pKX066100
        for <util-linux@vger.kernel.org>; Sat, 4 Nov 2017 02:09:53 -0700
Message-ID: <59FD83DF.805@tlinx.org>
Date: Sat, 04 Nov 2017 02:09:51 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: what should blockdev getbpsz return 4k disks w/512e?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I just tried blockdev on a HW raid device (/dev/sdb) composed of
4K disks that can (w/performance penalty) emulate 512 byte disk
(i.e. have the 512e feature).  It is returning 512. 

If the disk is composed of 4K disks, shouldn't the raid show 4K
as well?  Otherwise, how do utils know what alignment to use or
not to use 512 due to penalty costs?  For my formatted disks, I
use 4K allocation units, so for those, I shouldn't see problems,
but some other disk subsystems or raw-disk using progs also need to
know to allocate on 4K boundaries.

Any idea where this info should be showing up?

Thanks!
-linda

