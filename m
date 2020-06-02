Return-Path: <SRS0=nu2J=7P=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E1DC433DF
	for <util-linux@archiver.kernel.org>; Tue,  2 Jun 2020 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2983B206C3
	for <util-linux@archiver.kernel.org>; Tue,  2 Jun 2020 01:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgFBBwO convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:52:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBBwO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 1 Jun 2020 21:52:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B9B1AC50;
        Tue,  2 Jun 2020 01:52:15 +0000 (UTC)
Subject: Re: [PATCH] blockdev: Don't fail on missing start sector
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
References: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
 <20200601081349.uirtbn2u2bfztnq4@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 xsDiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSM0tU3RhbmlzbGF2
 IEJyYWJlYyA8c3RhbmlzbGF2LmJyYWJlY0BnbWFpbC5jb20+wmwEExECACwCGwMHCwkIBwMC
 AQYVCAIJCgsEFgIDAQIeAQIXgAUJIT9ywAUCUdMF/QIZAQAKCRBxfCCfoE/NdgreAKCEwh0S
 bgGDPUFG9HaToZUp+lkzNACbBSazK57hL2hGrJ5K3PVlEpWVAwHOwE0EPq/ZghAEAK3rY7aV
 eV7YI/HDYul1PnntG+tR2hgnUB4sCfWIPLrusOwa6bEnFbbnjH0IpWxTfrT08bnyAMpJDsK8
 fMSu053P3Gwkt8ILFuTouw6EF0JaBizsdXbFgKRS8pJVAZk33myR+/VpKw7p1fNchJd6fgqp
 jkCcVr6lcMCowlMYvCkbAAMGBACRnb/PP30vbbiw1wWAz7pO4YhDnt82EonFgbYdsGqHegGK
 Jkj3bbh0os0K//ZqhXyp31BQwpAI7uRAqRIfv5OLUqcLJoOLdKh4VyxXhn31dvVs3YQFLULi
 qiE1Rui5OxgQbmqxk965EMp6QVOKKVFFXKJdYO37NjZo00yScoEAJ8JGBBgRAgAGBQI+r9mC
 AAoJEHF8IJ+gT812L60AoKuKuBD3reAs3cOUFGW8U8g5nTVYAKCU3meFjvDLKEiNA/eTh5V8
 Fj5ZXg==
Organization: SUSE Linux, s. r. o.
Message-ID: <8803c12f-98b5-8d63-5408-09b61d736b2a@suse.cz>
Date:   Tue, 2 Jun 2020 03:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601081349.uirtbn2u2bfztnq4@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak wrote:
> On Mon, Jun 01, 2020 at 01:35:44AM +0200, Stanislav Brabec wrote:
>> Device mapper devices don't provide start sector.
> for which type of the device/mapping? I'd like to reproduce this
> issue.
kpartx-style partition on multipath.
>> It causes "blockdev --report" error:
>> blockdev: /dev/dm-9: failed to read partition start from sysfs: No such
>> file or directory
>>
>> There is no reliable way to detect a geometry in this case.
>> Report N/A instead.
> I guess the "start" file missing in the sysfs/ in this case, right?
Yes.

Actually, debugging shows:

sysfs_blkdev_get_wholedisk(): This function has a special code for
device mapper: If /sys/dev/block/{major}:{minor}/partition does not
exist, check for /sys/dev/block/{major}:{minor}/dm/uuid, parse the
result and attempt to check the structure. (Split by "-", check, whether
string starts by "part".) It starts with "part1" => Device mapper is
detected. => Partition is detected.

The code returns to report_device(), and because partition is detected,
it unconditionally attempts to read "start" file from
"/sys/dev/block/254:9". This fails.

>>              if (ul_path_read_u64(pc, &start, "start") != 0)
>> -                err(EXIT_FAILURE,
>> -                    _("%s: failed to read partition start from sysfs"),
>> -                    device);
>> +                /* TRANSLATORS: Start sector not available. Max. 10
>> letters. */
>> +                sprintf(start_str, "%10s", _("N/A"));
>>          }
>>          ul_unref_path(pc);
>>      }
>> +    if (start_str[0] == 0)
>> +        sprintf(start_str, "%10ju", start);
>
> Maybe we ca use ul_path_read_buffer() rather than ul_path_read_u64() to keep 
> it as string and to avoid sprintf().
This was in the original code, but your proposal makes a perfect sense.
%10ju is just a space padded original string.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76


