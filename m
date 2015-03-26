Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.aswsp.com ([193.34.35.150]:40236 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbbCZNH3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Mar 2015 09:07:29 -0400
Message-ID: <5514049D.3060301@parrot.com>
Date: Thu, 26 Mar 2015 14:07:41 +0100
From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
MIME-Version: 1.0
To: Peter Cordes <peter@cordes.ca>
CC: Karel Zak <kzak@redhat.com>, <util-linux@vger.kernel.org>,
        matthieu CASTET <matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden
 power off
References: <550BF3A9.8080508@parrot.com> <20150320111812.GG28925@ws.net.home> <20150323183142.GU3933@cordes.ca> <55116F30.3080204@parrot.com> <20150324142515.GW3933@cordes.ca>
In-Reply-To: <20150324142515.GW3933@cordes.ca>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/24/2015 03:25 PM, Peter Cordes wrote:
> On Tue, Mar 24, 2015 at 03:05:36PM +0100, Ronan CHAUVIN wrote:
>> On 03/23/2015 07:31 PM, Peter Cordes wrote:
>>> On Fri, Mar 20, 2015 at 12:18:12PM +0100, Karel Zak wrote:
>>>> Conclusion: be pessimistic and verify all you read from disk and be
>>>> optimistic when you write to the disk, and when when someone is talking
>>>> about write guaranty and run far away. That's all the story.
>>> The whole GPT is what, 16kiB or so?  On most storage, you could
>>> force data to persistent storage with a granularity of 4kiB, with
>>> fdatasync(2) (assuming that works on block devices, not just files).
>> The whole GPT is 16kiB (MBR+GPT header+partition array). There is two
>> GPT systems, one at the beginning and another one at the end. The
>> bootloader verifies the integrity of the header and the partition array
>> with a CRC32.
>>>     write() everything, then fsync() so it all hits the disk in
>>>
>>>    So I'd agree with Karel that the current method is probably
>>> ideal.  write() everything, then fsync() so it all hits the disk in
>>> one multi-sector write op.  Not necessarily atomic, but probably.
>> As the block will not be consecutive (primary and backup), the operation
>> cannot be done in one write operation....
> So at least one of the four 4kiB sectors doesn't get written at all?
> Because if all the sectors are getting written, regardless of order,
> Linux will merge the IOs into one write request to send over the SATA
> (or whatever) wire.  Write request merging is useful even on SSDs, so
> Linux does it.
>
>   Even if there is a sector that doesn't get written, it's probably
> still academic.  Sending a request in a single write OP doesn't make
> it atomic.  On a magnetic disk, the data will still probably all
> hit the platter on the same rotation, just by powering down the write
> head as it flies over the sector you aren't writing, so the window for
> a power failure to cause a problem is quite small.  I'm sure SSDs are
> far more complicated.
The guaranty of the write OP clearly depends of the hardware... The 
primary/backup mechanism and CRC checks are implemented to detect these 
hardware failures.
>> I agree that we should wait confirmation of a storage expert but the
>> fsync() and sleep() combination should guaranty the operation order on
>> most hardware.
>   Probably 1/10th of a second is long enough, but still short enough to
> not be annoying.  If you're editting the partition table of a disk
> that isn't idle (in which case even 1 sec might not be long enough for
> the write to hit disk after fdatasync()), and you don't have the
> system on a UPS, I think we maybe don't need to waste 0.9 seconds of
> everyone's time just for this hypothetical user.
>
>
I agree that we don't need to waste 1 second of everyone's time. 
Nevertheless, only a fsync() between the write operation of the backup 
and primary GTP systems will give more chances that data are directly 
written to the disk (the disk cache will be flushed).

-- 
Ronan CHAUVIN
Embedded Software Engineer
ASIC team
--------------------------------
Parrot
174, quai de Jemmapes
75010 Paris  France
--------------------------------
www.parrot.com

