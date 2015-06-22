Return-Path: ruediger.meier@ga-group.nl
From: Ruediger Meier <ruediger.meier@ga-group.nl>
To: Karel Zak <kzak@redhat.com>
Subject: Re: mount existing tmpfs mounts a new tmpfs
Date: Mon, 22 Jun 2015 14:55:37 +0200
Cc: Phillip Susi <psusi@ubuntu.com>, "util-linux" <util-linux@vger.kernel.org>
References: <55876C53.7030505@ubuntu.com> <20150622082008.GH1992@ws.net.home>
In-Reply-To: <20150622082008.GH1992@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201506221455.46930.ruediger.meier@ga-group.nl>
List-ID: <util-linux.vger.kernel.org>

On Monday 22 June 2015, Karel Zak wrote:
> On Sun, Jun 21, 2015 at 10:00:51PM -0400, Phillip Susi wrote:
> > Forwarding this from debian bug #772419: Run mount /run, and it
> > mounts a new tmpfs over top of the existing one in /run ( even if
> > /run isn't listed in /etc/fstab ), hiding the existing files.  It
> > should say that it is already mounted.
>
> We usually don't play any policy games in userspace (exception is
> mount -a).  If it's supported by kernel then it's correct behaviour.
> And IMHO it's really correct behaviour because it creates a *new*
> filesystem.

Is it really the kernel who does not mount again other filesystems?
For me tmpfs behavior looks different for no reason:

$ cat /etc/fstab
/dev/sda1                  /boot       ext2   defaults  0 0
glaukos:/exports/opt/intel /opt/intel  nfs    defaults  0 0
proc                       /tmp/proc   proc   defaults  0 0
none                       /tmp/tmpfs  tmpfs  defaults  0 0

When everything is mounted already I get:

$ mount /boot
mount: /dev/sda1 is already mounted or /boot busy
       /dev/sda1 is already mounted on /boot

$ mount /opt/intel/
mount.nfs: /opt/intel is busy or already mounted

$ mount /tmp/proc/
mount: proc is already mounted or /tmp/proc busy
       proc is already mounted on /proc
       proc is already mounted on /tmp/proc

Only tmpfs would be mounted again and again
$ mount /tmp/tmpfs/
$ mount | grep /tmp/tmpfs
none on /tmp/tmpfs type tmpfs (rw,relatime)
none on /tmp/tmpfs type tmpfs (rw,relatime)


cu,
Rudi
