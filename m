Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A3C433F5
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 11:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhLNLpg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:45:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNLpg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Dec 2021 06:45:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4E0E021136;
        Tue, 14 Dec 2021 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639482335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+iMMXZyQEdoGDI/3O8mzZ3h7mgji+U5j9WHDrhRbDQ=;
        b=TtXgPR6ICoDshc1VXknDq/hA/5dHRRHpXVKBbNDfOO/Txa0sfzH0Ub2pfsVsGmP3i3bLa2
        mCZZelBbG9emu57wZUTBK/77q1bOYVk/DNBh0QZvBTruFYr+jOulCiRjmHtTfCQd4A1IJD
        Y536RyspDsDdNQxRAySaP9HQfXnMJxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639482335;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+iMMXZyQEdoGDI/3O8mzZ3h7mgji+U5j9WHDrhRbDQ=;
        b=U6KvdalDLyCXZL5H9zlu251gKuaEcXkbI2isR4tzMS7ESS2a57tlzqFsV4eJSjK5LqedJK
        2QA/lircYYP13fCg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2149A3B81;
        Tue, 14 Dec 2021 11:45:34 +0000 (UTC)
Date:   Tue, 14 Dec 2021 12:45:33 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kzak@redhat.com,
        kurt@garloff.de, den@openvz.org, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20211214114533.GW117207@kunlun.suse.cz>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209141233.3774937-3-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
> Since c7e9d0020361f4308a70cdfd6d5335e273eb8717
> "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel,
> floppy drive works bad when opened with O_NONBLOCK: first read may
> fail. This cause probing fail and leave error messages in dmesg. So, if
> we detect that openedfd is floppy, reopen it without O_NONBLOCK flag.
> 
> Reproduce is simple:
> 1. start the linux system (kernel should include the mentioned commit)
>    in QEMU virtual machine with floppy device and with floppy disk
>    inserted.
> 2. If floppy module is not inserted, modprobe it.
> 3. Try "blkid /dev/fd9": it will show nothing, errors will appear in
>    dmesg
> 4. Try "mount /dev/fd0 /mnt": it may succeed (as mount not only probing
>    but also try filesystems one by one, if you have vfat in
>    /etc/filesytems or in /proc/filesystems, mount will succeed), but
>    errors about failed read still appear in dmesg, as probing was done.
> 
> Mentioned errors in dmesg looks like this:
>  floppy0: disk absent or changed during operation
>  blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>  floppy0: disk absent or changed during operation
>  blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>  Buffer I/O error on dev fd0, logical block 0, async page read
> 
> Note also, that these errors also appear in early dmesg messages, if
> probing is done on system startup. For example, it happens when
> cloud-init package is installed.
> 
> Note2: O_NONBLOCK flag for probing is used since
> 39f5af25982d8b0244000e92a9d0e0e6557d0e17
> "libblkid: open device in nonblock mode", which was done to fix the
> issue with cdrom: if tray is open and we call open() without O_NONBLOCK
> the tray may be automatically closed, which is not what we want in
> blkid.
> 
> Good discussion on this bug is here:
> https://bugzilla.suse.com/show_bug.cgi?id=1181018
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Note, that this commit is done as a "minimal change", i.e. I only try to
> rollback O_NONBLOCK for floppy. The other way is to detect CDROM
> instead, and reopen with original flags for everything except CDROM.
> 
> I also tried fcntl instead of close/open, and that didn't help.
> 
>  libblkid/src/probe.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> index 70e3dc0eb..68a644597 100644
> --- a/libblkid/src/probe.c
> +++ b/libblkid/src/probe.c
> @@ -94,6 +94,9 @@
>  #ifdef HAVE_LINUX_CDROM_H
>  #include <linux/cdrom.h>
>  #endif
> +#ifdef HAVE_LINUX_FD_H
> +#include <linux/fd.h>
> +#endif
>  #ifdef HAVE_LINUX_BLKZONED_H
>  #include <linux/blkzoned.h>
>  #endif
> @@ -200,10 +203,32 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
>   * We add O_NONBLOCK flag to the mode, as opening CDROM without this flag may
>   * load to closing the rom (if it's open), which is bad thing in context of
>   * blkid: we don't want to change the actual device state.
> + *
> + * Still, since c7e9d0020361f4308a70cdfd6d5335e273eb8717
> + * "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel, floppy
> + * drive works bad when opened with O_NONBLOCK: first read may fail. This cause
> + * probing fail and leave error messages in dmesg. So, if we detect that opened
> + * fd is floppy, reopen it without O_NONBLOCK flag.
>   */
>  int blkid_safe_open(const char *filename, int mode)
>  {
> -	return open(filename, mode | O_NONBLOCK);
> +	int fd = open(filename, mode | O_NONBLOCK);
> +	if (fd < 0) {
> +		return fd;
> +	}
> +
> +#ifdef FDGETDRVTYP
> +	{
> +		char name[1000];
Hello,

I wonder if it's better to use FDGETFDCSTAT which seems to be meant as
stable API.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fd.h#n271

As is this allocates 1k from stack and can be presumably called from
application context with arbitrarily deep stack so it seems a bit
wasteful. floppy_fdc_state has under 60 bytes.

Also if you are not interested in the result you can make the buffer
static. Not sure it makes sense to bother if the buffer size is
reasonable.

Thanks

Michal

> +
> +		if (ioctl(fd, FDGETDRVTYP, &name) >= 0) {
> +			close(fd);
> +			fd = open(filename, mode);
> +		}
> +	}
> +#endif /* FDGETDRVTYP */
> +
> +	return fd;
>  }
>  
>  
> -- 
> 2.31.1
> 
