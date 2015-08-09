Return-Path: util-linux-owner@vger.kernel.org
Received: from vhrz24.HRZ.Uni-Marburg.DE ([137.248.1.34]:55817 "EHLO
	vhrz24.HRZ.Uni-Marburg.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbbHIU47 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 16:56:59 -0400
Subject: Re: "mesg n" exits with error, even if the command is successful
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Reuti <reuti@staff.uni-marburg.de>
In-Reply-To: <20150809191119.GA29884@cantor.unex.es>
Date: Sun, 9 Aug 2015 22:56:35 +0200
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>,
        ah-util-linux@debian.org, 794727@bugs.debian.org
Message-Id: <6EE89D62-E143-4F95-85E4-B1CE98558E9F@staff.uni-marburg.de>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es> <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de> <20150809171906.GA27138@cantor.unex.es> <CAG27Bk2LoBzp122dkL7npkMSa0iEEVajE3EqMVFYnPbn5zDBHA@mail.gmail.com> <20150809191119.GA29884@cantor.unex.es>
To: Santiago Vila <sanvila@unex.es>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 09.08.2015 um 21:11 schrieb Santiago Vila:

> On Sun, Aug 09, 2015 at 06:58:15PM +0100, Sami Kerola wrote:
>> On 9 August 2015 at 18:19, Santiago Vila <sanvila@unex.es> wrote:
>>> On Sun, Aug 09, 2015 at 07:14:30PM +0200, Reuti wrote:
>>>> The profile is usually sourced. How does the error show up at the login prompt on Debian?
>>> 
>>> The problem only happens in Debian testing and unstable, which I am not using yet.
>>> This is the original report which I received against base-files:
>>> 
>>> https://bugs.debian.org/794727
>> 
>> Please notice the mesg(1) exit behavior is defined in POSIX
>> 
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/mesg.html
>> 
>> Unfortunately the standard does not appear to be explicit whether the
>> exit value should be set only when requesting write permissions
>> (running without arguments), or if also when setting the permissions.
> 
> So if the standard is not explicit about this, there is some room for
> interpretation. Would not be possible to interpret the standard in a
> sensible way?

Two things I noted:

- on my Mac with 10.6/10.10 it's implemented in the same way it is in linux-util right now - how is it implemented in AIX or FreeBSD?

- the initial issue on the Debian list not being able to do `ssh <hostname> bash -lex test.sh` does not show up for me or I got it in the wrong way (from Mac to Linux openSUSE), the script is executed despite there being a ~/.profile with the `mesg n` command. But it shows an other error which I output in a called script:

===== test.sh =====
echo $?
echo Hello
===== end =====

...
+ mesg n
mesg: ttyname failed: Invalid argument
+ echo 2
+ echo Hello



So, I have to use:

if tty >/dev/null; then mesg n; fi

in ~/.profile to avoid this error.

-- Reuti

PS:  The same behavior one can find in `biff`with a similar function - there is a difference: as `biff` is asynchron, there may be a delay. Hence checking $? may still show the former state and the state has to be checked again in this case.



> Moreover: Would not be possible to ask for the standard to be clarified?
> 
>> IMHO the reasonable thing to do is to leave the return codes as they
>> are to avoid breakage in existing usage. If someone needs messaging
>> setting not to report exit codes [...]
> 
> Hmm, but who does really need message *setting* to report exit codes?
> They make more harm than help.
> 
> As explained before, if I do "mesg y" I can reasonably think that
> messages will be enabled after that, and if I do "mesg n" I can
> reasonably think that messages will be disabled after that.
> 
> I don't need an exit code for that, unless I don't trust the program
> to do its job, and this is why I think there is no need to interpret
> the standard so strictly.
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

