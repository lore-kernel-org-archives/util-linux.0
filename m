Return-Path: util-linux-owner@vger.kernel.org
Received: from vhrz24.HRZ.Uni-Marburg.DE ([137.248.1.34]:53158 "EHLO
	vhrz24.HRZ.Uni-Marburg.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbbHIROx convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 13:14:53 -0400
Subject: Re: "mesg n" exits with error, even if the command is successful
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Reuti <reuti@staff.uni-marburg.de>
In-Reply-To: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
Date: Sun, 9 Aug 2015 19:14:30 +0200
Cc: util-linux@vger.kernel.org, ah-util-linux@debian.org,
        794727@bugs.debian.org, 794727-forwarded@bugs.debian.org
Message-Id: <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
To: Santiago Vila <sanvila@unex.es>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Am 09.08.2015 um 17:04 schrieb Santiago Vila:

> Hello.
> 
> [ Apologies if this is a FAQ ].
> 
> Debian has recently switched the "mesg" implementation from
> the one in sysvinit to the one in util-linux.
> 
> We have found a subtle issue: The old mesg didn't have any error codes
> at all. The new mesg (from util-linux) has the following error codes:
> 
>            0     Messages are allowed.
> 
>            1     Messages are not allowed.
> 
>> 1     An error has occurred.
> The problem is that those error codes are in effect not only when
> the mesg command is invoked alone:
> 
> mesg
> 
> but also when it's used with an argument:
> 
> mesg y
> mesg n
> 
> This breaks the default /root/.profile which has a simple "mesg n" at

The profile is usually sourced. How does the error show up at the login prompt on Debian?

-- Reuti


> the end, so we will probably have to hide the error like this:
> 
> mesg n || true
> 
> but this is a little bit weird and I wonder how much people will have
> to do this as well.
> 
> In Unix, usually, whenever I tell a command to do something, there is
> only an error when the command is not able to do what I ask it to do.
> 
> In this case, however, the "mesg n" is succesful, as it is actually
> able to disable write to the terminal, and yet it exits with an error.
> 
> I think this does not make much sense and would humbly propose that
> the behaviour is changed so that error codes are only used when
> the mesg is used alone, without any arguments.
> 
> Surely that a change like this might in theory break some scripts,
> but let's see what kind of breakage we could expect:
> 
> * People who write this:
> 
> mesg y
> 
> will not need to change anything.
> 
> * People who write this:
> 
> mesg n || true
> 
> will finally be able to remove the "|| true" part. If they don't
> remove the "|| true" part, nothing really bad will happen.
> 
> In fact, this could even improve things a little bit, as "mesg" alone
> will fail if the mesg does not exist.
> 
> * People writing things like this:
> 
> if mesg 2> /dev/null; then
>  echo mesg is y
> else
>  echo mesg is n
> fi
> 
> which is where exit codes are actually useful, will not be affected at
> all.
> 
> Of course one can always create a complex use case where a change in
> exit codes would break the script, but I think those would be a very
> small minority.
> 
> So: Would you please consider a change in mesg behaviour regarding
> exit codes, so that "mesg n" does not gratuitously fail?
> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

