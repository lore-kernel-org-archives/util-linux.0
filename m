Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbbFVOPx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Jun 2015 10:15:53 -0400
Date: Mon, 22 Jun 2015 16:15:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <ruediger.meier@ga-group.nl>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: mount existing tmpfs mounts a new tmpfs
Message-ID: <20150622141551.GK1992@ws.net.home>
References: <55876C53.7030505@ubuntu.com>
 <20150622082008.GH1992@ws.net.home>
 <201506221455.46930.ruediger.meier@ga-group.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201506221455.46930.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 22, 2015 at 02:55:37PM +0200, Ruediger Meier wrote:
> On Monday 22 June 2015, Karel Zak wrote:
> > On Sun, Jun 21, 2015 at 10:00:51PM -0400, Phillip Susi wrote:
> > > Forwarding this from debian bug #772419: Run mount /run, and it
> > > mounts a new tmpfs over top of the existing one in /run ( even if
> > > /run isn't listed in /etc/fstab ), hiding the existing files.  It
> > > should say that it is already mounted.
> >
> > We usually don't play any policy games in userspace (exception is
> > mount -a).  If it's supported by kernel then it's correct behaviour.
> > And IMHO it's really correct behaviour because it creates a *new*
> > filesystem.
> 
> Is it really the kernel who does not mount again other filesystems?

Sure, use strace to see more:

> For me tmpfs behavior looks different for no reason:
> 
> $ cat /etc/fstab
> /dev/sda1                  /boot       ext2   defaults  0 0
> glaukos:/exports/opt/intel /opt/intel  nfs    defaults  0 0
> proc                       /tmp/proc   proc   defaults  0 0
> none                       /tmp/tmpfs  tmpfs  defaults  0 0
> 
> When everything is mounted already I get:
> 
> $ mount /boot
> mount: /dev/sda1 is already mounted or /boot busy
>        /dev/sda1 is already mounted on /boot

# strace -e mount mount /boot
mount("/dev/sda2", "/boot", "ext4", MS_MGC_VAL, NULL) = -1 EBUSY
(Device or resource busy)

> $ mount /opt/intel/
> mount.nfs: /opt/intel is busy or already mounted

# strace -fe mount mount /mnt/backup
Process 27674 attached
[pid 27674] mount("sr.net.home:/mnt/store/backup", "/mnt/backup",
"nfs", 0, "vers=4.2,addr=192.168.111.1,clie"...) = -1 EPROTONOSUPPORT
(Protocol not supported)
[pid 27674] mount("sr.net.home:/mnt/store/backup", "/mnt/backup",
"nfs", 0, "vers=4.1,addr=192.168.111.1,clie"...) = -1 EPROTONOSUPPORT
(Protocol not supported)
[pid 27674] mount("sr.net.home:/mnt/store/backup", "/mnt/backup",
"nfs", 0, "vers=4.0,addr=192.168.111.1,clie"...) = -1 EBUSY (Device or
resource busy)

> $ mount /tmp/proc/
> mount: proc is already mounted or /tmp/proc busy
>        proc is already mounted on /proc
>        proc is already mounted on /tmp/proc

strace -e mount mount -t proc none /proc
mount("none", "/proc", "proc", MS_MGC_VAL, NULL) = -1 EBUSY (Device or
resource busy)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
