Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.95]:48822 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3A0PrM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jan 2013 10:47:12 -0500
Message-ID: <51054B8E.2000205@zoho.com>
Date: Sun, 27 Jan 2013 16:45:18 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?=
	<zbyszek@in.waw.pl>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd
 and root
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl> <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl> <20130125150210.GL27413@x2.net.home> <20130125163924.GT4278@in.waw.pl> <87pq0tjgx9.fsf@xmission.com>
In-Reply-To: <87pq0tjgx9.fsf@xmission.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Eric W. Biederman writes:
> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
>>>  Not sure if this is the right argument. From my point of view it's
>>>  better to be explicit for such things, something like --all sounds
>>>  like a magical blackbox where semantic depends on features implemented
>>>  by kernel and nsenter(1). 
> 
> Which is the reason I did not implement --all in the first place,
> although it is attractive.
> 
>> Hi,
>>
>> I'm was trying to document how a user should enter a namespace
>> container created by systemd-nspawn. I would prefer not to have the
>> user type 'nsenter -t $PID -muipn', but something simpler.
> 
> As I see it nsenter is the raw tool for when you need to get your
> hands dirty.  lxc already has a more integrated version.  And
> it isn't hard to define a simple wrapper such as:
> 
> cat > systemd-nsenter <<EOF
> #!/bin/sh
> PID=$1
> shift
> exec nsenter -t $PID --mount --ipc --pid --net --uts "$@"
> EOF
> 
> If you need things to be slightly simpler and it isn't worth deriving
> your own c wrapper.

Except that when you are distributing such script (eg. an init-like
script), your shell script will need to add code detecting which
namespaces the kernel supports (and adding appropiate flags to nsenter)
and checking if your nsenter version supports them or not.

It's better to have --all to enter all namespaces that nsenter supports.
If you want to, it could print a warning when using --all and nsenter
knows about more namespaces than the kernel or if it detects that the
kernel knows about more namespaces than itself.
But having a --all to enter “as namespaces as possible” would be the
right thing IMHO.

