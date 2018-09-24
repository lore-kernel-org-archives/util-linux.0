Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbeIXTEg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Sep 2018 15:04:36 -0400
Date: Mon, 24 Sep 2018 15:02:30 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: question about lsns.
Message-ID: <20180924130230.5y2n4lfzm4bdg74w@ws.net.home>
References: <5BA39FA7.3070504@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5BA39FA7.3070504@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 20, 2018 at 06:24:55AM -0700, L A Walsh wrote:
> I came across lsns and decided to see what ns's it might list on my
> system.
> 
> as my self,
> >  lsns
>        NS TYPE   NPROCS   PID USER COMMAND
> 4026531835 cgroup     21 22959 law  gvim prelink_dependencies
> 4026531836 pid        21 22959 law  gvim prelink_dependencies
> 4026531837 user       21 22959 law  gvim prelink_dependencies
> 4026531838 uts        21 22959 law  gvim prelink_dependencies
> 4026531839 ipc        21 22959 law  gvim prelink_dependencies
> 4026531840 mnt        21 22959 law  gvim prelink_dependencies
> 4026531992 net        21 22959 law  gvim prelink_dependencies
> 
> and as root:
> 
> # lsns
>        NS TYPE   NPROCS PID USER COMMAND
> 4026531835 cgroup    429   1 root init [3]        4026531836 pid       429
> 1 root init [3]        4026531837 user      429   1 root init [3]
> 4026531838 uts       429   1 root init [3]        4026531839 ipc       429
> 1 root init [3]        4026531840 mnt       428   1 root init [3]
> 4026531860 mnt         1  82 root kdevtmpfs
> 4026531992 net       429   1 root init [3]
> 
> -----------------
> 
> To me this seems a bit odd as I don't recall doing and nsenter or creation
> commands, though there may be some tucked away in some script or another.
> 
> But why these?
> 
> a gvim editor session (I hve several files up, but don't know if they are
> all in the same ns.  It doesn't seem the lsns has a way to list what the
> other procs are in the name space (might be useful rather than going
> and looking at the hierarchy).
> 
> And for root....an init cmd that seems to have a nproc value rough equal
> to the number of procs running.
> 
> Not sure what NPROCS means...a ps -ef|grep law shows 81 procs, but weeding
> out the ones that appear to be threads, I get 35, so not sure where
> nprocs gets 21.

The way how lsns works is pretty simple. It reads all /proc/<digit>*
processes, and then group all the processes by namespaces from /proc/#/ns/*.

The NPROCS is number of members in the group of the processes. The
process with the smallest PID is the COMMAND for the namespace.

> Is this a result of auto-grouping by the the scheduler?

Do you mean kernel tasks scheduler? I don't think so.

> Seems odd it points at an edit session as the command that is
> in the ns and not a bash or ssh login...

I think the most important player is initd or init scripts.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
