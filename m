Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35360 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbcEDPVu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 11:21:50 -0400
Received: by mail-qg0-f50.google.com with SMTP id f74so24955944qge.2
        for <util-linux@vger.kernel.org>; Wed, 04 May 2016 08:21:49 -0700 (PDT)
Message-ID: <572A1389.1040508@gmail.com>
Date: Wed, 04 May 2016 11:21:45 -0400
From: Phil Estes <estesp@gmail.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        systemd-devel@lists.freedesktop.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Subject: Re: Unprivileged containers and co-ordinating user namespaces
References: <1461880928.2307.48.camel@HansenPartnership.com> <20160428230045.GS22888@odin.tremily.us> <1461944328.2311.10.camel@HansenPartnership.com> <87wpn9988a.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wpn9988a.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Eric W. Biederman wrote:
> James Bottomley<James.Bottomley@HansenPartnership.com>  writes:
>
>> On Thu, 2016-04-28 at 16:00 -0700, W. Trevor King wrote:
>>> On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
>>>> /etc/usernamespaces
>>>>
>>>> and the format be :::
>>>>
>>>> …
>>>>
>>>> If this sounds OK to people, I can code up a utility that does this,
>>>> which should probably belong in util-linux.
>>> This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].
>>>
>>> Cheers,
>>> Trevor
>>>
>>> [1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c69588f4c1be08589b8d3475a520
>>> [2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
>>> [3]: http://man7.org/linux/man-pages/man5/subuid.5.html
>> I think that mostly works.  No-one's packaging it yet, which is why I
>> didn't notice.  It also looks like the build dependencies have vastly
>> expanded, so I can't get it to build in the build service yet.
>
> Both Fedora and Ubuntu should be packaging it.  Further Docker should
> already be using these files.
Yes, based on our discussion in the PRs when user namespaces 
capabilities were added to Docker, we respect the /etc/sub{u,g}id files 
for sourcing mappings for userns-confined processes.

- Phil
