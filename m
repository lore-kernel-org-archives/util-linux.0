Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4EDC7EE23
	for <util-linux@archiver.kernel.org>; Sat, 20 May 2023 23:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjETXkA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 20 May 2023 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETXj7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 20 May 2023 19:39:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19E13E
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 16:39:57 -0700 (PDT)
Date:   Sun, 21 May 2023 01:39:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684625996; bh=tJw/Ycpo1T3Vc7N6tU4W3rV+T0r5CFiGGVgGcqcfZEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvv0rzbNydnc0U1jVM+X8+ZPFZOBtdP2bKhuLsaCBOTLIMmiefWbdHJC8jyotvvAi
         3HFigsAk+bosanGI+0cGmMZkYJbBDf4Zdc3jdEralzTMsiGxBV012NaR19b485uGBT
         bhUW1T2hxLbev3PC8eq/uwbau4nNaaqOhkCr/qU8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Thomas Deutschmann <whissi@whissi.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
Message-ID: <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
 <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-05-20 17:23:05+0200, Thomas Deutschmann wrote:
> On 2023-05-20 06:51, Thomas Weißschuh wrote:
> > Could you test the fix proposed in
> > https://github.com/util-linux/util-linux/pull/2248 ?
> > 
> > (For testing on a real system you only need the changes to
> > libmount/src/hook_mount.c, ignore the testing stuff)
> 
> This is addressing the reported
> 
>   mount --make-slave /proc

Thanks for confirming!

<snip>

> However, I noticed additional problems. Remounts for example are still not
> working but no error is shown:
> 
> > ~ # findmnt /
> > TARGET  SOURCE    FSTYPE OPTIONS
> > /       /dev/dm-0 ext4   ro,relatime,stripe=32650
> > ~ # mount -o remount,rw /
> > ~ # findmnt /
> > TARGET   SOURCE    FSTYPE OPTIONS
> > /        /dev/dm-0 ext4   ro,relatime,stripe=32650
> 
> I don't see a fallback in strace:
> 
> > [...]
> > open_tree(AT_FDCWD, "/", OPEN_TREE_CLOEXEC) = 3
> > mount_setattr(-1, NULL, 0, NULL, 0)     = -1 ENOSYS (Function not implemented)
> > getuid()                                = 0
> > geteuid()                               = 0
> > getgid()                                = 0
> > getegid()                               = 0
> > prctl(PR_GET_DUMPABLE)                  = 1 (SUID_DUMP_USER)
> > newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffe4fe7c590, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
> > mkdir("/run/mount", 0755)               = -1 EEXIST (File exists)
> > newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffe4fe7c480, 0) = -1 ENOENT (No such file or directory)
> > newfstatat(AT_FDCWD, "/run/mount", {st_mode=S_IFDIR|0755, st_size=40, ...}, 0) = 0
> > geteuid()                               = 0
> > getegid()                               = 0
> > getuid()                                = 0
> > getgid()                                = 0
> > access("/run/mount", R_OK|W_OK)         = 0
> > fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
> > fsconfig(4, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
> > fsconfig(4, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0) = 0
> > close(4)                                = 0
> > close(3)                                = 0
> > dup(1)                                  = 3
> > close(3)                                = 0
> > dup(2)                                  = 3
> > close(3)                                = 0
> > exit_group(0)                           = ?
> > +++ exited with 0 +++

I'm not sure that the fallback should be necessary here.
The calls to fsconfig() seem to succeed.

I am having trouble reproducing the issue.

Could you
* provide more details about the used kernel?
* provide reproduction steps that are simple to reproduce, for example
  using tmpfs mounts.

FYI there was a report on GitHub that confirms more or less this exact
usecase to be working with my patch. [0]

[0] https://github.com/util-linux/util-linux/issues/2247#issuecomment-1555967726

Thomas
