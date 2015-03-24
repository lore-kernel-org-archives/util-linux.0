Return-Path: ronan.chauvin@parrot.com
Message-ID: <55116F30.3080204@parrot.com>
Date: Tue, 24 Mar 2015 15:05:36 +0100
From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
MIME-Version: 1.0
To: Peter Cordes <peter@cordes.ca>, Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>,
        matthieu CASTET
	<matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden
 power off
References: <550BF3A9.8080508@parrot.com> <20150320111812.GG28925@ws.net.home> <20150323183142.GU3933@cordes.ca>
In-Reply-To: <20150323183142.GU3933@cordes.ca>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <util-linux.vger.kernel.org>

Thank you for your answer.

On 03/23/2015 07:31 PM, Peter Cordes wrote:
> On Fri, Mar 20, 2015 at 12:18:12PM +0100, Karel Zak wrote:
>> Conclusion: be pessimistic and verify all you read from disk and be
>> optimistic when you write to the disk, and when when someone is talking
>> about write guaranty and run far away. That's all the story.
> The whole GPT is what, 16kiB or so?  On most storage, you could
> force data to persistent storage with a granularity of 4kiB, with
> fdatasync(2) (assuming that works on block devices, not just files).
The whole GPT is 16kiB (MBR+GPT header+partition array). There is two 
GPT systems, one at the beginning and another one at the end. The 
bootloader verifies the integrity of the header and the partition array 
with a CRC32.
>    write() everything, then fsync() so it all hits the disk in
>
> But some SSDs lie, and will claim that data is flushed to persistent
> storage when it isn't.  (According to one of Marc Merlin's BTRFS
> talks).
>
>   So I'd agree with Karel that the current method is probably
> ideal.  write() everything, then fsync() so it all hits the disk in
> one multi-sector write op.  Not necessarily atomic, but probably.
As the block will not be consecutive (primary and backup), the operation 
cannot be done in one write operation....
> If we think the backup partition table / GPT header is useful,
> write(backup); fsync();
> sleep(1sec);
> write(primary); fsync();
> is potentially worthwhile.  On an SSD, there's the mapping metadata
> separate from the actual data, and the write block size might be 8kiB
> on some current disks.  (This is why I'm thinking that the 1sec pause
> between writing the backup and primary would give a chance for
> whatever write-back caching layers to actually flush for real.)
>
>   I don't know how likely that is to help on any real storage setup;
> I'm really just making that up.  I also don't know whether the backup
> and primary are in separate 4kiB or 8kiB data blocks.  Even if not, it
> could still be useful to always be writing blocks where one of the two
> copies written matches what's already there, so there's a valid table
> whether the old or new version is there when you try to read it back.
>
> So I think there's potentially a tiny benefit to a fsync();sleep(),
> but I'd wait for confirmation from a storage expert before
> implementing it.  The current method probably just sends one write op
> to the hardware for the whole GPT, which is nice.
I agree that we should wait confirmation of a storage expert but the 
fsync() and sleep() combination should guaranty the operation order on 
most hardware.
>

Best regards,

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
