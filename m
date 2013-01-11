Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:45501 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3AKWL7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Jan 2013 17:11:59 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
Date: Fri, 11 Jan 2013 14:11:47 -0800
In-Reply-To: <20130111161320.GA16206@x2.net.home> (Karel Zak's message of
	"Fri, 11 Jan 2013 17:13:20 +0100")
Message-ID: <87ehhrnzdo.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] enter: new command (light wrapper around setns)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Fri, Jan 11, 2013 at 02:29:24AM -0800, Eric W. Biederman wrote:
>> 
>> Inspired by unshare, enter is a simple wrapper around setns that
>> allows running a new process in the context of an existing process.
>
>  It would be really nice to have "ns" in the name -- for example
>  "enterns" sounds good.

enterns might work.  I am still trying to reconcile that name with
changing the working directory and the root directory.  Those really
aren't namespaces.

But name slightly less generic seems to be the popular vote.  Short of
something better my vote is for nsenter.  enterns sounds way too much
like interns which has a rather different meaning.

>> While doing a final check on this patch I just realized I am a week or
>> two late to the discussion.
>
>  Yep :-)
>
>> Little things like retaining the the ability for unshare to be suid root
>> safely and sanely become intractable if you call setns() and join a
>> user namespace.  
>
>  Do you have any example (use case) with suid unshare(1)? 

No.  Mostly I know that someone added support to unshare for being
run suid, and changing the uids and gids back.

I hope my recent changes to the user namespace allowing unshare to
create user namespaces unprivielged and to create other namespaces with
only privilege in the user namespace to be sufficient.

>> Supporting the ability for the command to be setuid root does not
>> work in combination with the user namespace.  As after entering
>> the user namespace you can not reliably change your uid back to
>> your uid without setuid as your uid may not be mapped.
>> 
>> When joining an existing mount namespace you most likely want to change
>> your root directory and your working directory to the directory of the
>> process whoose mount namespace you are entering.  Something you don't
>> even think about when just unsharing a mount namespace.
>> 
>> Then there is the practical wish to call fork after entering a pid
>> namespace and before launching a command.  You don't always want that
>> but almost always so that the command will actually be run in the new
>> pid namespace with a new pid, instead of having it's children in the new
>> pid namespace.
>> 
>> I really can't see support for using setns being in the same binary as
>> unshare that just mixes two different but closely related things that
>> will want to evolve in different directions.
>> 
>> My inclination is to send a follow up patch to remove setns and migrate
>> from unshare. 
>
>  unnecessary, "git revert" works fine :-)
>
>> And a second patch to add pid and user namespace support
>> to unshare.  But since I am going against the way that seems to have
>> already been decided I will hold off on those patches until after we
>> there is agreement on this one.
>
>  well, the decision has been based on little different context. 

Yes.

>  I have no problem to revert the change if there is a real use case 
>  with suid and if the setns() goals will be incompatible with the 
>  way how people use unshare(1) command.

So I don't know about the suid case.  So that might be worth some
discussion.  Looking closer I don't actually think unsharing the user
namespace is compatible with a suid /usr/sbin/unshare.

If suid handling is removed from the discussion I don't see any
fundamental incompatibility between unshare and nsenter.  At the same
time I don't see any shared code between the two pieces of code either.
Nor do I see any ordering requirements that would need unshare and setns
to be called in the same binary.

So in net I really think we will have simpler more robust code by
leaving the two binaries separate.  Especially since unshare and nsenter
are the raw shell utilities you drag out to debug something or to build
things of when you don't need a sophisticated user space wrapper.

Except for debugging I expect most of the usage is going to be something
like:
nsexec -t $(pidof foo) -muinpUrw /bin/bash -e "cmd"

Anyway I will respin my patch with the name changed from enter to
nsenter and see where we can go from there.

Eric

