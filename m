Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF352C77B7F
	for <util-linux@archiver.kernel.org>; Sat, 20 May 2023 04:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjETEve (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 20 May 2023 00:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETEvd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 20 May 2023 00:51:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50989E40
        for <util-linux@vger.kernel.org>; Fri, 19 May 2023 21:51:32 -0700 (PDT)
Date:   Sat, 20 May 2023 06:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684558289; bh=FLIAeYDUVGLbaimzKZROTNnVAANA034ObUwiuBT8fqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH5i9VgBIdi0OMQoqmOZuhzEWZcaNllO1DuYmtgqvaBsjWpFv9Cc28ZCWH8HyPeZn
         qzYhVVyUcocTUN+hNcThSG9j41GkNGpQhRKJAkV33x+bj+apGMxNqaInOiFNojp6dk
         zsle8YXQ28BarI44XYmgJ0/QBWiA71dNcnaOaYkc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Thomas Deutschmann <whissi@whissi.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
Message-ID: <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Thomas,

On 2023-05-20 02:54:23+0200, Thomas Deutschmann wrote:
> Hi,
> 
> I didn't find a kernel requirement in latest util-linux 2.39 release notes
> and because a fallback is mentioned I gave it a try on a system running
> latest LTS kernel 5.10.180.
> 
> After updating to util=linux 2.39 system immediately failed when trying to
> use mount command.
> 
> I.e.
> 
>   mount --make-slave /proc
> 
> failed with:
> 
> > mount: /proc: mount(2) system call failed: Function not implemented.
> >        dmesg(1) may have more information after failed mount system call.
> 
> Nothing in dmesg about it.
> 
> 
> strace shows
> 
> > mount_setattr(3, "", AT_EMPTY_PATH, {attr_set=0, attr_clr=0, propagation=MS_SLAVE, userns_fd=0}, 32) = -1 ENOSYS (Function not implemented)

Thanks for the report!

There is also a ticket about this here:
https://github.com/util-linux/util-linux/issues/2247 .

> Configure output shows
> 
> > checking for syscall mount_setattr... SYS_mount_setattr
> 
> But this is coming from Linux headers (I have most recent Linux headers from
> kernel 6.3 installed).
> 
> Not sure if this is the problem but using most recent Linux headers with
> older kernel shouldn't be a problem in general according to https://sourceware.org/glibc/wiki/FAQ#What_version_of_the_Linux_kernel_headers_should_be_used.3F

Please note that this is a document about glibc, not util-linux.
Nevertheless the same concept also applies to util-linux.

> Booting a newer kernel (I tried 5.15.112) helped (I guess because the system
> call was added in 5.12).

Could you test the fix proposed in 
https://github.com/util-linux/util-linux/pull/2248 ?

(For testing on a real system you only need the changes to
libmount/src/hook_mount.c, ignore the testing stuff)

Thomas
