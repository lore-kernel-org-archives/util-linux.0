Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 2/3] hwclock: remove audit from control struct
To: kerolasa@gmail.com
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
 <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
 <20170830074001.brchka4sfp36wukz@ws.net.home>
 <50bfaf8d-7036-deb7-5cde-854da4e23f64@gmx.com>
 <2916a0af-0cb7-7145-e05e-ac2eefb46fa4@gmx.com>
 <CAG27Bk2VxKPnnwB4yHE5We6JUO7Y7Ry31=di6OkzbABL6g4-=g@mail.gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <44d0d0a6-d727-9d39-eb32-8a293078e059@gmx.com>
Date: Sun, 3 Sep 2017 21:22:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2VxKPnnwB4yHE5We6JUO7Y7Ry31=di6OkzbABL6g4-=g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 09/03/2017 05:54 PM, Sami Kerola wrote:
> On 3 September 2017 at 20:59, J William Piggott <elseifthen@gmx.com> wrote:
>> On 08/30/2017 01:56 PM, J William Piggott wrote:
>>> On 08/30/2017 03:40 AM, Karel Zak wrote:
>>>> On Tue, Aug 29, 2017 at 12:34:07PM -0400, J William Piggott wrote:
>>>>>
>>>>> hwaudit_on is only used in main() and hwclock_exit() and
>>>>> that is unlikely to ever change.
>>>>
>>>>  Hmm... the goal is minimize global variables to keep code readable.
>>>>  It's strange to have a control struct and use global variable in the
>>>>  same time.
>>>>
>>>>> Remove it from the control struct because it:
>>>>>  * cleans up an ugly directive in hwclock_exit
>>>>>  * removes an argument from usage() and hwclock_exit()
>>>>>  * makes usage() comply with util-linux standards
>>>>
>>>>  I think usage() can call exit(EXIT_SUCCESS) and do not need play any
>>>>  games with audit at all.
>>>
>>> True for half of hwclock's functions. Perhaps this special exit
>>> handling should only exist when we HAVE_LIBAUDIT?
>>>
>>> Okay, I'll rethink this and update the pull request.
>>
>> So it seems that there are more problems with exit and audit handling
>> then I first thought. Improving them is going to be more invasive and
>> will need to wait for refactoring of main() and manipulate_clock().
>>
>> For now I have implemented Karel's idea to mix the use of hwclock_exit()
>> and exit().
>>
>> Pushed changes to the same branch:
>>
>> The following changes since commit 58d57ae2d88ef638e3ff07c213b5158334d3f658:
>>
>>   tests: update sfdisk wipe test (2017-09-01 10:42:51 +0200)
>>
>> are available in the git repository at:
>>
>>   git@github.com:jwpi/util-linux.git 170825
>>
>> for you to fetch changes up to 5b8e46f7e7710e2bb88ff8e763997830c9494df2:
>>
>>   hwclock: close hwaudit_fd unconditionally (2017-09-03 12:34:03 -0400)
>>
>> ----------------------------------------------------------------
>> J William Piggott (3):
>>       hwclock: remove sysexits.h
>>       hwclock: don't always use hwclock_exit
>>       hwclock: close hwaudit_fd unconditionally
>>
>>  sys-utils/hwclock-rtc.c |  5 ++--
>>  sys-utils/hwclock.8.in  |  8 ++++++
> 
> Update to manual telling return zero is success and one is failure feels
> unnecessary. I don't think any other manual page does that, and most
> users know these values without being explicit. It's the unusual return
> codes that we should document so that users has some idea what
> could it mean  when a command returns 42.

* It is one and zero only for POSIX systems.
* Most users probably don't know that, programmers do.
* Athough it was undocumented hwclock was using sysexits.h so it is
  worth documenting the change for clarity.
* it doesn't hurt anything to document it.

> 
>>  sys-utils/hwclock.c     | 76 ++++++++++++++++++-------------------------------
>>  3 files changed, 37 insertions(+), 52 deletions(-)
>>
>>>
>>>>
>>>>  On another places we have "ctl" so it's fine fine to keep hwaudit_on
>>>>  within the control struct.
> 
