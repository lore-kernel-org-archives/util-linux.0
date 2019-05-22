Return-Path: <SRS0=qI5U=TW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528EDC072A4
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 04:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301E420675
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 04:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfEVE2k (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 May 2019 00:28:40 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:51790 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfEVE2k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 22 May 2019 00:28:40 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id x4M4SVeS072502;
        Tue, 21 May 2019 21:28:33 -0700
Message-ID: <5CE4CFEF.5020100@tlinx.org>
Date:   Tue, 21 May 2019 21:28:31 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net> <20190513090823.2qys6sv4tspbr3b2@ws.net.home> <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net> <20190515114538.bgtfh6rudcyvrmn2@ws.net.home> <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net> <5CE44FA5.9000700@tlinx.org> <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
In-Reply-To: <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2019/05/21 19:59, Ian Kent wrote:
> I hadn't planned on producing a utility but I do have code that I've
> been using to learn how to use the call.
>
> I could turn that into a utility for use from scripts at some point.
>   
---
     not required, but thought it might allow for more types of
tests/usages.
If it is really of limited or no benefit, I'm not gonna lose sleep.
> Avoiding having to parse string output (from the proc file system
> mount tables) is one of the key reasons to use a system call for
> this.
>
> So this isn't the point of doing it.
>   
I get that....this wasn't intended as an 'endpoint' just a way for those
not
implementing and using the calls to get a feel for the call.Â  It may
not serve
a useful purpose in this case, but some system calls have direct
user-utils that
are very useful.Â  The lack of a system util to manipulate the pty calls
forced
me to write a few-line 'C' prog just to make 1 call to approve
something.Â  Eventually switched to a more robust interface in perl.
> The work for this (and some other new system calls) is being done
> in the kernel so the issue isn't to work out what the system call
> returns as much as it is to ensure the system call provides what's
> needed, implement things that aren't yet done and work out ways of
> providing things that are needed but can't yet be provided.
>   
----
  No basic testing that the kernel call is producing exactly what you are
expecting is needed, I take it.
>   
>> 	From there -- those first options could be moved to only 
>> be used with '--raw' or '--direct' switch with a new switch associated
>> with, perhaps another util that may eventually be replaced  with this
>> code that uses the new utility.
>>
>> 	All of that could be done along with a continuing build and
>> release of the older tools until such time as the new call-using
>> tool replaces all of the old tool to whatever standard is wanted.
>>     
>
> I haven't looked at the tools at all.
>
> It may be worth looking at them but fork and exec a program then
> parse text output isn't usually the way these utilities should
> work.
>   
----
  That wasn't what I meant -- just that if you implement functionality in
a test prog, eventually you would be able to library-ize the call for other
purposes.Â  I got the impression th
> The focus is on eliminating the need to read the proc file system
> mount tables including getting the mount information for any single
> mount.
>
> When these tables are large and there's a fair bit of mount/umount
> activity this can be a significant problem.
>
> Getting this information usually means reading on average half of
> the whole mount table every time and it's not possible to get info.
> on a single mount without doing this.
>   
----
    That sounds like a deficiency in the way mount tables are displayed.

Just like you can look at all net-io with a device name in column 0,
there's another directory where each device is a filename entry and by
looking at that
you can just look at the stats of that 1 file.

Block devices have the same type of all-or-single readouts as well.

So why not mounts?

I.e. why not subdirs for 'by-mountpoint', or by-device, or
whole-dev-vs.partition, or by UUID....like some things are listed
in /dev.  That would allow you to narrow in on the mount you want for
doing whatever.

The advantage of putting it in proc is that everyone easily benefits in a
portable, and easy to read interface, where-as binary-interfaces are what
make windows windows, with text interfaces on linux allowing for easy
prototyping and creative usages.

Just this one part -- of wanting a kernel call just to narrow scope
seems like a
perfect reason to add different ways of addressing mounts by different
keywords.



> Ian
>
>   

