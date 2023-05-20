Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E52C77B7F
	for <util-linux@archiver.kernel.org>; Sat, 20 May 2023 15:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjETPXN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 20 May 2023 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETPXN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 20 May 2023 11:23:13 -0400
Received: from yamato.tf-network.de (mailstorage3.tf-network.de [IPv6:2001:4ba0:ffa0:1b::d2:221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB66FE
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 08:23:11 -0700 (PDT)
Received: from amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221])
        by yamato.tf-network.de (Postfix) with ESMTP id 4QNnXX5wWCz444r
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 17:23:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis3.tf-network.de
Received: from smtp.tf-network.de ([93.186.202.221])
        by amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221]) (amavisd-new, port 10024)
        with LMTP id WMoQUytg9dXr for <util-linux@vger.kernel.org>;
        Sat, 20 May 2023 17:23:08 +0200 (CEST)
Received: from [IPV6:2a0a:a547:20fc:0:b5ee:c596:4ec3:ad6e] (2a0a-a547-20fc-0-b5ee-c596-4ec3-ad6e.ipv6dyn.netcologne.de [IPv6:2a0a:a547:20fc:0:b5ee:c596:4ec3:ad6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by securesmtp.tf-network.de (Postfix) with ESMTPSA id 4QNnXX23yqz442N
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 17:23:08 +0200 (CEST)
Message-ID: <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
Date:   Sat, 20 May 2023 17:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
Content-Language: en-US
To:     util-linux@vger.kernel.org
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
From:   Thomas Deutschmann <whissi@whissi.de>
In-Reply-To: <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Thomas :)

On 2023-05-20 06:51, Thomas Weißschuh wrote:
> Could you test the fix proposed in
> https://github.com/util-linux/util-linux/pull/2248 ?
> 
> (For testing on a real system you only need the changes to
> libmount/src/hook_mount.c, ignore the testing stuff)

This is addressing the reported

   mount --make-slave /proc

issue. I.e. in strace you will see your added call to 
mount_setattr_is_supported() which will fail because it is not supported 
but afterwards it will try old syscall:

> getuid()                                = 0
> geteuid()                               = 0
> open_tree(AT_FDCWD, "/", OPEN_TREE_CLOEXEC) = 3
> mount_setattr(-1, NULL, 0, NULL, 0)     = -1 ENOSYS (Function not implemented)
> getuid()                                = 0
> geteuid()                               = 0
> getgid()                                = 0
> getegid()                               = 0
> prctl(PR_GET_DUMPABLE)                  = 1 (SUID_DUMP_USER)
> newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffdfabad380, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
> mkdir("/run/mount", 0755)               = -1 EEXIST (File exists)
> newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffdfabad270, 0) = -1 ENOENT (No such file or directory)
> newfstatat(AT_FDCWD, "/run/mount", {st_mode=S_IFDIR|0755, st_size=40, ...}, 0) = 0
> geteuid()                               = 0
> getegid()                               = 0
> getuid()                                = 0
> getgid()                                = 0
> access("/run/mount", R_OK|W_OK)         = 0
> mount("none", "/", NULL, MS_SLAVE, NULL) = 0
> close(3)                                = 0

However, I noticed additional problems. Remounts for example are still 
not working but no error is shown:

> ~ # findmnt /
> TARGET  SOURCE    FSTYPE OPTIONS
> /       /dev/dm-0 ext4   ro,relatime,stripe=32650
> ~ # mount -o remount,rw /
> ~ # findmnt /
> TARGET   SOURCE    FSTYPE OPTIONS
> /        /dev/dm-0 ext4   ro,relatime,stripe=32650

I don't see a fallback in strace:

 > [...]
> open_tree(AT_FDCWD, "/", OPEN_TREE_CLOEXEC) = 3
> mount_setattr(-1, NULL, 0, NULL, 0)     = -1 ENOSYS (Function not implemented)
> getuid()                                = 0
> geteuid()                               = 0
> getgid()                                = 0
> getegid()                               = 0
> prctl(PR_GET_DUMPABLE)                  = 1 (SUID_DUMP_USER)
> newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffe4fe7c590, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
> mkdir("/run/mount", 0755)               = -1 EEXIST (File exists)
> newfstatat(AT_FDCWD, "/run/mount/utab", 0x7ffe4fe7c480, 0) = -1 ENOENT (No such file or directory)
> newfstatat(AT_FDCWD, "/run/mount", {st_mode=S_IFDIR|0755, st_size=40, ...}, 0) = 0
> geteuid()                               = 0
> getegid()                               = 0
> getuid()                                = 0
> getgid()                                = 0
> access("/run/mount", R_OK|W_OK)         = 0
> fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
> fsconfig(4, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
> fsconfig(4, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0) = 0
> close(4)                                = 0
> close(3)                                = 0
> dup(1)                                  = 3
> close(3)                                = 0
> dup(2)                                  = 3
> close(3)                                = 0
> exit_group(0)                           = ?
> +++ exited with 0 +++



-- 
Regards,
Thomas
