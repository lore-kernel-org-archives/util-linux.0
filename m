Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab2IKSCH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 14:02:07 -0400
Message-ID: <504F7C9A.1000904@draigBrady.com>
Date: Tue, 11 Sep 2012 19:02:02 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
CC: Ondrej Oprala <ooprala@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: segfault message supressed with su -c
References: <504F5246.4030304@redhat.com> <A75C39900FCF0B42A2CE8B26F837D2C305BB3C@MCHP02MSX.global-ad.net>
In-Reply-To: <A75C39900FCF0B42A2CE8B26F837D2C305BB3C@MCHP02MSX.global-ad.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/11/2012 05:19 PM, Voelker, Bernhard wrote:
> Ondrej Oprala wrote:
>> Hi,
>> I've written a tiny patch that should fix this issue with su:
>> https://bugzilla.redhat.com/show_bug.cgi?id=747592.
>> None of the shells' output propagates back
>> to the shell where su was called (except TCSH, which reports segfault
>> to stdout; I've tested this with sh,ksh,zsh,bash).
>> So, with this patch, su should print a warning if
>> WIFSIGNALED(status)&&  WCOREDUMP(status) is true.
>
> Good catch!
>
>> +	      fprintf (stderr, _("Segmentation fault (core dumped)\n"));
>
> Maybe the error message should point out that it
> was not su which dumped core ... ;-)

Maybe not. Consider:

monitor_1 timeout 2 'su -c command'

You might as well just say "core dumped",
and leave the investigation as to what
cored exactly to inspection of the core file.

cheers,
Pádraig.
