Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbbAZL3R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 06:29:17 -0500
Date: Mon, 26 Jan 2015 12:29:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc1
Message-ID: <20150126112913.GM6354@x2.net.home>
References: <20150114194608.GF28019@x2.net.home>
 <1421786901.3565769.216421909.377E2720@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421786901.3565769.216421909.377E2720@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 20, 2015 at 09:48:21PM +0100, Benno Schulenberg wrote:
> 
> On Wed, Jan 14, 2015, at 20:46, Karel Zak wrote:
> > Feedback and bug reports, as always, are welcomed.
> 
> During compilation I get this:
> 
> libmount/src/lock.c: In function 'mnt_wait_mtab_lock':
> libmount/src/lock.c:263: warning: format '%ju' expects type 'uintmax_t', but argument 4 has type '__time_t'
> libmount/src/lock.c:263: warning: format '%ju' expects type 'uintmax_t', but argument 5 has type 'time_t'
> libmount/src/lock.c:263: warning: format '%ju' expects type 'uintmax_t', but argument 6 has type 'long int'

 fixed

>   CC       disk-utils/fdisk-fdisk-list.o
> In file included from disk-utils/fdisk-list.c:1:
> ./libfdisk/src/libfdisk.h:279: error: expected declaration specifiers or '...' before 'off_t'
> make[2]: *** [disk-utils/fdisk-fdisk-list.o] Error 1
> make[2]: Leaving directory `/home/ben/Programoj/util-linux-2.26-rc1'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/ben/Programoj/util-linux-2.26-rc1'
> make: *** [all] Error 2

 fixed

Thanks!
    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
