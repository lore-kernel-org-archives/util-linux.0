Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754392AbdESJLe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 May 2017 05:11:34 -0400
Date: Fri, 19 May 2017 11:11:25 +0200
From: Karel Zak <kzak@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: "mount -o remount,rw" sometimes doesn't work as expected.
Message-ID: <20170519091125.bdans7hirua3blb5@ws.net.home>
References: <87wp9djp2n.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wp9djp2n.fsf@notabene.neil.brown.name>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 19, 2017 at 05:14:24PM +1000, NeilBrown wrote:
> Suppose /foo and /bar are bind mounts to the same
> filesystem which is currently mounted read-only,
> and suppose the /etc/fstab contains
> 
>   /dev/sda1 /bar ext4 defaults 0 1
>   /bar /foo none bind 0 0
> 
> Now if I want /foo to be writeable I might try:
> 
>   mount /foo -o remount,rw
> 
> and would then be surprised that this doesn't work.
> 
> What is happening is that because only one path has been given, mount
> needs to find the other and goes looking in /etc/fstab.

Frankly remount & fstab sucks.

The problem is that we want to read fstab because remount works as
"replace all old options with new options", so if you don't read
fstab then all options unspecified on command line will be removed.

Let's imagine your command line is "-o remount,ro", but you have also
"noexec" in your fstab. If you don't read fstab then "noexec" will be
removed by the remount operation. This is unexpected by many users.
They want to change only specified options (ro->rw, etc).

It would be possible to read /proc/self/mountinfo on remount (to get
old options), but unfortunately this is not backwardly compatible,
because we have users who call 

    mount /mnt -o remount

(yes, without another options) and they assume that all options will
be reset according to fstab.


*** See man mount: ***

The remount functionality follows the standard way the mount command
works with options from fstab.  This means that mount does not read
fstab (or  mtab)  only  when  both device and dir are specified.

    mount -o remount,rw /dev/foo /dir

After this call all old mount options are replaced and arbitrary stuff
from fstab (or mtab) is ignored, except the loop= option which is
internally generated and maintained by the mount command.

    mount -o remount,rw  /dir

After this call, mount reads fstab and merges these options with the
options from the command line (-o).  If no mountpoint is found in
fstab, then a remount with  unspecified source is allowed.

> If finds an appropriate line and parses out the options.
> Then the mount system call used is
> 
>  mount( "/bar", "/foo", ..., MS_REMOUNT | MS_BIND ,....)
> 
> This changes the per-mountpoint ro flag to rw, but doesn't change the
> filesystem itself.  This can be seen in /proc/self/mountinfo.  There
> are two r[wo] flags, and they are different.
> 
> Had I run:
> 
>   mount /foo -o remount,bind,rw
> 
> I would have expected this.  But as I didn't explicitly ask for "bind",
> it is confusing.
> 
> I think it might be good to ignore "bind" in /etc/fstab when "remount"
> is used.

Another exception :-) I'll think about it, maybe it's not so bad idea
because "remount,bind" is very special.

> However.... when "remount" is used, the "device" is ignored, so there
> isn't a lot of point hunting through /etc/fstab to find it.

Yes, but then you have to specify all options on command line,
unspecified will be removed by remount op.

We have in TODO for years

 - add options to control fstab/mtab mount options usage, something like:

   --options-mode={ignore,append,prepend,replace}      MNT_OMODE_{IGNORE, ...}
   --options-source={fstab,mtab,disable}               MNT_OMODE_{FSTAB,MTAB,NOTAB}
   --options-source-force                              MNT_OMODE_FORCE


all this already supported by libmount, but no exported to the
mount(8) command line.

Maybe I should implement it :)

> If mount is given just one path and the "remount" option, then maybe
> it shouldn't try to find an /etc/fstab entry at all?
> I guess you might want to remount a device??
> Is
>    mount -o remount,rw /dev/sda1
> allowed?  In that case, don't look through /etc/fstab if the path
> is a directory.
> 
> I haven't provided a patch because I'm not 100% sure what the best
> approach would be.
> Does anyone have opinions on what mount should or shouldn't do when
> remounting and only one path is given?
> 
> You could possibly argue that the current behaviour is correct
> as /foo is listed as bind mount.  That doesn't stop is being surprising.
> Also
>    mount /bar /foo -o remount,rw
> 
> doesn't pick up the "bind" flag, so the filesystem gets remounted.
> So I think there is definitely something wrong.

That's question... "remount,bind" is really special and maybe "bind"
from fstab should be really ignored in this case.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
