Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38744 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbcBLPzu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 10:55:50 -0500
Subject: Re: [PATCH] tests: add test for loop option in fstab
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <56BCE4F4.6020409@suse.cz> <201602121628.19968.sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BE0085.1090004@suse.cz>
Date: Fri, 12 Feb 2016 16:55:49 +0100
MIME-Version: 1.0
In-Reply-To: <201602121628.19968.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier wrote:
> On Thursday 11 February 2016, Stanislav Brabec wrote:
>> Add a new fstab tests which check loop mount of the same source
>> multiple times in multiple steps.
>>
>> The test is currently failing, but it should not fail once the
>> triggering bug will be fixed.
>
> Will this be fixed quickly? Otherwise we should add
>    TS_KNOWN_FAIL="yes"
> to the test. Then you would still see it in the build log and test diff
> but it wouldn't bother you with build error.

This statement was valid in the time of sending the patch. Karel 
promptly fixed it, so the fix appeared in the main tree even one commit 
earlier:
https://git.kernel.org/cgit/utils/util-linux/util-linux.git/commit/?id=d58b9706ed8a10cc484835119ed10385d141eb6c


But there is a chance, that some tests were broken (or fixed) by
https://git.kernel.org/cgit/utils/util-linux/util-linux.git/commit/?id=b59c3bf292269be1a203f91563b961e0062e0a5f

Fix would consist of:

If there is any _expected_ message in stderr, add it to expected/.

If there is any _unexpected_ message in stderr, it means, that the test 
falsely succeeded in past.


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
