Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64917 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3ALJB3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Jan 2013 04:01:29 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so1426910pad.34
        for <util-linux@vger.kernel.org>; Sat, 12 Jan 2013 01:01:29 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <87ehhrnzdo.fsf@xmission.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home> <87ehhrnzdo.fsf@xmission.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sat, 12 Jan 2013 10:01:09 +0100
Message-ID: <CAKgNAkgYRaE8ia9s2yHECqNX0AWiZoDW+gB66htPJwZzMD0A4w@mail.gmail.com>
Subject: Re: [PATCH] enter: new command (light wrapper around setns)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 11:11 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Karel Zak <kzak@redhat.com> writes:
>
>> On Fri, Jan 11, 2013 at 02:29:24AM -0800, Eric W. Biederman wrote:
>>>
>>> Inspired by unshare, enter is a simple wrapper around setns that
>>> allows running a new process in the context of an existing process.
>>
>>  It would be really nice to have "ns" in the name -- for example
>>  "enterns" sounds good.
>
> enterns might work.  I am still trying to reconcile that name with
> changing the working directory and the root directory.  Those really
> aren't namespaces.
>
> But name slightly less generic seems to be the popular vote.  Short of
> something better my vote is for nsenter.  enterns sounds way too much
> like interns which has a rather different meaning.

"nsenter" sounds good to me.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/
