Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbaE3I1C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 May 2014 04:27:02 -0400
Date: Fri, 30 May 2014 10:26:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: fdisk, gpt broken on 32bit big endian systems
Message-ID: <20140530082654.GC9000@x2.net.home>
References: <201405300531.00403.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405300531.00403.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 30, 2014 at 05:31:00AM +0200, Ruediger Meier wrote:
> Hi,
> 
> This ...
> 
> $ rm -f xxx; truncate -s 10M xxx
> $ echo -ne "g\nx\ni\n26841E90-46E0-4205-B012-4B8AEC35C088\nr\nw\nq\n" | fdisk xxx
> 
> ... creates a broken gpt image on 32bit big endian systems.
> 
> "hexdiff" xxx-broken xxx-good:
>  00000260  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
>  009ffe00  45 46 49 20 50 41 52 54  00 00 01 00 00 02 00 00  |EFI PART........|
> -009ffe10  68 a5 49 d1 00 00 00 00  ff ff ff ff ff ff ff ff  |h.I.............|
> +009ffe10  15 b9 f3 7e 00 00 00 00  ff 4f 00 00 00 00 00 00  |...~.....O......|
             ^^^^^^^^^^^ ^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^ 
                crc32     reserved           header LBA

The problem is the LBA, "ff ff ff ff ff ff ff ff" seems strange :-)

(Correct is ff4f,  (means 0x4fff * 512 + 512 = 10485760, 10MiB).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
