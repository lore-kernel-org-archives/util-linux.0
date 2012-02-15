Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3.vodafone.ie ([213.233.128.45]:26457 "EHLO
	mail3.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2BOQGj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Feb 2012 11:06:39 -0500
Message-ID: <4F3BD80B.7090409@draigBrady.com>
Date: Wed, 15 Feb 2012 16:06:35 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Frank Mayhar <fmayhar@google.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve standalone
 operation.
References: <1328648733.11787.13.camel@peace.lax.corp.google.com> <4F3BBA72.90902@draigBrady.com> <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>
In-Reply-To: <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/15/2012 03:09 PM, Frank Mayhar wrote:
> 2012/2/15 Pádraig Brady <P@draigbrady.com>:
>> On 02/07/2012 09:05 PM, Frank Mayhar wrote:
>>> This set of patches adds functions that help improve fsck operation in
>>> large installations and when running in unattended or headless mode.  It
>>> adds support for reporting rusage statistics for the individual fsck
>>> runs, for capturing fsck output, for killing fsck runs that take too
>>> long and for running scripts when each fsck completes.
>>>
>>> We're currently using these functions to improve our fsck monitoring
>>> capability and to replace some unwieldy and hard-to-maintain shell
>>> scripts.
>>
>> Couldn't you do this with separate fsck command runs,
>> and use standard system utils?
> 
> Yes, of course.  That's where the "unwieldy and hard-to-maintain shell
> scripts" came in.  Putting the functions in the wrapper itself, on the
> other hand, means the scripts don't have to reimplement functions that
> already exist there (like parallelizing the fsck runs or tracking exit
> status), eliminates some external dependencies and makes the process
> quite a bit less fragile.

OK, thanks for the clarification.

It seems to me that these functions are supported
by quite simple shell scripting as I demonstrated.
I do agree it's a margin call, but I'd be on the
side of not bringing that logic within fsck.

cheers,
Pádraig.
