Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BDC7EE2A
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjEVHnJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjEVHnH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 03:43:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF65B0
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 00:43:05 -0700 (PDT)
Date:   Mon, 22 May 2023 09:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684741384; bh=iR9MU7N00eiIeXbppJdDbveVdPBqJuz+k6vinz7BXrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/1ii3xF2NH7LDaL++zt0Vy+CokdAw+GczzrNooo7SmiM0fswJ2ZEv3bVFuvD4Ad4
         5JQ2JvFxfgJF2AfLkRtcfFoer27UzDqGEiUss5CFE4tKH8/m9+ZpGlS3abol4q2N48
         R7KUrsgrx/eh/BhYuBJ5BPno1T8TPdpgk6H8BFlI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Thomas Deutschmann <whissi@whissi.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
Message-ID: <a774f583-f985-4849-9b75-4fed59a47209@t-8ch.de>
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
 <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
 <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
 <089b028f-7ccb-5389-4ba0-06830f27e738@whissi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <089b028f-7ccb-5389-4ba0-06830f27e738@whissi.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-05-22 00:13:14+0200, Thomas Deutschmann wrote:
> Hi
> 
> On 2023-05-21 01:39, Thomas Weißschuh wrote:
> > I am having trouble reproducing the issue.
> > 
> > Could you
> > * provide more details about the used kernel?
> > * provide reproduction steps that are simple to reproduce, for example
> >    using tmpfs mounts.
> 
> Used kernel.config: https://0x0.st/HqKc.txt
> 
> I cannot reproduce using tmpfs, i.e.
> 
>   # mkdir /mnt/test
>   # mount -t tmpfs none /mnt/test
>   # mount -l | grep test
>   none on /mnt/test type tmpfs (rw,relatime)
>   # touch /mnt/test/foo.txt
>   # mount -o remount,ro /mnt/test
>   # date >> /mnt/test/foo.txt
>   -bash: /mnt/test/foo.txt: Read-only file system
>   # mount -o remount,rw /mnt/test
>   # date >> /mnt/test/foo.txt
>   # cat /mnt/test/foo.txt
>   Sun May 21 11:04:42 PM CEST 2023
> 
> works.
> 
> But on boot, when the init system remounts root filesystem (using command
> "mount -n -o remount,rw /"), the command seems to be successful (mount
> command exits with zero exit code) but the root filesystem is still
> read-only and all following services expecting writable rootfs will fail.
> 
> I have
> 
>   UUID=e290359f-8335-4fba-9fae-077b3505e0b2 / ext4 defaults 0 1
> 
> in /etc/fstab. I saw https://github.com/util-linux/util-linux/pull/2250 but
> this doesn't help (and changing "defaults" to "relatime" didn't help
> either).
> 
> I added strace to the init script trying to remount root read/write:
> 
> Booting linux-5.10.180 using util-linux-2.39 with PR 2248 and PR 2250
> applied: https://0x0.st/HqKL.180.png
> 
> => mount isn't doing anything; root will stay read-only.
> 
> When I use same util-linux but boot linux-5.15.112 instead:
> https://0x0.st/HqK9.112.png
> 
> => mount is doing something; root will become read/write.

I was finally able to reproduce the issue.

Could you test https://github.com/util-linux/util-linux/pull/2248 again?

Thomas
