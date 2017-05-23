Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52126 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033872AbdEWUy5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 May 2017 16:54:57 -0400
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>
References: <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
 <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
 <20170520193446.bt44te35kji2gmzo@ws.net.home>
 <b6e7901f-4df8-6842-0475-0290d110f68e@gmx.com>
 <20170523075733.wwlzrff6atybmsal@ws.net.home>
 <20170523080513.3yhhfzlmnyqoovpd@ws.net.home>
Cc: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <614d0e03-6baf-861b-8636-71c07443b3b6@gmx.com>
Date: Tue, 23 May 2017 16:54:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170523080513.3yhhfzlmnyqoovpd@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 05/23/2017 04:05 AM, Karel Zak wrote:
> On Tue, May 23, 2017 at 09:57:33AM +0200, Karel Zak wrote:
>> On Mon, May 22, 2017 at 05:37:28PM -0400, J William Piggott wrote:
>>> My thoughts are that bugfix releases should be committed to 'master' the
>>> same as the stable/rc releases are. Then the tag created from that commit.
>>
>> How do you want to commit bugfix release (e.g. v2.29.2) to the
>> 'master' if the master and 'stable/' branches contain a different
>> code? 
>>
>> The current workflow:
>>
>>  1) development (branch: <master>)
>>
>>  2) master release (tags: v2.29-rc1, v2.29-rc2, v2.29, branch: <master>)
>>
>>  3) development (work on v2.30, branch: <master>)
>>
>>  4) fork -- create a new branch <stable/v2.29> based on tag v2.29
>>
>>      4a) new patches or cherry-pick patches from <master> (branch: <stable/v2.29>)
>>
>>      4b) stable release (tag: v2.29.1, branch: <stable/v2.29>)
>>
>>      4c) another patches, another release (tag: v2.29.2, branch: <stable/v2.29>)
>>
>>  5) master release v2.30 (branch: <master>)
>>     ...
>>
>>
>> where 3) and 4) happen in the same time.

Argh, my brain was broken. I wrongheadedly believed that this project
was using linear development.

> 
> And yes, NEWS file in the master does not contain info about
> maintenance release (e.g. v2.29.1). Maybe it's mistake.

No, I was the mistake ;)

> 
> This information is in the ReleaseNotes where are links to the
> previous maintenance releases. 
> 
> We can add a hint about maintenance releases to the master branch NEWS
> file, but stable maintenance tags (v2.29.1) has to be in the stable/
> branches. It's released code what has to be tagged and signed.

It's all clear now that you've pulled my head out of ... its 'master'
branch walled garden. The stable maintenance tags are not reachable
from, pulled by, or have anything else to do with the 'master' branch.
They belong only to their respective forked stable branches being developed
independently. Hinting about them in master would probably be misleading.

I think I will submit a patch to add something to Documentation about
this so that someone else might not ask the same dumb questions. With
your permission, I might include your well written workflow description.

Sorry for wasting your time Karel (and anyone else reading this). Thank
you for setting me straight.


> 
>     Karel
> 
