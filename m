Return-Path: <SRS0=rvHk=RP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1704C43381
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B12075C
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 15:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCLPCi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:02:38 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:34426 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPCh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Mar 2019 11:02:37 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id x2CF2SkD071318;
        Tue, 12 Mar 2019 08:02:31 -0700
Message-ID: <5C87CA04.1010308@tlinx.org>
Date:   Tue, 12 Mar 2019 08:02:28 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        util-linux@vger.kernel.org
Subject: Re: does util-linux have a 'report sector size' util?
References: <5C86CBA1.40802@tlinx.org> <20190311212104.edekhgctqto37tn7@gallifrey> <5C86D476.6060807@tlinx.org> <20190312082159.jojrjq7ox3d457ke@ws.net.home>
In-Reply-To: <20190312082159.jojrjq7ox3d457ke@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 3/12/2019 1:21 AM, Karel Zak wrote:
> On Mon, Mar 11, 2019 at 02:34:46PM -0700, L A Walsh wrote:
>   
>> On 3/11/2019 2:21 PM, Dr. David Alan Gilbert wrote:
>>     
>>> * L A Walsh (lkml@tlinx.org) wrote:
>>>       
>>>> Trying to track down why my 4K drives no longer display 4K
>>>> in sysfs (/sys) and don't seem to show individual disk
>>>> drive information.  When I first got the drives, linux displayed
>>>> the correct physical disk size, but when I look now, I only
>>>> see 512.
>>>>         
>>> Is this one of the PHY-SEC or LOG-SEC fields that lsblk can print?
>>>
>>> [dg@major ~]$ lsblk -o "NAME,PHY-SEC,LOG-SEC"
>>> NAME                                            PHY-SEC LOG-SEC
>>> sda                                                 512     512
>>>       
>> ---
>>     It would be, if it was correct.  Megacli displays:
>>
>>    Sector Size:  512
>>    Logical Sector Size:  512
>>    Physical Sector Size:  4096
>>
>> But lsblk displays 512 for everything.  The disk says it uses a 512e format
>> with the 'e' meaning it emulates 512 even if not 512.
>>     
>
> lsblk, fdisk, blockdev, ... but all of the utils read the information
> from kernel. So, it depends how the device reports topology to the
> kernel.
>   
Well, that's what I would think but I can't see why the device driver
would have been purposely changed to hide the actual physical size or
the temperature.  That said, megacli has to be reading those values
from somewhere -- and I'd tend to think it was accessing the driver as
well, but that begs the question -- where is it getting the temperature
and physical size from>?

It can even read the serial numbers off the disks.

I'm not sure if it is opensource or not.
*sigh*

>     Karel
>
>   

