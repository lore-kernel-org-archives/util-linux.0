Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbbFPJnW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jun 2015 05:43:22 -0400
Date: Tue, 16 Jun 2015 11:43:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: util-linux@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: optimal io size / custom alignment
Message-ID: <20150616094320.GX1992@ws.net.home>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
 <20150615133154.GV1992@ws.net.home>
 <CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 16, 2015 at 01:20:37PM +0800, Tom Yan wrote:
> The thing is, why any io/transfer size/length should be considered
> when it comes to partition alignment? From what I understand,
> partition alignment is only to make sure partition starts at physical
> boundaries of the disk because of the mismatch between logicial sector
> (512 bytes) and physical sectors (4096 bytes) or pages/erase blocks of
> SSDs.

It's more complicated, the I/O limits are the most important for RAIDs
where optimal I/O size is usually stripe size and you want to use it
for partitions alignment for better performance (if you align to
sector size then read/write on RAID maybe performed on more disks on
unaligned partitions). And it's not only fdisk who cares, it's also
important for mkfs.<type> (for example XFS align according to I/O limits).

And because all this is mess and sometimes HW does not provide
relevant information and because people use dd(1) to copy partition
tables we have decided to use 1MiB granularity if possible. If 1MiB is
useless then we use optimal_io_size, if undefined then minimal_io_size 
and if undefined then sector_size.

http://people.redhat.com/msnitzer/docs/io-limits.txt


Unfortunately the current code does not check if optimal_io_size makes
sense, so thing like 33553920 for 4k device is blindly accepted ;-(

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
