Return-Path: <SRS0=m+KL=TV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CDC04AAF
	for <util-linux@archiver.kernel.org>; Tue, 21 May 2019 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6E21479
	for <util-linux@archiver.kernel.org>; Tue, 21 May 2019 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfEUTpT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 May 2019 15:45:19 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:59448 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfEUTpS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 May 2019 15:45:18 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 15:45:18 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id x4LJL8qE038567;
        Tue, 21 May 2019 12:21:11 -0700
Message-ID: <5CE44FA5.9000700@tlinx.org>
Date:   Tue, 21 May 2019 12:21:09 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Ian Kent <raven@themaw.net>
CC:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net> <20190513090823.2qys6sv4tspbr3b2@ws.net.home> <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net> <20190515114538.bgtfh6rudcyvrmn2@ws.net.home> <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
In-Reply-To: <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2019/05/15 17:13, Ian Kent wrote:
> And, as I mentioned above, there's the needed ->fsinfo() super operation
> to cover the use of the existing ->show_options() operation (provided
> by pretty much all file systems) to get the file system specific options.
>
> So there's quite a bit of detail to be worked out for fsinfo() to be
> able to correctly provide all mount information.
>
> But, hey, that was the point of doing this now.
>   
----
	Maybe this is already planned behind the scenes, but I wanted to
throw out my own suggestion -- and that is to start with the new 
system call usage in its own cmdline tool that can be used just to call
or exercise the new call -- effectively allowing calling the new kernel call
from any shell based program -- allowing for a passthrough type operation.

	This serves to workout that the call always returns what you 
expect it to, familiarity with the new call and how it works as well as
developing a first interface to construct and parse calls-to and 
output-from the call.

	From there -- those first options could be moved to only 
be used with '--raw' or '--direct' switch with a new switch associated
with, perhaps another util that may eventually be replaced  with this
code that uses the new utility.

	All of that could be done along with a continuing build and
release of the older tools until such time as the new call-using
tool replaces all of the old tool to whatever standard is wanted.

	That way, it could allow not disturbing old code
while code is developed for using the new interface, allowing for
a seamless switch sometime later with the old progs being left around
for a release with some 'old' prefix and eventually not built by default
and moved to the project's "attic" later on.

	This can allow for an extended period of feedback & development
until all users are comfy w/the new tool (which might, in some cases,
have an option to generate the same output as the old tool (but using
the new call) for older scripts that might be less easy to update.

Anyway, just my general caution in code rewrites replacing old libs & utils.
And again, please forgive my saying something that may be self-evident,
standard procedure, or already planned, but just not detailed on list.


-linda


