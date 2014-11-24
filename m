Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaKXLhl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 06:37:41 -0500
Date: Mon, 24 Nov 2014 12:37:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Drake Wilson <drake@dasyatidae.net>
Cc: util-linux@vger.kernel.org, 770211@bugs.debian.org
Subject: Re: LUKS partition types, redux
Message-ID: <20141124113733.GC926@x2.net.home>
References: <546D0495.2030803@dasyatidae.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <546D0495.2030803@dasyatidae.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 19, 2014 at 02:59:01PM -0600, Drake Wilson wrote:
> Summary: I would like to reopen the suggestion to add LUKS partition type codes
> for MBR and for GPT to util-linux's fdisk.  In a previous discussion, it was
> said that since Linux does not interpret partition types, there is no need for
> this, but concrete data loss has now occurred as a result of a related bug in
> other software combined with the lack of a user-visible LUKS type in a similar
> partitioning program, and I believe that warrants re-examination of the situation.

 But it seems that the problem is what details partitioning tools
 provide to end-users rather than problem with data within disk
 labels. I don't see problem to add FS type column to fdisk(s) (it's
 already linked with libblkid).

> I would thus like to re-propose adding a LUKS type.  Alternatively, if a LUKS
> type is still considered a bad idea, I would like to suggest allocating a GPT ID
> analogous to the "da = Non-FS data" MBR type code, which would at least allow the
> user to choose a fallback that has a known null semantic, rather than tagging their
> volumes with some arbitrary ID that may be misinterpreted; that would help avert
> analogous problems for future types as well.

 You want to make a connection between partition type and partition
 format (FS, LUKS, LVM...). This idea is more than 30years old and it
 has been always fragile and introduced for poorly designed systems
 (kernels and boot loaders). 
 
 The current trend is to use partition type to define for what purpose
 we want to use the partition (for example "this is /home")
 independently on partition format. 
 
 For example systemd is able to generate on the fly mount table
 according to GPT partition types (so we have type for root and
 /home). All this is independent on FS/LUKS/etc. The same GUID is for
 XFS, ext4 ... this concept is not compatible with your idea.

 BTW, LUKS (and also XFS) is one of well designed on-disk formats
 where magic string is at the begin of the device, so all you need is
 one seek()+read().

 Anyway, I'd like to minimize number of situations when we depend
 on GPT/MBR partition types at all.

> (I also believe more philosophically that the user should be supported in the
> possibility of integrating with other partition management systems that may wish
> to detect LUKS and do something special with it, without requiring all other such
> systems to incorporate a blkid-like system for checking in several places for the
> "basic nature" of a volume.  I mention this only for the record, since the previous
> thread suggests the util-linux maintainers don't agree with this.)

 This is about partitioning tools, not about on-disk disk label data.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
