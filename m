Return-Path: tytso@thunk.org
Date: Wed, 07 Mar 2012 16:01:11 -0500
Message-Id: <E1S5Nyx-0003tY-M1@tytso-glaptop.cam.corp.google.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng@vger.kernel.org
Subject: Dealing with overly verbose fsck output
From: "Theodore Ts'o" <tytso@mit.edu>
List-ID: <util-linux.vger.kernel.org>

I've recently come accross an interesting problem which is caused by a
file system corruption which causes e2fsck to emit a huge amount of
detail.  The verobosity is useful in some cases for debugging things, so
I don't want to eliminate the output.  However, I'd like to squelch the
output being sent to the console if it exceeds some limit, because if
the system has a serial console attached, this can slow down the boot
sequence such that a watchdog timer that detects if the system hasn't
completed its boot sequence in a reasonable amount of time can kick in
and kill off the machine.  I'd still like the e2fsck log output to get
saved to a file, however.

Would patches that extended Frank Mayhar's work so that we can set some
threshold after which the console gets a "output squelched; see log file
XXXX for the rest" be something you'd be receptive to?   I think this is
a situation that is generally applicable to more than just at Google ---
lots of enterprise customers use serial consoles, and will run into the
same annoyance --- but if you think this is adding too much complexity
into fsck, I'll understand...

-- Ted

P.S.  Most unfortunately, Frank has had to go on medical leave, so he
asked me to take over getting his patches upstreamed.  If there are any
changes you'd like me to make to the patches which he submitted, please
let me know.
