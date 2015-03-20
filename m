Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42409 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbCTLSO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Mar 2015 07:18:14 -0400
Date: Fri, 20 Mar 2015 12:18:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Ronan CHAUVIN <ronan.chauvin@parrot.com>
Cc: util-linux@vger.kernel.org, matthieu CASTET <matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden
 power off
Message-ID: <20150320111812.GG28925@ws.net.home>
References: <550BF3A9.8080508@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <550BF3A9.8080508@parrot.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 20, 2015 at 11:17:13AM +0100, Ronan CHAUVIN wrote:
> I have a question regarding the fdisk library (libfdisk) provided in the
> 2.26 version of util-linux. I use it to create a MBR/GPT partition scheme on
> a eMMC memory. I also use the partition renaming mechanism to switch from a
> normal boot to an update boot (the bootloader compares partitions names to
> choose the one to boot on).
> 
> I was wondering if the gpt_write_disklabel function was robust to sudden
> power-off. In the source code, the writing procedure is as follow (UEFI
> requires writing in this specific order):
> 
> 1) backup partition tables
> 2) backup GPT header
> 3) primary partition tables
> 4) primary GPT header
> 5) protective MBR
> 
> and uses the standard linux write function with a file descriptor. Is the
> writing order guaranty as operation is not synchronous ? I know that the
> linux io scheduler can "optimize" writing operations order. This can
> introduce an issue if only the primary and backup headers are written but
> not the partition tables.

The order suggested by UEFI is there because GPT header contains CRC of the
array with partitions and the header is validated by another top-level CRC. If
you read things in reverse order (PMBR, header, partitions) and verify
all the CRCs then you can be sure that all is valid.

IMHO the "right" write procedure is just holy grail... in reality we have no 
any guaranty (due to storage HW).

The important is to be able to detect inconsistent stuff on the device when 
you *read* GPT.

We can add fsync() between the steps, but I still have doubts it will
improve anything. For example libparted also uses write() only.

We call fsync() before close() in libfdisk/src/context.c:
fdisk_deassign_device().

Conclusion: be pessimistic and verify all you read from disk and be 
optimistic when you write to the disk, and when when someone is talking 
about write guaranty and run far away. That's all the story.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
