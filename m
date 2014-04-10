Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030533AbaDJMtZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Apr 2014 08:49:25 -0400
Date: Thu, 10 Apr 2014 14:49:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Markus Trippelsdorf <markus@trippelsdorf.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140410124914.GB26252@x2.net.home>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <20140409183954.GB778@thunk.org>
 <20140410080514.GA26252@x2.net.home>
 <201404101117.05565.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201404101117.05565.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 10, 2014 at 11:17:04AM +0200, Ruediger Meier wrote:
> Thanks, maybe we could add another minor change to "fstrim -a" itself. 
> If possible it would be IMO useful to skip bind mounts to avoid 
> trimming the same filesystem several times in a row like this:
> 
> $ grep "tmp" /etc/fstab
> /dev/vg0/tmpdirs     /mnt/tmpdirs   ext4       acl,user_xattr     1 2
> /mnt/tmpdirs/tmp     /tmp           none       bind               0 0
> /mnt/tmpdirs/var/tmp /var/tmp       none       bind               0 0
> 
> $ ./fstrim -av
> /tmp: 392 KiB (401408 bytes) trimmed
> /var/tmp: 0 B (0 bytes) trimmed
> /mnt/tmpdirs: 0 B (0 bytes) trimmed
> 
> Skipping bind mounts should still trim all mounted filesytems.

Good idea point, but what about systems where the original
mountpoint is umounted?

 /dev/sda1  /foo    ext4    default
 /foo       /bar    none    bind

  # mount /foo
  # mount /bar
  # umount /foo 

the another story is that we use /proc/self/mountinfo where is
nothing about "bind". It would be probably better to de-duplicate the
list of the filesystems according to filesystem UUID or so.

I'll think about it.

Note all this is probably no problema for ext4 where according to Lukas is 
optimization to not call device trim command when there is nothing to trim.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
