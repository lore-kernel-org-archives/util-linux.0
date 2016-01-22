Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32825 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbcAVWDs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 22 Jan 2016 17:03:48 -0500
Received: by mail-vk0-f51.google.com with SMTP id e64so49059890vkg.0
        for <util-linux@vger.kernel.org>; Fri, 22 Jan 2016 14:03:48 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <56A27F92.6020309@prgmr.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
	<20160120103042.clphjleuiesjrl52@ws.net.home>
	<56A1596C.3060507@prgmr.com>
	<56A25241.8050000@imap.cc>
	<56A27F92.6020309@prgmr.com>
Date: Fri, 22 Jan 2016 22:03:47 +0000
Message-ID: <CAG27Bk1xN6RccvCKwurdftkHkvS86Mi5VnA-8UiP7Y0peuh02A@mail.gmail.com>
Subject: Re: [PATCH] mkswap: Add warnings for insecure device permissions/owners
From: Sami Kerola <kerolasa@iki.fi>
To: Sarah Newman <srn@prgmr.com>
Cc: Tilman Schmidt <tilman@imap.cc>, Karel Zak <kzak@redhat.com>,
        "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 January 2016 at 19:14, Sarah Newman <srn@prgmr.com> wrote:
> On 01/22/2016 08:01 AM, Tilman Schmidt wrote:
>> Am 21.01.2016 um 23:19 schrieb Sarah Newman:
>>> This patch does not break any existing behavior. The worst case possibility from accepting this patch is it will annoy some people, and best case it
>>> will save millions of devices from being shipped with insecure permissions.
>>
>> The worst case is it will train millions of administrators to ignore
>> warning messages.
>>
>
> If the warnings in swapon are legitimate, they are just as legitimate in mkswap if the file owner check is only done when mkswap is run as root.
>
> Regarding the legitimacy of the swapon warnings: do you honestly believe most of the people who will get these warnings will have intended to have
> world readable swap or swap owned as a non-root owner?
>
> When I search for "linux swap file" on google this is the second hit for me, the first being an arch linux wiki page:
> https://www.linux.com/news/software/applications/8208-all-about-linux-swap-space "centos swap file" top two hits
> https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s2-swap-creating-file.html
> https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-swap-adding.html
>
> I followed the instructions for CentOS on a CentOS 5 machine and it resulted in world readable swap. Those instructions came from Red Hat. If
> documentation from Red Hat gets it wrong, it's presumably a very common error. I made this mistake myself and I knew better.

Fair points, but should same logic be applied to file holes when
running mkswap? If the test _must_ be the same surely the mkswap &
swapon should share the function(s) performing them, as drifting would
be bad. Should these messages be optional, and if so which way around
default ought to be? This will lead to --quite or --verbose options.

Alternatively one could make swapon to get rid of all permission bits
and set ownership to UID 0 by default when ever it activates a
swapfile. How about that.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
