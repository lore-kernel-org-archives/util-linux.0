Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47349 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756534Ab2IJJD5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Sep 2012 05:03:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8A93ve5021903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 10 Sep 2012 05:03:57 -0400
Received: from x2 (ovpn-113-69.phx2.redhat.com [10.3.113.69])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8A93uak023063
	for <util-linux@vger.kernel.org>; Mon, 10 Sep 2012 05:03:56 -0400
Date: Mon, 10 Sep 2012 11:03:55 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: hwclock fail with 2.22
Message-ID: <20120910090355.GB27276@x2.net.home>
References: <20120908035600.GM1899@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120908035600.GM1899@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 07, 2012 at 11:56:00PM -0400, Dave Reisner wrote:
> I'm trying to figure out a bug report that I received the other day with
> hwclock, and I'm curious if anyone else has seen the behavior. I'm not
> able to reproduce reliably as the user is:
> 
> https://bugs.archlinux.org/task/31416
> 
> The bits about fsck can be ignored, they're merely a symptom. I was able
> to trace this behavior with an educated guess back to 839be2ba6.
> 
> I suppose part of the issue is that I'm fairly oblivious about how the
> hwclock works, and the interaction with the timezone, particularly when
> the clock is set to UTC. The reporter is using sysvinit with Arch
> Linux's initscripts. hwclock's involvement in his case boils down to the
> following call on bootup:
> 
> hwclock --systz --utc --noadjfile
> 
> Of course, the --systz flag in there won't work as it used to anymore,
> but the commit message I've picked out doesn't seem to match the
> behavior it changes.

The command hwclock --systz has to be the *first* place where system
uses settimeofday() after reboot, otherwise it will do nothing.

Only very first settimeofday() call modify the kernel timezone and
warp the system clocks. The timezone setting in userspace have to be
done before you call hwclock to make localtime() usable. (TZ=...)

The reason for the 839be2ba6b44fa9dc is that sometimes people randomly
use hwclock --systz more than once on already running system and then
every hwclock --systz modifies warp the system clocks.

BTW, systemd uses the same solution. (settimeofday) with NULL tv).

See kernel kernel/time.c: do_sys_settimeofday() for more details.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
