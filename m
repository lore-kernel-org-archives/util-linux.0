Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:65098 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbdFMPSq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:18:46 -0400
Subject: Re: [PATCH 0/6] fix various minor issues and warnings
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
 <20170613134719.qshrdtvvcystm4vd@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <597df757-fae1-c1f8-a5cf-dea177b2d9a3@gmx.de>
Date: Tue, 13 Jun 2017 17:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170613134719.qshrdtvvcystm4vd@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/13/2017 03:47 PM, Karel Zak wrote:
> On Mon, Jun 12, 2017 at 10:49:52AM +0200, Ruediger Meier wrote:
>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>
>> Ruediger Meier (6):
>>    tests: fix fincore, don't use variable COLUMNS
>>    libmount: btrfs, remove unused setter functions
>>    hwclock: fix warning [-Winvalid-noreturn]
>>    misc: fix gcc-7 sprintf warnings -Wformat-overflow
>>    misc: fix gcc-7 snprintf warnings -Wformat-truncation
>>    libblkid: fix gcc-7 warning -Wint-in-bool-context
>>
>>   lib/loopdev.c                    |  2 +-
>>   lib/sysfs.c                      |  4 ++--
>>   libblkid/src/devname.c           |  2 +-
>>   libblkid/src/superblocks/exfat.c |  4 ++--
>>   libmount/src/btrfs.c             |  4 ----
>>   login-utils/last.c               |  2 +-
>>   sys-utils/hwclock.c              |  2 +-
>>   sys-utils/hwclock.h              |  3 ++-
>>   tests/ts/fincore/count           | 12 ++++++------
>>   9 files changed, 16 insertions(+), 19 deletions(-)
> 
> Seems better than the previous version from Sami (May 27).

These fixed are completely independent/unrelated to the other pull
request from Sami. Sami's PR just motivated me to try out gcc-7 too.

cu,
Rudi
