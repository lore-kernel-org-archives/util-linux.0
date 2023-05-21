Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA3C77B7C
	for <util-linux@archiver.kernel.org>; Sun, 21 May 2023 22:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjEUWNW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 May 2023 18:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUWNV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 May 2023 18:13:21 -0400
X-Greylist: delayed 163126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 15:13:20 PDT
Received: from yamato.tf-network.de (yamato.tf-network.de [93.186.202.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D7DD
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 15:13:20 -0700 (PDT)
Received: from amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221])
        by yamato.tf-network.de (Postfix) with ESMTP id 4QPZbK6s8jz3xVc
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 00:13:17 +0200 (CEST)
X-Virus-Scanned: amavis at amavis3.tf-network.de
Received: from smtp.tf-network.de ([93.186.202.221])
 by amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221]) (amavis, port 10024)
 with LMTP id NoKgb36vjCUw for <util-linux@vger.kernel.org>;
 Mon, 22 May 2023 00:13:16 +0200 (CEST)
Received: from [IPV6:2a0a:a546:931a:0:b58f:23e3:2f77:f6a9] (2a0a-a546-931a-0-b58f-23e3-2f77-f6a9.ipv6dyn.netcologne.de [IPv6:2a0a:a546:931a:0:b58f:23e3:2f77:f6a9])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by securesmtp.tf-network.de (Postfix) with ESMTPSA id 4QPZbJ68K4z3wZ9
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 00:13:16 +0200 (CEST)
Message-ID: <089b028f-7ccb-5389-4ba0-06830f27e738@whissi.de>
Date:   Mon, 22 May 2023 00:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
To:     util-linux@vger.kernel.org
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
 <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
 <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
Content-Language: en-US
From:   Thomas Deutschmann <whissi@whissi.de>
In-Reply-To: <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi

On 2023-05-21 01:39, Thomas Weißschuh wrote:
> I am having trouble reproducing the issue.
> 
> Could you
> * provide more details about the used kernel?
> * provide reproduction steps that are simple to reproduce, for example
>    using tmpfs mounts.

Used kernel.config: https://0x0.st/HqKc.txt

I cannot reproduce using tmpfs, i.e.

   # mkdir /mnt/test
   # mount -t tmpfs none /mnt/test
   # mount -l | grep test
   none on /mnt/test type tmpfs (rw,relatime)
   # touch /mnt/test/foo.txt
   # mount -o remount,ro /mnt/test
   # date >> /mnt/test/foo.txt
   -bash: /mnt/test/foo.txt: Read-only file system
   # mount -o remount,rw /mnt/test
   # date >> /mnt/test/foo.txt
   # cat /mnt/test/foo.txt
   Sun May 21 11:04:42 PM CEST 2023

works.

But on boot, when the init system remounts root filesystem (using 
command "mount -n -o remount,rw /"), the command seems to be successful 
(mount command exits with zero exit code) but the root filesystem is 
still read-only and all following services expecting writable rootfs 
will fail.

I have

   UUID=e290359f-8335-4fba-9fae-077b3505e0b2 / ext4 defaults 0 1

in /etc/fstab. I saw https://github.com/util-linux/util-linux/pull/2250 
but this doesn't help (and changing "defaults" to "relatime" didn't help 
either).

I added strace to the init script trying to remount root read/write:

Booting linux-5.10.180 using util-linux-2.39 with PR 2248 and PR 2250 
applied: https://0x0.st/HqKL.180.png

=> mount isn't doing anything; root will stay read-only.

When I use same util-linux but boot linux-5.15.112 instead: 
https://0x0.st/HqK9.112.png

=> mount is doing something; root will become read/write.


-- 
Regards,
Thomas
