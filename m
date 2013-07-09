Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3GIM61 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Jul 2013 08:58:27 -0400
Date: Tue, 9 Jul 2013 14:58:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/34] pull: make printing quicker, and clang analysis
Message-ID: <20130709125817.GD24716@x2.net.home>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 07, 2013 at 08:54:15PM +0100, Sami Kerola wrote:
>       sfdisk: make unhiding as complete as possible
>       docs: add missing options to sfdisk manual

 Applied.

>       include: copy unlocked-io.h from gnulib
>       hexdump: use unlocked io, and avoid use of printf()
>       text-utils: use unlocked io
>       misc-utils: use unlocked io
>       scriptreplay: use unlocked io
>       dmesg: use unlocked io, and avoid use of printf()
>       utmpdump: use unlocked io, and avoid use of printf()

 Postponed.

>       dmesg: inform user --show-delta and iso8601 time format does not mix
>       lib/loopdev: assigned value is never read [clang-analyzer]
>       lib/mbsalign: initializations values are never read [clang-analyzer]
>       libmount: fix memory leak [clang-analyzer]

 Fixed and applied.

>       ipcs: assigned values are never read [clang-analyzer]
>       lscpu: fix memory leak [clang-analyzer]
>       more: assigned value is never read [clang-analyzer]
>       utmpdump: assigned values are never read [clang-analyzer]
>       mkfs.cramfs: argument to free() is a constant address [clang-analyzer]
>       eject: assigned value is never read [clang-analyzer]
>       chfn: assigned value is never read [clang-analyzer]

 Applied.

>       mesg: assigned value is never read [clang-analyzer]
>       rev: assigned value is never read [clang-analyzer]
>       column: assigned value is never read [clang-analyzer]
>       hwclock: assigned value is never read [clang-analyzer]
>       dmesg: assigned value is never read [clang-analyzer]
>       login: assigned value is never read [clang-analyzer]
>       fdisk: assigned value is never read [clang-analyzer]

 Ignored as keep argv and argc consistent seems better.

>       sulogin: fix memory leak [clang-analyzer]
>       agetty: fix memory leak [clang-analyzer]
>       dmesg: add missing initializer [clang-analyzer]
        ^^^^^
        uuidd:

 Fixed & applied.

>       ul: use correct types
>       ul: use string printing function
>       column: dereference of null pointer [clang-analyzer]
>       more: use variable lenght printf field width to print blanks

 Applied (with some changes).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
