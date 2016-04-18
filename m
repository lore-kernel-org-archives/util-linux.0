Return-Path: yumkam@gmail.com
Subject: Re: unshare -m and mount propagation
To: Karel Zak <kzak@redhat.com>
References: <m3oaacfrn2.fsf@gmail.com>
 <20160418111628.cj5bscuuxee2xfcg@ws.net.home> <m3inzfkud2.fsf@gmail.com>
 <20160418122238.o645avvzj2tzzwsd@ws.net.home> <5714DB99.50806@gmail.com>
 <20160418174833.qwb7tnfzuf3wiokw@ws.net.home>
Cc: util-linux@vger.kernel.org
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Message-ID: <57154518.2040700@gmail.com>
Date: Mon, 18 Apr 2016 23:35:36 +0300
MIME-Version: 1.0
In-Reply-To: <20160418174833.qwb7tnfzuf3wiokw@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 18.04.2016 20:48, Karel Zak wrote:
> On Mon, Apr 18, 2016 at 04:05:29PM +0300, Yuriy M. Kaminskiy wrote:
>> On 18.04.2016 15:22, Karel Zak wrote:
>>> On Mon, Apr 18, 2016 at 02:51:37PM +0300, Yuriy M. Kaminskiy wrote:
>>>> Karel Zak <kzak@redhat.com> writes:
>>>>
>>>>> On Fri, Mar 18, 2016 at 05:26:25AM +0300, Yuriy M. Kaminskiy wrote:
>>>>>> I think this issue should be at least documented. And, maybe, default
>>>>>> `--propagation` should be changed to `slave`.
>>>>>
>>>>> The reason why we use 'private' is that it's the kernel default for
>>>>> years and it's what has been expected by users for long time before we
>>>>> introduced --propagation and any unshare(1) default.
>>>>>
>>>>> The current --propagation default unifies things and makes unshare(1)
>>>>> portable to distributions where root fs is mounted as 'shared' (e.g.
>>>>> systemd distros) and all this in backwardly compatible way for users
>>
>> Opposite. It does not change anything for older systems, but breaks things
>> for new systems.
>>
>>>>> who have no clue about --propagation.
>>
>> And it is *especially* harmful for users that are not aware about
>> --propagation. As private (new 2.27+ default) break umount propagation, and
>> results in nasty surprises (up to data loss).
>
> Well, you see only umount propagation...

Because *breaking* it causes real problems?

> The problem is that the original implementation (try emulate by
> "--propagation unchanged") makes "unshare --mount" useless at all on
> systems with shared root fs.
>
> The very old (since year 2009) and very common use-case is:
>
>   # unshare --mount

      mount --make-rslave / # or --make-rprivate or whatever

>   # mount /dev/foo /mnt

And? I've posted how this could be solved *without* changing anything in 
unshare.

> and user expects that /mnt will be visible *only* in the session
> (namespace). This is the way how many users use unshare for years.
>
> Unfortunately, after systemd installation it does not work anymore
> and /mnt is visible everywhere. For users it's regression and it has
> been reported many many times.
>
> You can blame systemd, but the problem is that unshare(1) was not
> robust enough. So we have forced unshare to use "private" by default
> to keep the *original behavior* independently on root fs propagation
> flag.

You can have same effect with *slave* as default, with exception that 
host->guest mount/unmount propagation still works.
When kernel have to get rid of shared propagation (in userns), it 
downgrades shared mounts to *slave*, not to *private*.
When systemd itself downgrades shared propagation (for running service 
in new mount namespace; Protect*/Private*/etc), it also downgrades 
*shared* propagation to *slave*, not to *private*.

P.S. For sure, *any* of propagation variants have some or other 
drawbacks and corner cases; however, without special care about 
removable media (and alike), *private* has higher chance to beat you in 
a nasty way.
