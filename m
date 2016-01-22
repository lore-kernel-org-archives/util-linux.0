Return-Path: srn@prgmr.com
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
To: Tilman Schmidt <tilman@imap.cc>, Karel Zak <kzak@redhat.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home> <56A1596C.3060507@prgmr.com>
 <56A25241.8050000@imap.cc>
Cc: "Wayne R. Roth" <wayneroth42@gmail.com>, util-linux@vger.kernel.org
From: Sarah Newman <srn@prgmr.com>
Message-ID: <56A27F92.6020309@prgmr.com>
Date: Fri, 22 Jan 2016 11:14:26 -0800
MIME-Version: 1.0
In-Reply-To: <56A25241.8050000@imap.cc>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 01/22/2016 08:01 AM, Tilman Schmidt wrote:
> Am 21.01.2016 um 23:19 schrieb Sarah Newman:
>> This patch does not break any existing behavior. The worst case possibility from accepting this patch is it will annoy some people, and best case it
>> will save millions of devices from being shipped with insecure permissions.
> 
> The worst case is it will train millions of administrators to ignore
> warning messages.
> 

If the warnings in swapon are legitimate, they are just as legitimate in mkswap if the file owner check is only done when mkswap is run as root.

Regarding the legitimacy of the swapon warnings: do you honestly believe most of the people who will get these warnings will have intended to have
world readable swap or swap owned as a non-root owner?

When I search for "linux swap file" on google this is the second hit for me, the first being an arch linux wiki page:
https://www.linux.com/news/software/applications/8208-all-about-linux-swap-space "centos swap file" top two hits
https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s2-swap-creating-file.html
https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-swap-adding.html

I followed the instructions for CentOS on a CentOS 5 machine and it resulted in world readable swap. Those instructions came from Red Hat. If
documentation from Red Hat gets it wrong, it's presumably a very common error. I made this mistake myself and I knew better.

--Sarah
