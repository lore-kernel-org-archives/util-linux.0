Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbaDVKJ2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Apr 2014 06:09:28 -0400
Date: Tue, 22 Apr 2014 12:09:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 7/9] tests: check kill all user processes
Message-ID: <20140422100920.GB2405@x2.net.home>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
 <1397560535-14622-8-git-send-email-kerolasa@iki.fi>
 <20140416101308.GG5786@x2.net.home>
 <CAG27Bk0oL7rEh-uDH7A6J5sofE+XrXcK-kavtOBiXQiF0JCjwA@mail.gmail.com>
 <5353E97D.5010603@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5353E97D.5010603@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 20, 2014 at 05:36:29PM +0200, Bernhard Voelker wrote:
> On 04/20/2014 11:53 AM, Sami Kerola wrote:
> > On 16 April 2014 11:13, Karel Zak <kzak@redhat.com> wrote:
> >> On Tue, Apr 15, 2014 at 12:15:33PM +0100, Sami Kerola wrote:
> >>> +HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
> >>> +ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
> >>> +trap "rm -f $HELPER_SYMLINK" 0
> >>> +
> >>> +su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &
> >>
> >> I don't understand this idea, on my system Mr.Nobody can not write
> >> to my directories.
> >>
> >> It would be also better to add --setgit and --setuid to the helper to
> >> avoid extra su(1) process, then you can use TEST_PID=$!
> > 
> > The --setuid is added, [...]
> 
> yes, setuid is a great idea, yet I'm not sure
> if using UID 1 is a good idea:
> 
> 		if (setuid(1) < 0)
> 			err(TEST_SIGRECEIVE_FAILURE, "setuid failed");

 Hmm, I though about non-hardcoded uid

    --seruid <uid>

 or so...  BTW, we have

   tests/commands.sh:TS_TESTUSER=${TS_TESTUSER:-"test"}

 maybe we can use "nobody" rather than the "test", and if the
 $TS_TESTUSER does not exist then ts_skip the test. Currently the
 $TS_TESTUSER is nowhere used.

> >>    awk '/SigCgt/ { print $2}' /proc/<pid>/status
> >>
> >> to check if the signal handlers are already initialized (the final
> >> mask is 800000027ffbfeff on my system).
> 
> 
> > That is a much better way to determine if the process is ready to be
> > killed. Implemented in my git, and I have only one remaining question.
> 
> I'm not a big fan of magic numbers. Is there a chance to narrow down
> the relevant bits?

 Good point, hardcoded mask is probably bad idea as we use #ifdefs for
 the signals in the code.

 We don't have to test whole mask, just test for the last signal used
 in the test_sigreceive.c, for example if the last signal specified
 by sigaction() in the code is SIGHUP (=1), then


    sigmask=$((16#$( awk '/SigCgt/ { print $2}' /proc/$TEST_PID/status) ))

    if [ $(( $sigmask & 1 )) == 1 ]; then
       echo "yes, test program is ready"
    fi

 is enough.


 Note that now the code add SIGHUP as the first thing to the mask.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
