Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbaLSNXT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 08:23:19 -0500
Date: Fri, 19 Dec 2014 14:23:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] pull: AddressSanitizer round II
Message-ID: <20141219132308.GL19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:32PM +0000, Sami Kerola wrote:
> Sami Kerola (10):
>   lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
>   cal: fix signed integer overflow [AddressSanitizer]
>   more: fix unsigned integer overflow [AddressSanitizer]
>   lib: fix crc32 and crc64 interger overflows [AddressSanitizer]
>   fdisk: (sgi) fix unsigned integer overflow [AddressSanitizer]
>   strutils: fix unsigned integer overflows [AddressSanitizer]
>   mkfs.cramfs: fix unsigned integer overflow [AddressSanitizer]
>   include/c: define UL_ASAN_BLACKLIST address_sanitizer function
>     attribute
>   lscpu: blacklist vmware_bdoor() AddressSanitizer check
>   ipcs: fix two data type errors [AddressSanitizer]

All merged from github, but except the mkfs.cramfs patch. I have also
fixed the issues with struct shm_info in ipc*.c.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
