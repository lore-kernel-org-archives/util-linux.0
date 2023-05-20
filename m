Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A31DC77B75
	for <util-linux@archiver.kernel.org>; Sat, 20 May 2023 01:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjETBCZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 May 2023 21:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETBCY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 May 2023 21:02:24 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 18:02:23 PDT
Received: from yamato.tf-network.de (mailstorage3.tf-network.de [IPv6:2001:4ba0:ffa0:1b::d2:221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5B1A4
        for <util-linux@vger.kernel.org>; Fri, 19 May 2023 18:02:23 -0700 (PDT)
Received: from amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221])
        by yamato.tf-network.de (Postfix) with ESMTP id 4QNQG82Rgxz444r
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 02:54:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis3.tf-network.de
Received: from smtp.tf-network.de ([93.186.202.221])
        by amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221]) (amavisd-new, port 10024)
        with LMTP id 8RxwHIM-1IK8 for <util-linux@vger.kernel.org>;
        Sat, 20 May 2023 02:54:23 +0200 (CEST)
Received: from [IPV6:2a0a:a546:70f9:0:6de7:3c80:6f6d:406a] (2a0a-a546-70f9-0-6de7-3c80-6f6d-406a.ipv6dyn.netcologne.de [IPv6:2a0a:a546:70f9:0:6de7:3c80:6f6d:406a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by securesmtp.tf-network.de (Postfix) with ESMTPSA id 4QNQG75K52z442M
        for <util-linux@vger.kernel.org>; Sat, 20 May 2023 02:54:23 +0200 (CEST)
Message-ID: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
Date:   Sat, 20 May 2023 02:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Thomas Deutschmann <whissi@whissi.de>
To:     util-linux@vger.kernel.org
Subject: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system call
 failed: Function not implemented
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I didn't find a kernel requirement in latest util-linux 2.39 release 
notes and because a fallback is mentioned I gave it a try on a system 
running latest LTS kernel 5.10.180.

After updating to util=linux 2.39 system immediately failed when trying 
to use mount command.

I.e.

   mount --make-slave /proc

failed with:

> mount: /proc: mount(2) system call failed: Function not implemented.
>        dmesg(1) may have more information after failed mount system call.

Nothing in dmesg about it.


strace shows

> mount_setattr(3, "", AT_EMPTY_PATH, {attr_set=0, attr_clr=0, propagation=MS_SLAVE, userns_fd=0}, 32) = -1 ENOSYS (Function not implemented)


Configure output shows

> checking for syscall mount_setattr... SYS_mount_setattr

But this is coming from Linux headers (I have most recent Linux headers 
from kernel 6.3 installed).

Not sure if this is the problem but using most recent Linux headers with 
older kernel shouldn't be a problem in general according to 
https://sourceware.org/glibc/wiki/FAQ#What_version_of_the_Linux_kernel_headers_should_be_used.3F

Booting a newer kernel (I tried 5.15.112) helped (I guess because the 
system call was added in 5.12).

Thanks!


-- 
Regards,
Thomas
