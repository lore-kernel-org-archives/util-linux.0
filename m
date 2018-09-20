Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:34420 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeITTI2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Sep 2018 15:08:28 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w8KDOtLA075403
        for <util-linux@vger.kernel.org>; Thu, 20 Sep 2018 06:24:57 -0700
Message-ID: <5BA39FA7.3070504@tlinx.org>
Date: Thu, 20 Sep 2018 06:24:55 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: question about lsns.
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I came across lsns and decided to see what ns's it might list on my
system.

as my self,
>  lsns
        NS TYPE   NPROCS   PID USER COMMAND
4026531835 cgroup     21 22959 law  gvim prelink_dependencies
4026531836 pid        21 22959 law  gvim prelink_dependencies
4026531837 user       21 22959 law  gvim prelink_dependencies
4026531838 uts        21 22959 law  gvim prelink_dependencies
4026531839 ipc        21 22959 law  gvim prelink_dependencies
4026531840 mnt        21 22959 law  gvim prelink_dependencies
4026531992 net        21 22959 law  gvim prelink_dependencies

and as root:

# lsns
        NS TYPE   NPROCS PID USER COMMAND
4026531835 cgroup    429   1 root init [3]        
4026531836 pid       429   1 root init [3]        
4026531837 user      429   1 root init [3]        
4026531838 uts       429   1 root init [3]        
4026531839 ipc       429   1 root init [3]        
4026531840 mnt       428   1 root init [3]        
4026531860 mnt         1  82 root kdevtmpfs
4026531992 net       429   1 root init [3]

-----------------

To me this seems a bit odd as I don't recall doing and nsenter or creation
commands, though there may be some tucked away in some script or another.

But why these?

a gvim editor session (I hve several files up, but don't know if they are
all in the same ns.  It doesn't seem the lsns has a way to list what the
other procs are in the name space (might be useful rather than going
and looking at the hierarchy).

And for root....an init cmd that seems to have a nproc value rough equal
to the number of procs running.

Not sure what NPROCS means...a ps -ef|grep law shows 81 procs, but weeding
out the ones that appear to be threads, I get 35, so not sure where
nprocs gets 21.

Is this a result of auto-grouping by the the scheduler?
Seems odd it points at an edit session as the command that is
in the ns and not a bash or ssh login...

Thanks!
-l
