Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp5-g21.free.fr ([212.27.42.5]:58568 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526Ab2FGJsa (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 7 Jun 2012 05:48:30 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A4F5DD480B3
	for <util-linux-ng@vger.kernel.org>; Thu,  7 Jun 2012 11:48:23 +0200 (CEST)
From: Jim Meyering <jim@meyering.net>
To: Allan McRae <allan@archlinux.org>
Cc: coreutils@gnu.org, List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: su, going, going, ...
In-Reply-To: <4FCFDAF8.6020508@archlinux.org> (Allan McRae's message of "Thu,
	07 Jun 2012 08:34:32 +1000")
References: <8762b55w3m.fsf@rho.meyering.net>
	<87396818jo.fsf@rho.meyering.net> <4FCFDAF8.6020508@archlinux.org>
Date: Thu, 07 Jun 2012 11:48:21 +0200
Message-ID: <87vcj3wize.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Allan McRae wrote:
> On 07/06/12 06:37, Jim Meyering wrote:
>> Jim Meyering wrote:
>>> No one objected, so I'm about to remove su, with this:
>>> (I'll wait 10-12 hours, just in case ;-)
>>>
>>> >From db2c12039e5b008245b33778d28e6d9ab1156844 Mon Sep 17 00:00:00 2001
>>> From: Jim Meyering <meyering@redhat.com>
>>> Date: Fri, 25 May 2012 18:10:25 +0200
>>> Subject: [PATCH] su: remove program (util-linux is now the best source for
>>>  it)
>>>
>>> * README: Omit "su" from list of programs.
>>> * src/su.c: Remove file.
>>> * src/Makefile.am: Remove su-related rules and variables.
>>> * tests/misc/su-fail: Remove test.
>>> * tests/Makefile.am (TESTS): Remove misc/su-fail.
>>> * tests/misc/invalid-opt: Remove su-related code.
>>> * src/.gitignore: Remove su.
>>> * man/su.x: Remove file.
>>> * man/Makefile.am (su.1): Remove rule.
>>> * po/POTFILES.in: Remove su.c from the list.
>>> * TODO: Remove ancient entry.
>>> * NEWS (Changes in behavior): Mention it.
>>> * doc/coreutils.texi: Remove su-related description.
>>> * AUTHORS: Remove su.
>>> * m4/lib-check.m4 (cu_LIB_CHECK): Remove file/macro.
>>> * configure.ac: Remove su-related code and sole use of cu_LIB_CHECK.
>>> * scripts/git-hooks/commit-msg: Remove su from this list, too.
>>
>> Pushed, finally.
>>
>
> Good to see, but....  It is my understanding that there is not a
> released version of util-linux with su in it, and I do not see details
> of a release on the horizon.
>
> Is there going to be a hold on coreutils releases until an appropriate
> version of util-linux is released, or could we end up with the latest
> release of both packages not providing su?

I hadn't realized that -- nor that it might cause a problem,
as your message implies.  I've Cc'd the util-linux list.
Let's see if/when the next release is planned.
