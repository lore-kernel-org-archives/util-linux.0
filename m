Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeHOJyp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Aug 2018 05:54:45 -0400
Date: Wed, 15 Aug 2018 09:03:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Edward Diener <eldlistmailingz@tropicsoft.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Using libmount to track mount/umount
Message-ID: <20180815070345.qeazo2cqktwu6xyi@ws.net.home>
References: <62d391f1-3fd7-1acc-b57e-103a4bbd5244@tropicsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62d391f1-3fd7-1acc-b57e-103a4bbd5244@tropicsoft.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 14, 2018 at 09:18:26AM -0400, Edward Diener wrote:
> I would like to use the libmount library to track end-user mount/umount
> commands. My first question regards the use of the monitor. What is the
> difference between userspace monitoring and kernel VFS monitoring ?

The userspace handler also monitor writes to /run/mount/utab, it's
important for options like user= or some NFS options maintained in
userspace only. Anyway, if do you not care about options than it's
probably enough to monitor VFS.

The userspace monitor has been mostly implemented for systemd where is
required to have information about all options, for more details see
https://github.com/systemd/systemd/blob/master/src/core/mount.c#L1701

See also test program in the code:
https://github.com/karelzak/util-linux/blob/master/libmount/src/monitor.c#L823


The another possibility to monitor VFS is to use directly poll() for 
/proc/self/mountinfo and than mnt_new_tabdiff(), see findmnt --poll:
https://github.com/karelzak/util-linux/blob/master/misc-utils/findmnt.c#L1071
In this case you do not need the mnt_new_monitor(), but libmnt_monitor
is probably better for complex things and epoll().


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
