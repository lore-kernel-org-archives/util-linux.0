Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.24]:59300 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaDTPgd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Apr 2014 11:36:33 -0400
Message-ID: <5353E97D.5010603@bernhard-voelker.de>
Date: Sun, 20 Apr 2014 17:36:29 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 7/9] tests: check kill all user processes
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>	<1397560535-14622-8-git-send-email-kerolasa@iki.fi>	<20140416101308.GG5786@x2.net.home> <CAG27Bk0oL7rEh-uDH7A6J5sofE+XrXcK-kavtOBiXQiF0JCjwA@mail.gmail.com>
In-Reply-To: <CAG27Bk0oL7rEh-uDH7A6J5sofE+XrXcK-kavtOBiXQiF0JCjwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/20/2014 11:53 AM, Sami Kerola wrote:
> On 16 April 2014 11:13, Karel Zak <kzak@redhat.com> wrote:
>> On Tue, Apr 15, 2014 at 12:15:33PM +0100, Sami Kerola wrote:
>>> +HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
>>> +ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
>>> +trap "rm -f $HELPER_SYMLINK" 0
>>> +
>>> +su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &
>>
>> I don't understand this idea, on my system Mr.Nobody can not write
>> to my directories.
>>
>> It would be also better to add --setgit and --setuid to the helper to
>> avoid extra su(1) process, then you can use TEST_PID=$!
> 
> The --setuid is added, [...]

yes, setuid is a great idea, yet I'm not sure
if using UID 1 is a good idea:

		if (setuid(1) < 0)
			err(TEST_SIGRECEIVE_FAILURE, "setuid failed");

Doesn't everyone hack&build under his own private user account?
So maybe that would be the best choice (if the kill-test doesn't
kill random processes of the user.
Anyone a better idea?

>>> +# test_sigreceive needs time to start up
>>> +for i in 0.01 0.1 1 1 1 1; do
>>> +     test -f "$TS_CWD/nobody" && { up=1; break; }
>>> +     sleep $i
>>> +done
>>
>> The question is if we really need to use the PID files. Would be
>> possible to use test_sigreceive that does not write anything?
>>
>> You can for example to use
>>
>>    awk '/SigCgt/ { print $2}' /proc/<pid>/status
>>
>> to check if the signal handlers are already initialized (the final
>> mask is 800000027ffbfeff on my system).


> That is a much better way to determine if the process is ready to be
> killed. Implemented in my git, and I have only one remaining question.

I'm not a big fan of magic numbers. Is there a chance to narrow down
the relevant bits?

Have a nice day,
Berny
