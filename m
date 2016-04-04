Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <201604041107.12672.sweet_f_a@gmx.de>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
	<20160404002100.eqclqk2rqbttbued@ws.net.home>
	<20160404082749.tqyzkgyba2ed77kr@ws.net.home>
	<201604041107.12672.sweet_f_a@gmx.de>
Date: Mon, 4 Apr 2016 15:43:23 +0100
Message-ID: <CAG27Bk3r9kEX+83wxXaSGyZ8driZgKO+0mESd7hD+tCkY8TGsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] chrt: make --sched-* short options to require an argument
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 4 April 2016 at 10:07, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Monday 04 April 2016, Karel Zak wrote:
>> On Mon, Apr 04, 2016 at 02:21:00AM +0200, Karel Zak wrote:
>> > On Sun, Apr 03, 2016 at 09:35:27AM +0100, Sami Kerola wrote:
>> > > These options are expecting an argument, and the long options
>> > > struct already required them.
>> >
>> >  Good catch, but deadline and runtime should be optional arguments
>> > (it seems I have merged wrong version of my patch:-(
>>
>> Sorry, didn't read the patch correctly. You're right. Applied,
>> thanks.
>
> BTW I like the coreutils convention that new options with optional
> arguments should be long options only. This is less confusing for the
> users.

Makes sense, and if Karel agrees Documentation/* files need updating.

BTW the debian bug 791707 that was the reason why I even started to look
chrt is pretty good indication the command is not easy to use or understand.
To me the command is pretty unintuitive, for example

$ chrt --pid --rt 0 foobar $$

is perfectly OK way to change scheduling policy of the running shell, and
foobar is ignored.  I don't quite understand why the --pid makes only the
last argument to be used, while it could use all arguments the getopts() did
eat.  But even so the interface stays quirky as the argument order is

$ chrt <options> <priority> <target>

for example

$ chrt --pid 0 $$

But fixing that cannot be done without breaking ABI, and such change cannot
be approved.  So should the util-linux v2.29 (or perhaps v3.0 as the numbers
are getting a bit large) have new tools:

$ rtctl
$ lsrt

Where the former has expected interface using options as people normally see
them.  For example:

$ rtctl --priority 0 --policy rt --exec 'ls /etc' --pid $$

In above --exec or --pid can be used more than once, but 'settings' type options
should not be allowed more than one instance to avoid confusions.

And 'lsrt' would be for displaying the stuff rtctl is controlling.

Comments?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
