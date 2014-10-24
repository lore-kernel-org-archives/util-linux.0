Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62017 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbaJXQID (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 12:08:03 -0400
Message-ID: <544A795B.8090301@gmx.com>
Date: Fri, 24 Oct 2014 12:07:55 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
References: <5449BE57.9040203@gmx.com> <1414150431.840372.182833341.74402120@webmail.messagingengine.com> <544A4817.3070406@gmx.com> <20141024125939.GD10134@x2.net.home>
In-Reply-To: <20141024125939.GD10134@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 10/24/2014 08:59 AM, Karel Zak wrote:
> On Fri, Oct 24, 2014 at 08:37:43AM -0400, JWP wrote:
>> My sincere oligopolies to translators, but hwclock is slated for refactoring
>> and I expect many message changes will be included.  Hopefully, the changes
>> will include improving things for translators.
> 
> If you really plan to do the refactoring then don't care about
> messages at all. The result will be completely different code (I
> hope:-). But what we need to to merge all the changes by one pull 
> request.

oligopolies? How did I do that... sincere apologizes! 

Ah, I misunderstood when you wrote:

"I prefer refactoring if possible than write things from scratch. And
for hwclock it's really critical to do the changes in small testable
steps."

I thought you wanted all the small steps submitted and tested in progress.

The intention of this patch set was a first step in making the output cleaner 
and easier to read for testing the 'small steps'.  It's quite ugly as is.

So what is the util-linux position on message punctuation in general, and
line termination specifically?  The documentation seem to imply not using any.
 
> Note that the best is to start with date types, try to describe
> hwclock by structs (hwclock_control, hwclock_adjtime, hwclock_hwops,
> etc.), then write small functions that work with the structs and then
> high level logic. See for example cfdisk.c, losetup.c, name.c...

Will do.

> 
>     Karel
> 
