Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Mon, 16 Mar 2015 23:55:05 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: Rainer Gerhards <rgerhards@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/8] pull: logger: add tests and fix couple issues
In-Reply-To: <20150316120631.GL28925@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503162348580.24769@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi> <CAP-up9AJwjQU8Mq5fT0wYZgv2noqz845EtVt-CiYjN=F0J8R5A@mail.gmail.com> <20150316120631.GL28925@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Mon, 16 Mar 2015, Karel Zak wrote:

> On Mon, Mar 16, 2015 at 12:28:19PM +0100, Rainer Gerhards wrote:
> > On Sun, Mar 15, 2015 at 1:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> > > Hello,
> > >
> > > Coverage of these tests is not magnificent.  None of the communications
> > > to external systems using tcp, udp, or to journald are tested, but at
> > > least some aspects of the logger(1) functionality gets to be checked -
> > > that is message formats and input validation.
> > 
> > 
> > ah! excellent. I'll also have a look to understand the nature of how
> > tests work for util-linux. Regarding tcp and udp: I guess a simple way
> > would be to use netcat? Or is that considered bad practice for
> > util-linux (as versions may differ and may interfere with test
> > results?
> 
>  We have no any strict policy for tests, it's fine to check all
>  necessary environment and versions and skip (ts_skip function) all
>  the test if necessary. 
>  
>  We have two basic modes:
>  
>  * "non-root" (make check) - this is usually for simple tests where you
>    don't need root permissions and where is it safe to call the test
>    on arbitrary machine (to make it usable for example from spec
>    files on build machines, etc.)
> 
>  * "root" - this is for dangerous tests you never want to call on
>    production system, it's never executed by build system and you
>    have to manually "cd tests; ./run.sh". This is for example for
>    mount(8), some fdisk tests etc. These tests are for developers
>    only.
> 
> 
> 
>  Note I have just committed a new --no-act logger command line option
>  to make it possible to check messages formatting without spam in
>  system logs, for example:
> 
>    $ logger --no-act --stderr --rfc5424 "This is message"
> 
>  I guess we can use it for messages formatting tests (as the tests
>  suggested by Sami).

Good midnight,

Since there is now --no-act, and the test_logger reads environment 
variables what time stamps etc to use the two commits sent earlier
with titles

tests: add logger(1) error condition tests
tests: add logger(1) message format tests

are updated in my remote repo.

https://github.com/kerolasa/lelux-utiliteetit/commit/b3d4c9862c1c12c1f1e5db5e72fe010b192ca106
https://github.com/kerolasa/lelux-utiliteetit/commit/660d2e44e5d75d98cfeb8971c7229f2c4b1d03d9

I also noticed journald messages can be sent with --no-act so I added new 
check on top of the two above. Here's the mail list version of it.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 16 Mar 2015 23:42:57 +0000
Subject: [PATCH 3/4] tests: add logger(1) journald test

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/logger/journald |  3 +++
 tests/ts/logger/journald       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/expected/logger/journald
 create mode 100755 tests/ts/logger/journald

diff --git a/tests/expected/logger/journald b/tests/expected/logger/journald
new file mode 100644
index 0000000..d4b1549
--- /dev/null
+++ b/tests/expected/logger/journald
@@ -0,0 +1,3 @@
+MESSAGE_ID=b8f74e14bc714bfc8040a5106dc9376a
+MESSAGE=a b c 1 2 3
+
diff --git a/tests/ts/logger/journald b/tests/ts/logger/journald
new file mode 100755
index 0000000..155aeae
--- /dev/null
+++ b/tests/ts/logger/journald
@@ -0,0 +1,35 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2015 Sami Kerola <kerolasa@iki.fi>
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="journald"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_LOGGER"
+
+if ! $TS_HELPER_LOGGER --help | grep -q journald; then
+	TS_KNOWN_FAIL="yes"
+fi
+
+printf "%s\n%s\n%s\n" MESSAGE_ID=b8f74e14bc714bfc8040a5106dc9376a MESSAGE="a b c 1 2 3" |
+$TS_HELPER_LOGGER --no-act --journald --stderr > "$TS_OUTPUT" 2>&1
+
+ts_finalize
-- 
2.3.3
