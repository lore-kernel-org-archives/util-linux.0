Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC775C433F5
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhLNKfY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhLNKfX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Dec 2021 05:35:23 -0500
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Dec 2021 02:35:23 PST
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6ADC061574
        for <util-linux@vger.kernel.org>; Tue, 14 Dec 2021 02:35:23 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 5368B124D1;
        Tue, 14 Dec 2021 11:29:13 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-238-153.nc.de [89.0.238.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id A2D2811DC3;
        Tue, 14 Dec 2021 11:29:06 +0100 (CET)
Received: from [192.168.155.202] (unknown [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 1446BB3B0027;
        Tue, 14 Dec 2021 11:29:06 +0100 (CET)
Message-ID: <2752f06e-1248-26c1-eb94-8d6d31fad918@garloff.de>
Date:   Tue, 14 Dec 2021 11:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] libblkid: don't use O_NONBLOCK for floppy
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>,
        Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, kzak@redhat.com, den@openvz.org,
        msuchanek@suse.de, efremov@linux.com
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <nycvar.YFH.7.76.2112141123570.16505@cbobk.fhfr.pm>
From:   Kurt Garloff <kurt@garloff.de>
In-Reply-To: <nycvar.YFH.7.76.2112141123570.16505@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: A2D2811DC3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

On 14/12/2021 11:25, Jiri Kosina wrote:
> On Thu, 9 Dec 2021, Vladimir Sementsov-Ogievskiy wrote:
>
>> Good day everyone!
>>
>> The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
>> so we faced the bug described and discussed here:
>> https://bugzilla.suse.com/show_bug.cgi?id=1181018
>>
>> Discussion in kernel list on reverting the commit:
>> https://www.spinics.net/lists/stable/msg493061.html
>>
>> In short, I can quote Jiri Kosina's comment:
>>
>>     opening floppy device node with O_NONBLOCK is asking for all kinds
>>     of trouble
>>
>> So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
>> probable failure of mount and unpleasant error messages in dmesg (see
>> also patch 02 for details).
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    libblkid: introduce blkid_safe_open
>>    libblkid: reopen floppy without O_NONBLOCK
> Ah, thanks, finally someone found the motivation to look into what it'd
> take to fix this properly in libblkid. FWIW,
>
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
>
> for the changes.

As the one who was affected by the issue (having some old scripts that
use floppy images to inject metadata as data source for cloud-init
instead of CD-Rom images), I definitely appreciate this being taken
care of. Thank you!

Changes look good to me, but I guess best would be to test things.
Let me know if you need me to do this ...

Best,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

