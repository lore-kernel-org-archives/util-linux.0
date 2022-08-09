Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B2C19F2D
	for <util-linux@archiver.kernel.org>; Tue,  9 Aug 2022 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiHIWAe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHIWAN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Aug 2022 18:00:13 -0400
Received: from toro.web-alm.net (toro.web-alm.net [62.245.132.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62F409A
        for <util-linux@vger.kernel.org>; Tue,  9 Aug 2022 15:00:11 -0700 (PDT)
Received: from toro.web-alm.net (localhost.localdomain [127.0.0.1])
        by toro.web-alm.net (8.12.11.20060308/8.12.11/Web-Alm-2003112001) with ESMTP id 279M07cX019630;
        Wed, 10 Aug 2022 00:00:07 +0200
Received: from rack3slot8.osadl.org (uucp@localhost)
        by toro.web-alm.net (8.12.11.20060308/8.12.10/Submit/Web-Alm-2003112001) with bsmtp id 279M07S1019628;
        Wed, 10 Aug 2022 00:00:07 +0200
Received: from localhost.localdomain (thlfw2.ceag.ch [192.168.255.120])
        by rack3slot8.osadl.org (8.13.8/8.13.8/CE-2010120801) with ESMTP id 279LsSLM017436;
        Tue, 9 Aug 2022 23:54:28 +0200
Subject: Re: [PATCH v2 1/1] Taskset: check first whether affinity is settable
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220806224915.326517265@osadl.org>
 <20220806225421.221956570@osadl.org>
 <20220808133526.k4i5elxhqe66sghm@ws.net.home>
From:   Carsten Emde <C.Emde@osadl.org>
Message-ID: <25130ef1-6328-8a4f-3af3-a25d28f9a839@osadl.org>
Date:   Tue, 9 Aug 2022 23:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20220808133526.k4i5elxhqe66sghm@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on rack3slot8.osadl.org
X-Virus-Status: Clean
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

On 8/8/22 3:35 PM, Karel Zak wrote:
> On Sun, Aug 07, 2022 at 12:49:16AM +0200, Carsten Emde wrote:
>> If the PF_NO_SETAFFINITY process flag is set, the user may not
>> know why the affinity is not settable. Write a respective message
>> and do not attempt to set the affinity of this process.
> 
> I'm unsure if constantly checking for the flag rather than calling
> sched_setaffinity() is the right way. It seems pretty expensive.
> 
> I don't like when userspace tries to predict any kernel policy or
> behavior. It seems better to call the syscall and, if necessary,
> compose a better (detailed) error message.
Good point.

> What about the patch below? (I have moved /proc/#/stat parsing to
> lib/procfs.c to keep tastset.c more readable.)
Indeed, that is much better, thanks a lot!

Applied your patch and tested it successfully, you may add my
Tested-by: Carsten Emde <C.Emde@osadl.org>
if you wish.

Thanks again!
Carsten
