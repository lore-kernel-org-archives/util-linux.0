Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:47981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPhU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Aug 2018 11:37:20 -0400
Subject: Re: su(1) --whitelist-environment
To: Karel Zak <kzak@redhat.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
References: <20180810092401.inc32ady3eidzyjo@ws.net.home>
 <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
 <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de>
 <20180814093257.nglcor4c3jagjyxv@ws.net.home>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <74770378-d739-c0d8-4cfe-3e898bf45f95@bernhard-voelker.de>
Date: Tue, 14 Aug 2018 14:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180814093257.nglcor4c3jagjyxv@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/14/2018 11:32 AM, Karel Zak wrote:
> On Mon, Aug 13, 2018 at 10:57:01PM +0200, Bernhard Voelker wrote:
>> Well, this might become slightly trickier with real shell or environment
>> variables wrt/ correct shell quoting:
>>
>>   $ VAR='some value'
>>   $ su -c 'env VAR="'"$VAR"'" myscript' user
> 
> Well, probably usable way for scripts, but ugly for users on command line.
> 
> All the idea behind the patch is make things more user-friendly
> 
>     su -w GREP_COLOR,COLORFGBG - kzak
> 
> seems better than assume -c 'env VAR ..."

+1 your point. ;-)

A difference is that  -c 'env VAR ..." works also with shell variables
while -w filters exported variables only.  I think this not a big deal.

Regarding your implementation: I suggest to warn when -w is used together
with -m, -p, --preserve-environment.  WDYT?

Have a nice day,
Berny
