Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43895 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2GaNv3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 Jul 2012 09:51:29 -0400
Date: Tue, 31 Jul 2012 15:51:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: tests: blkid/md-raid1-part fails
Message-ID: <20120731135124.GB17896@x2.net.home>
References: <501772B7.2040504@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <501772B7.2040504@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 31, 2012 at 07:52:55AM +0200, Bernhard Voelker wrote:
> The above mentioned test fails here (OpenSuSE-12.1 64-bit).
> 
> That's in diff/blkid/md-raid1-part:
> 
> --- /media/sdb5/berny/git/util-linux/tests/expected/blkid/md-raid1-part	2012-07-27 09:54:03.769967754 +0200
> +++ /media/sdb5/berny/git/util-linux/tests/output/blkid/md-raid1-part	2012-07-31 07:18:24.057815522 +0200
> @@ -44,7 +44,7 @@
> 
> 
>  ID_FS_VERSION=0.90.0
> -ID_PART_ENTRY_DISK=8:16
> +ID_PART_ENTRY_DISK=8:112
>  ID_PART_ENTRY_NUMBER=1
>  ID_PART_ENTRY_OFFSET=2048
>  ID_PART_ENTRY_SCHEME=dos
> @@ -56,7 +56,7 @@
> 
> 
>  ID_FS_VERSION=0.90.0
> -ID_PART_ENTRY_DISK=8:16
> +ID_PART_ENTRY_DISK=8:112
>  ID_PART_ENTRY_NUMBER=2
>  ID_PART_ENTRY_OFFSET=53248
>  ID_PART_ENTRY_SCHEME=dos
> 
> What's wrong with that minor number?

Nothing, it would be better to check if the line ID_PART_ENTRY_DISK=
is in the $TS_OUTPUT and if yes then remove the line from the output
file (e.g. by sed).

The tests should not rely on device numbers and device names -- on
another places you can found /dev/loop0 in the expected outputs...

Patches wanted :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
