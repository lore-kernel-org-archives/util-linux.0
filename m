Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:55510 "EHLO
	mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbCWSbo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Mar 2015 14:31:44 -0400
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta02.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NLN00IU2UT54H30@mta02.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 23 Mar 2015 15:31:42 -0300 (ADT)
Date: Mon, 23 Mar 2015 15:31:42 -0300
To: Karel Zak <kzak@redhat.com>
Cc: Ronan CHAUVIN <ronan.chauvin@parrot.com>, util-linux@vger.kernel.org,
        matthieu CASTET <matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden
	power off
Message-id: <20150323183142.GU3933@cordes.ca>
References: <550BF3A9.8080508@parrot.com> <20150320111812.GG28925@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20150320111812.GG28925@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 20, 2015 at 12:18:12PM +0100, Karel Zak wrote:
> Conclusion: be pessimistic and verify all you read from disk and be 
> optimistic when you write to the disk, and when when someone is talking 
> about write guaranty and run far away. That's all the story.


The whole GPT is what, 16kiB or so?  On most storage, you could
force data to persistent storage with a granularity of 4kiB, with
fdatasync(2) (assuming that works on block devices, not just files).  

But some SSDs lie, and will claim that data is flushed to persistent
storage when it isn't.  (According to one of Marc Merlin's BTRFS
talks).

 So I'd agree with Karel that the current method is probably
ideal.  write() everything, then fsync() so it all hits the disk in
one multi-sector write op.  Not necessarily atomic, but probably.

If we think the backup partition table / GPT header is useful,
write(backup); fsync();
sleep(1sec);
write(primary); fsync();
is potentially worthwhile.  On an SSD, there's the mapping metadata
separate from the actual data, and the write block size might be 8kiB
on some current disks.  (This is why I'm thinking that the 1sec pause
between writing the backup and primary would give a chance for
whatever write-back caching layers to actually flush for real.)

 I don't know how likely that is to help on any real storage setup;
I'm really just making that up.  I also don't know whether the backup
and primary are in separate 4kiB or 8kiB data blocks.  Even if not, it
could still be useful to always be writing blocks where one of the two
copies written matches what's already there, so there's a valid table
whether the old or new version is there when you try to read it back.

So I think there's potentially a tiny benefit to a fsync();sleep(),
but I'd wait for confirmation from a storage expert before
implementing it.  The current method probably just sends one write op
to the hardware for the whole GPT, which is nice.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
