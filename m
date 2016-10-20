Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755552AbcJTQc5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 12:32:57 -0400
Date: Thu, 20 Oct 2016 18:32:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: bug v2.29-rc2, /etc/mtab file
Message-ID: <20161020163255.cxlmn2zkgqkz3sez@ws.net.home>
References: <201610201559.15231.sweet_f_a@gmx.de>
 <20161020160021.2hjla2qxaglo37tv@ws.net.home>
 <201610201824.43329.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610201824.43329.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 06:24:43PM +0200, Ruediger Meier wrote:
> On Thursday 20 October 2016, Karel Zak wrote:
> > On Thu, Oct 20, 2016 at 03:59:15PM +0200, Ruediger Meier wrote:
> > > Hi,
> > >
> > > On RHEL/CentOs-6 with /etc/mtab file some of our mount tests write
> > > something to /etc/mtab. AFAIR it should be ignored nowadays by
> > > default, right?
> > >
> > > After our test-suite was running I see these lines left in
> > > /etc/mtab:
> > >
> > > tmpd
> > > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> > >fstab-broken-mnt tmpfs rw 0 0 tmpd
> > > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> > >fstab-broken-mnt tmpfs rw 0 0 none
> > > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> > >fstab-none-mnt tmpfs rw,nosuid,nodev,relatime 0 0
> >
> > Because our mount (from the test) calls /sbin/mount.tmpfs where
> > is executed standard mount(8) from system.
> 
> Ah interesting. That's why it works on my local system (also mtab file) 
> where I don't have /sbin/mount.tmpfs.
> 
> > I'll improve the test to call umount --fake to clean up mtab.
> 
> Still a bit annoying that these "third party mount binaries" may modify 
> mtab but our umount does not.

Well, this problem cannot exist on system where mtab is symlink. All
"third party mount binaries" should be able to detect the symlink. The
symlink is supported by mount(8) for 10+ years.

And on system where is regular mtab you don't want to use util-linux
compiled without mtab support.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
