Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: bug v2.29-rc2, /etc/mtab file
Date: Thu, 20 Oct 2016 18:24:43 +0200
Cc: util-linux@vger.kernel.org
References: <201610201559.15231.sweet_f_a@gmx.de> <20161020160021.2hjla2qxaglo37tv@ws.net.home>
In-Reply-To: <20161020160021.2hjla2qxaglo37tv@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610201824.43329.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 20 October 2016, Karel Zak wrote:
> On Thu, Oct 20, 2016 at 03:59:15PM +0200, Ruediger Meier wrote:
> > Hi,
> >
> > On RHEL/CentOs-6 with /etc/mtab file some of our mount tests write
> > something to /etc/mtab. AFAIR it should be ignored nowadays by
> > default, right?
> >
> > After our test-suite was running I see these lines left in
> > /etc/mtab:
> >
> > tmpd
> > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> >fstab-broken-mnt tmpfs rw 0 0 tmpd
> > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> >fstab-broken-mnt tmpfs rw 0 0 none
> > /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/
> >fstab-none-mnt tmpfs rw,nosuid,nodev,relatime 0 0
>
> Because our mount (from the test) calls /sbin/mount.tmpfs where
> is executed standard mount(8) from system.

Ah interesting. That's why it works on my local system (also mtab file) 
where I don't have /sbin/mount.tmpfs.

> I'll improve the test to call umount --fake to clean up mtab.

Still a bit annoying that these "third party mount binaries" may modify 
mtab but our umount does not.

cu,
Rudi
