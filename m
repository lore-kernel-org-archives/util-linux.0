Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33802 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbEJRUo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 May 2015 13:20:44 -0400
Received: by obfe9 with SMTP id e9so85573568obf.1
        for <util-linux@vger.kernel.org>; Sun, 10 May 2015 10:20:44 -0700 (PDT)
Message-ID: <554F936B.3010305@gmail.com>
Date: Sun, 10 May 2015 12:20:43 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org> <55489D6D.9010303@draigBrady.com> <20150510152844.GJ30924@vapier>
In-Reply-To: <20150510152844.GJ30924@vapier>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On 05 May 2015 11:37, Pádraig Brady wrote:
>> On 04/05/15 04:51, Mike Frysinger wrote:
>>> From: Mike Frysinger <vapier@chromium.org>
>>>
>>> The symlink generation tries to write to the sys-utils/ subdir but does
>>> not make sure that dir exists.  This can sometimes lead to parallel build
>>> failures when building out-of-tree
>>
>>>   $(SETARCH_MAN_LINKS):
>>> +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
>>>   	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
>>>
>>>   install-exec-hook-setarch:
>>
>> The `test -d ... ||` bit is racy and redundant I think
>
> i noticed that, but i didn't bother fixing it -- i just copied & pasted from an
> earlier fix in this project which used the same exact line
>
> note: it's really only racy if mkdir itself fails internally, and i'm kind of
> the opinion that mkdir itself should be handling this
> -mike

Why do the test at all?  Why not just a simple `mkdir -p $(dir $@)` ?

   -- Bruce

