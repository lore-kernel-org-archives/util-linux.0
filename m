Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbaAIKC7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jan 2014 05:02:59 -0500
Date: Thu, 9 Jan 2014 11:02:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: "nofail" and already mounted devices?
Message-ID: <20140109100254.GD7516@x2.net.home>
References: <1389203741.8841.31.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389203741.8841.31.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 08, 2014 at 06:55:41PM +0100, Stanislav Brabec wrote:
> Attempting to mount of already mounted devices is a common situation in
> many scripts.

What about to fix the scripts? :-)

All you need is to call

    findmnt --source <dev> --target <mountpoint>

and another possibility is compose /tmp/fstab by the script and then
call "mount --all --fstab /tmp/fstab"

> There is no easy way to detect it in the current mount
> implementation.
>
> Would be acceptable a patch that adds "already mounted" to "nofail"?

Maybe.

> If not, what would be the best way of enabling this feature for mounting
> a single device? (It already exists in mount, but it is usable only with
> "mount -a".)

It's not the same situation. The mount --all checks for the problem in
userspace (don't call mount(2) if the device is already mounted), but 
for a single device we always call mount(2) and "already mounted or
busy" is based on EBUSY from kernel and you have to check mtab to
verify that the device is really already mounted (sys-utils/mount.c:481).

> - Add another mount option, e. g. mountednofail or mountedok

I'd like to avoid new mount options.

> - Make possible to use "-a" with further arguments.

  mount -a /foo /bar [...]

Right? 

It seems also attractive feature when you want to manually mount more
filesystems and it's without any side effects to the current mount(8)
semantic. (And we already ave "umount /foo /bar [...]".)

If you want to implement it then you have to filter out fstab entries
in the sys-utils/mount.c:mount_all() because "mount-all" logic is
hidden in libmount and I'm not sure if I want to extend the API for
this functionality :-)

So something like, sys-utils/mount.c:mount_all():

 if (nwanted) {
         struct libmnt_table *fstab;

         mnt_context_get_fstab(cxt, &fstab);

         while (mnt_table_next_fs(fstab, itr, &fs) == 0) {
            int yes = 0;

            for (i = 0; yes == 0 && i < nwanted; i++)
                yes = mnt_fs_match_target(fs, wanted[i], cache);
            if (!yes)
                mnt_table_remove_fs(fstab, fs);
         }
 }

 while (mnt_context_next_mount ....

 ... where wanted[] is array composed from argv[].



    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
