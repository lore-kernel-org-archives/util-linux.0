Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965537AbcJTQAX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 12:00:23 -0400
Date: Thu, 20 Oct 2016 18:00:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: bug v2.29-rc2, /etc/mtab file
Message-ID: <20161020160021.2hjla2qxaglo37tv@ws.net.home>
References: <201610201559.15231.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610201559.15231.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 03:59:15PM +0200, Ruediger Meier wrote:
> Hi,
> 
> On RHEL/CentOs-6 with /etc/mtab file some of our mount tests write something to
> /etc/mtab. AFAIR it should be ignored nowadays by default, right?
> 
> After our test-suite was running I see these lines left in /etc/mtab:
> 
> tmpd /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-broken-mnt tmpfs rw 0 0
> tmpd /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-broken-mnt tmpfs rw 0 0
> none /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-none-mnt tmpfs rw,nosuid,nodev,relatime 0 0

Because our mount (from the test) calls /sbin/mount.tmpfs where
is executed standard mount(8) from system.

I'll improve the test to call umount --fake to clean up mtab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
