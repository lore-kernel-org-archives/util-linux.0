Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbdICT7p (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 3 Sep 2017 15:59:45 -0400
Subject: Re: [PATCH 2/3] hwclock: remove audit from control struct
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
 <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
 <20170830074001.brchka4sfp36wukz@ws.net.home>
 <50bfaf8d-7036-deb7-5cde-854da4e23f64@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2916a0af-0cb7-7145-e05e-ac2eefb46fa4@gmx.com>
Date: Sun, 3 Sep 2017 15:59:31 -0400
MIME-Version: 1.0
In-Reply-To: <50bfaf8d-7036-deb7-5cde-854da4e23f64@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 08/30/2017 01:56 PM, J William Piggott wrote:
> 
> 
> On 08/30/2017 03:40 AM, Karel Zak wrote:
>> On Tue, Aug 29, 2017 at 12:34:07PM -0400, J William Piggott wrote:
>>>
>>> hwaudit_on is only used in main() and hwclock_exit() and
>>> that is unlikely to ever change.
>>
>>  Hmm... the goal is minimize global variables to keep code readable.
>>  It's strange to have a control struct and use global variable in the
>>  same time.
>>
>>> Remove it from the control struct because it:
>>>  * cleans up an ugly directive in hwclock_exit
>>>  * removes an argument from usage() and hwclock_exit()
>>>  * makes usage() comply with util-linux standards
>>
>>  I think usage() can call exit(EXIT_SUCCESS) and do not need play any
>>  games with audit at all.
> 
> True for half of hwclock's functions. Perhaps this special exit
> handling should only exist when we HAVE_LIBAUDIT?
> 
> Okay, I'll rethink this and update the pull request.

So it seems that there are more problems with exit and audit handling
then I first thought. Improving them is going to be more invasive and
will need to wait for refactoring of main() and manipulate_clock().

For now I have implemented Karel's idea to mix the use of hwclock_exit()
and exit().

Pushed changes to the same branch:

The following changes since commit 58d57ae2d88ef638e3ff07c213b5158334d3f658:

  tests: update sfdisk wipe test (2017-09-01 10:42:51 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170825

for you to fetch changes up to 5b8e46f7e7710e2bb88ff8e763997830c9494df2:

  hwclock: close hwaudit_fd unconditionally (2017-09-03 12:34:03 -0400)

----------------------------------------------------------------
J William Piggott (3):
      hwclock: remove sysexits.h
      hwclock: don't always use hwclock_exit
      hwclock: close hwaudit_fd unconditionally

 sys-utils/hwclock-rtc.c |  5 ++--
 sys-utils/hwclock.8.in  |  8 ++++++
 sys-utils/hwclock.c     | 76 ++++++++++++++++++-------------------------------
 3 files changed, 37 insertions(+), 52 deletions(-)

> 
>>  
>>  On another places we have "ctl" so it's fine fine to keep hwaudit_on
>>  within the control struct.
>>
>>     Karel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
