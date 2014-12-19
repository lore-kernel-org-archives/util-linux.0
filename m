Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34610 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaLSJwl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 04:52:41 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so1317379wiv.6
        for <util-linux@vger.kernel.org>; Fri, 19 Dec 2014 01:52:39 -0800 (PST)
Date: Fri, 19 Dec 2014 09:52:38 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
cc: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 00/10] pull: AddressSanitizer round II
In-Reply-To: <CAG27Bk1K3_aXM5KCVkT5SJE_vLsx+vBE=VF9PYY04QbYQ+-=eQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.03.1412190950570.8955@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <20141215091540.GV19904@x2.net.home> <CAG27Bk1K3_aXM5KCVkT5SJE_vLsx+vBE=VF9PYY04QbYQ+-=eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 15 Dec 2014, Sami Kerola wrote:

> On 15 December 2014 at 09:15, Karel Zak <kzak@redhat.com> wrote:
>> On Sun, Nov 30, 2014 at 01:57:32PM +0000, Sami Kerola wrote:
>>> Here comes the second set of changes to enable AddressSanitizer one day
>>> in future.  These changed does not include update to travis-functions, as
>>> demonstrated below, due reason explained later.  The environment changes
>>> in the diff are useful for other who want to try ASAN compilations.
>>
>> Hi Sami, do you plan to update these patches? I'd like to release -rc1
>> this month :-)
>
> Hi Karel,
>
> Sorry, I have been a bit lazy with ASAN patch series. I'll try to do
> the required small fixes in beginning part of the week, and send
> replies what was changed.

Hi Karel and others,

I think I replied to all feedback. Please inform if I missed something. 
And especially if after the new updates the changes are still wrong, 
incomplete, broken, ...

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
