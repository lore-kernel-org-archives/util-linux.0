Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53864 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755866AbdGKRyt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Jul 2017 13:54:49 -0400
Subject: Re: [PING - REBASED][PATCH 0/5] pull request
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <36c342d3-ec59-59fe-f98e-233d72696d84@gmx.com>
 <20170711080612.jundydfm6zlxaes4@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <cead562a-c9d4-5c67-9817-73c5e20e7098@gmx.com>
Date: Tue, 11 Jul 2017 13:54:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170711080612.jundydfm6zlxaes4@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/11/2017 04:06 AM, Karel Zak wrote:
> On Mon, Jul 10, 2017 at 07:34:55PM -0400, J William Piggott wrote:
>> On 07/02/2017 03:45 PM, J William Piggott wrote:
>>>
>>> The following changes since commit 07fd6640c80ffd7a2067844aadcb6162431b3525:
>>>
>>>   Merge branch 'path-fixes' of https://github.com/rudimeier/util-linux (2017-06-29 15:29:33 +0200)
>>>
>>> are available in the git repository at:
>>>
>>>   git@github.com:jwpi/util-linux.git 170701
>>>
>>> for you to fetch changes up to 9c50e384c89d5f9391c3eaed8df89ec965f2fda7:
>>>
>>>   hwclock: sync one-liner descriptions (2017-07-02 14:09:41 -0400)
>>>
>>> ----------------------------------------------------------------
>>> J William Piggott (5):
>>>       hwclock: remove from usage() FILE *out = stdout
>>>       hwclock: usage() use program_invocation_short_name
>>>       hwclock: final usage() strings slice
>>>       docs: update boilerplate.c usage()
>>>       hwclock: sync one-liner descriptions
>>>
>>>  Documentation/boilerplate.c | 37 ++++++++++++------------
>>>  sys-utils/hwclock.8.in      |  4 +--
>>>  sys-utils/hwclock.c         | 68 +++++++++++++++++++++++----------------------
>>>  3 files changed, 55 insertions(+), 54 deletions(-)
> 
> Merged. (Sorry for delay, I had vacation since Wed).

Thank you! (No problem, I hope you had a good holiday).

> 
>     Karel
> 
