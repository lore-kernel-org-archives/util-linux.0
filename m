Return-Path: util-linux-owner@vger.kernel.org
Received: from cosmos.geomatys.fr ([88.191.17.20]:45606 "EHLO
	cosmos.geomatys.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1GRPGd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2011 11:06:33 -0400
Received: from [10.234.175.50] (unknown [193.252.149.222])
	by cosmos.geomatys.fr (Postfix) with ESMTPSA id D0254120003A
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 16:56:54 +0200 (CEST)
Message-ID: <4E2449B6.1070105@geomatys.fr>
Date: Mon, 18 Jul 2011 16:56:54 +0200
From: "corentin.labbe" <corentin.labbe@geomatys.fr>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg.c: print human readable timestamp
References: <4DD6593D.2090202@geomatys.fr> <20110629145957.GM6418@nb.net.home>
In-Reply-To: <20110629145957.GM6418@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le 29/06/2011 16:59, Karel Zak a écrit :
> On Fri, May 20, 2011 at 02:06:21PM +0200, corentin.labbe wrote:
>>
>> This patch add the -H option to dmesg which allow to print human
>> readable time instead of the number of seconds since boot.
>
>  Nice idea, but it's not so simple :-(
>
>  The time stamp used for printk() is not based on normal system time
>  (as you know from gettimeofday()). It uses cpu_clock() (IMHO to
>  keep printk() robust and without xtime_lock).
>
>  The problem is that the cpu_clock is not updated after system resume,
>  so if you suspend (e.g. pm-suspend(8)) and resume than the dmesg -H
>  command prints nonsenses...
>
>  For example (copy & past from /var/log/messages):
>
>   Jun 27 23:39:53 nb kernel: [50065.238635] PM: Syncing filesystems  ... done.
>   Jun 28 20:23:29 nb kernel: [50065.284226] Freezing user space  processes ... (elapsed 0.09 seconds) done.
>                               ^^^^^
>  The first line is before suspend and second is after resume. The time
>  stamp [50065.xxxxxx] is still the same although the system was
>  suspended for almost whole day.
>
>  The same system, the latest kernel message:
>
>     # date
>     Wed Jun 29 16:29:28 CEST 2011
>
>     # mount /dev/sdb1 /mnt/test
>
>     # ./sys-utils/dmesg -H | tail -1
>     [Tue Jun 28 11:10:41 2011] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
>
>
>   Karel
>

Perhaps we could keep my patch and add a warning about "problem with suspend/resume" (both at first line when -H is used and in manpages).
Like "Warning timestamp could be inaccurate if you have used SUSPEND/RESUME"

If you are agree with that I will update my patch accordingly.

Bests regards
