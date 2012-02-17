Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3.vodafone.ie ([213.233.128.45]:46026 "EHLO
	mail3.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab2BQCxV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 16 Feb 2012 21:53:21 -0500
Message-ID: <4F3DC11E.9040205@draigBrady.com>
Date: Fri, 17 Feb 2012 02:53:18 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Frank Mayhar <fmayhar@google.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve standalone
 operation.
References: <1328648733.11787.13.camel@peace.lax.corp.google.com>  <4F3BBA72.90902@draigBrady.com>  <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>  <4F3BD80B.7090409@draigBrady.com>  <20120215174258.GC15572@x2.net.home> <1329423426.4310.16.camel@peace.lax.corp.google.com>
In-Reply-To: <1329423426.4310.16.camel@peace.lax.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/16/2012 08:17 PM, Frank Mayhar wrote:
> On Wed, 2012-02-15 at 18:42 +0100, Karel Zak wrote:
>> On Wed, Feb 15, 2012 at 04:06:35PM +0000, Pádraig Brady wrote:
>>> On 02/15/2012 03:09 PM, Frank Mayhar wrote:
>>>> 2012/2/15 Pádraig Brady <P@draigbrady.com>:
>>>>> On 02/07/2012 09:05 PM, Frank Mayhar wrote:
>>>>>> This set of patches adds functions that help improve fsck operation in
>>>>>> large installations and when running in unattended or headless mode.  It
>>>>>> adds support for reporting rusage statistics for the individual fsck
>>>>>> runs, for capturing fsck output, for killing fsck runs that take too
>>>>>> long and for running scripts when each fsck completes.
>>>>>>
>>>>>> We're currently using these functions to improve our fsck monitoring
>>>>>> capability and to replace some unwieldy and hard-to-maintain shell
>>>>>> scripts.
>>>>>
>>>>> Couldn't you do this with separate fsck command runs,
>>>>> and use standard system utils?
>>>>
>>>> Yes, of course.  That's where the "unwieldy and hard-to-maintain shell
>>>> scripts" came in.  Putting the functions in the wrapper itself, on the
>>>> other hand, means the scripts don't have to reimplement functions that
>>>> already exist there (like parallelizing the fsck runs or tracking exit
>>
>>  BTW, the latest fsck supports new -l option (lock disk) for parallel
>>  fsck processes. So you can start arbitrary number of
>>
>>     fsck -l /dev/xxx
>>
>>  without care about performance. We use it for systems with systemd
>>  where fsck is executed per device (fstab entry).
>>
>>  If you want to use the same thing for the classic init scripts then 
>>  you can use something like
>>
>>     for x in $(findmnt --fstab -n -o SOURCE); do
>>         fsck -l $x &< /var/log/fsck-$x &
>>     done
>>
>>  rather tan fsck -A. Add some extra checks (completion scripts) to this
>>  for() should be pretty simple.
> 
> I have to disagree with Pádraig's assertion that the functions are
> supported by "quite simple" shell scripting.  As it turned out, doing
> everything we needed involved a script that was pretty long and
> involved.  (I wish I could share the script with you; it's pretty
> impressive, actually, in a grim and painful kind of way, and a real pain
> to maintain.)  In particular, the short loop you show here and that
> Pádraig used was just not even close to being sufficient.

I still don't see how running a script dependent on the
exit code of fsck, is hard or any different to doing so internally.
Could you give a quick summary of the advantages of pulling
this logic into fsck. Scratch that, you do so below...

I see timeouts and completion scripts etc. as generic functionality.
Pulling stuff like that within commands is less unixy (more coupled) IMHO.

> Further, those of us that are stuck using somewhat older distributions
> don't have some of the newer tools such as findmnt and timeout.

Or newer fsck ;)

>>>> status), eliminates some external dependencies and makes the process
>>>> quite a bit less fragile.
>>>
>>> OK, thanks for the clarification.
>>>
>>> It seems to me that these functions are supported
>>> by quite simple shell scripting as I demonstrated.
>>
>>  I have no problem with proposed -r option (to report memory and
>>  runtime statistics) and -O option to force-kill fscks that run too
>>  long.
>>
>>  ... but I'm still not sure if we really need the completion script.
> 
> We have to do special stuff if an fsck fails for a particular file
> system.  Without running each fsck individually (something I want to
> avoid for a number of reasons),

please give a couple as this is a crucial point

> how do you propose we do that "special
> stuff" without some command or script that is run by fsck when an
> individual check fails?  In other words, what do you propose I use
> instead of a completion script if I want to use the existing functions
> of fsck for everything else?
> 
> I'm not trying to be rude, by the way (just in case this is coming off
> that way), I'm just trying to point out that in our case we really need
> the completion script and I would bet that there are others out there
> that would find it very useful as well.

I'm not trying to be obstructive BTW.
It just changes like these require appropriate justification.

cheers,
Pádraig.
