Return-Path: <SRS0=8nCy=M6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D95C67863
	for <util-linux@archiver.kernel.org>; Thu, 18 Oct 2018 19:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F0F21479
	for <util-linux@archiver.kernel.org>; Thu, 18 Oct 2018 19:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeJSD2D (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:28:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbeJSD2D (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Oct 2018 23:28:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A59DAD86;
        Thu, 18 Oct 2018 19:25:34 +0000 (UTC)
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
To:     Karel Zak <kzak@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>
Cc:     util-linux@vger.kernel.org
References: <20181016064149.2698-1-lkundrak@v3.sk>
 <20181016074053.dea6ydle26y37uva@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Openpgp: preference=signencrypt
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
 AAoJEHF8IJ+gT812L60An3nw69B52AbSCxEbXBf8cpeZFnR3AJ9STQXip4/l0KIRMgeHeDE0
 izHxhA==
Organization: SUSE Linux, s. r. o.
Message-ID: <9313c880-265c-908a-6138-c8f24d6c434e@suse.cz>
Date:   Thu, 18 Oct 2018 21:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016074053.dea6ydle26y37uva@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Oct 16, 2018 at 9:40 AM Karel Zak wrote:
> On Tue, Oct 16, 2018 at 08:41:49AM +0200, Lubomir Rintel wrote:
>> Seems like zero lflags do the job just fine on a Linux VT. Reset it to
>> canonical mode before running login.
> 
> What about Del/Backspace keys when user is typing login name? :-)

It could be easy without Backspace support. Just read the characters.
But we have to implement Backspace.

When you leave canonical mode, then agetty code has to handle Backspace.

Hopefully, agetty doesn't support arrows and Delete (forward delete),
so we don't have to implement advanced parts of line editing.

My experiments show two possibilities. I am not sure, what is better,
but 1 seems to be more straightforward.


1) c_lflag &= ~(ICANON | ECHO)

This falls back to a no echo mode. Program has to handle echo and
buffer parsing. Program has to handle backspace.

The implementation seems to be straightforward.

Downside: Remote logins can experience delays when getting echo.


2) c_lflag &= ~(ICANON)

Non-canonical mode with echo seems to be usable as well. The terminal
itself does the echo, program does the input parsing. Program has to
handle Backspace. Echo will be immediate even with slow remote logins,
but Backspace has to be handled remotely.

The second implementation has a problem: The Linux console input and
output are out of sync in the time of agetty. Input returns 0x7f after
pressing backspace, but output does back step (not back space) after
sending 0x08. I don't know the fix yet.

Even with a proper configuration of erase character, terminal
in a non-canonical mode cannot do a back space. At the best, it will
do back step.

So, in the echo mode, program has to handle Backspace not only for
the input, but also for the output: Print a space to erase the deleted
character and then one back step again.

This approach is vulnerable to race: New letter is typed before
processing of backspace is not finished yet. But if I am correct, this
race will not affect the result on the screen.


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
