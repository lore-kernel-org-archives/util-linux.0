Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48164 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776AbcCNOTR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 10:19:17 -0400
Subject: Re: [PATCH] tests: add btrfs mount tests
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <56B0EEB2.1060707@suse.cz> <201603140220.47345.sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56E6C863.2070909@suse.cz>
Date: Mon, 14 Mar 2016 15:19:15 +0100
MIME-Version: 1.0
In-Reply-To: <201603140220.47345.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mar 14, 2016 at 02:20 Ruediger Meier wrote:
> On Tuesday 02 February 2016, Stanislav Brabec wrote:
> IMO this test needs some more error handling, see below.
>
>> +btrfs subvol create s2 >/dev/null
>
> For example if you comment out above line (or if it would fail) then
> all subtests below still succeed. This can't be right.

Well, it is a test suite for mount, not btrfs. I did not add any error 
checks in the code that creates the testing image.

Grepping through the whole test suite, I see that more than a half of 
all tests do not check for mkfs failure. Here we just have a multi-line 
mkfs.

It is possible to add a check for every command there, and fail the test 
if the command fails or returns something unexpected.

>> +NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT-create" |

NON_DEFAULT_SUBVOLID will be empty.

>> "subvolid=$NON_DEFAULT_SUBVOLID" +

I am not sure how kernel will interpret subvolid=.

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
