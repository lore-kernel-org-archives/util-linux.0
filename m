Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59532 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdH3R4e (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Aug 2017 13:56:34 -0400
Subject: Re: [PATCH 2/3] hwclock: remove audit from control struct
To: Karel Zak <kzak@redhat.com>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
 <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
 <20170830074001.brchka4sfp36wukz@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <50bfaf8d-7036-deb7-5cde-854da4e23f64@gmx.com>
Date: Wed, 30 Aug 2017 13:56:21 -0400
MIME-Version: 1.0
In-Reply-To: <20170830074001.brchka4sfp36wukz@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 08/30/2017 03:40 AM, Karel Zak wrote:
> On Tue, Aug 29, 2017 at 12:34:07PM -0400, J William Piggott wrote:
>>
>> hwaudit_on is only used in main() and hwclock_exit() and
>> that is unlikely to ever change.
> 
>  Hmm... the goal is minimize global variables to keep code readable.
>  It's strange to have a control struct and use global variable in the
>  same time.
> 
>> Remove it from the control struct because it:
>>  * cleans up an ugly directive in hwclock_exit
>>  * removes an argument from usage() and hwclock_exit()
>>  * makes usage() comply with util-linux standards
> 
>  I think usage() can call exit(EXIT_SUCCESS) and do not need play any
>  games with audit at all.

True for half of hwclock's functions. Perhaps this special exit
handling should only exist when we HAVE_LIBAUDIT?

Okay, I'll rethink this and update the pull request.

>  
>  On another places we have "ctl" so it's fine fine to keep hwaudit_on
>  within the control struct.
> 
>     Karel
> 
