Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33468 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3ASAJR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:17 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so3441459wib.9
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/22] tests: lots of tests
Date: Sat, 19 Jan 2013 00:08:49 +0000
Message-Id: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel, and everyone,

While back I where politely asked to write regression tests...

http://comments.gmane.org/gmane.linux.utilities.util-linux-ng/7005

...and here is few.  As everyone can see there are also couple non-tests
patches.  Here's explanation about them.

The 0001 is about ignoring coverage files.  To me it makes sense to check
the coverage report after writing a check to verify code lines where ran
by the test.

The 0009 is a go-around to reach more(1) code.  The command did not seem
to want behave same way for script as it did for terminal, which made
validation bit difficult.

The 0013 became to be after a crash with dmesg when I used unexpected
input.  I have a hunch kernel buffer might never have values out of
bound, but perhaps it is best to check than rely on how thing should be.

While writing fallocate check I realized mkswap manual is still
recommending to use dd if=/dev/null of=swapfile creation.  Is there any
reason why fallocate, the patch 0017, would not be more recommendable?

During dmesg testing I notice --color not working as I (as user) thought
it should.  Problem was that one had to combine --color with either
--facility, --console-level, or --decode.  IMHO when --color is asked,
one should get colors regardless if there are or aren't other options in
use.  The 0020 fixes the issue.

Finally the 0022 will sort the tests/commands.sh list.  I like sorted
list; they are quick to find items, and you always know add the new ones.

Thats' that about tests this time.


The following changes since commit b4ec4573dfa41b81668e141921cf00e6123234bc:

  mount: make --verbose more verbose about propagation (2013-01-15 16:09:07 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk02

for you to fetch changes up to 271dd9b59d7d66d8f8f0890a32e7e71683fd957a:

  tests: sort commands strings (2013-01-18 23:37:35 +0000)

----------------------------------------------------------------
Sami Kerola (22):
      build-sys: add gcov files to .gitignore
      tests: add rev(1) check
      tests: add utmpdump(1) check
      tests: add getopt(1) check
      tests: add mcookie(1) check
      tests: add tailf(1) check
      tests: add ul(1) check
      tests: add ionice(1) check
      more: allow non-interactive invocation of the command
      tests: add more(1) check
      tests: add line(1) check
      tests: add dmesg(1) check
      dmesg: add boundary check to facility & level array usage
      tests: add setsid(1) check
      tests: add setarch(8) check
      tests: add fallocate(1) check
      docs: mkswap.8: recommend fallocate(1)
      tests: add isosize(1) check
      tests: add whereis(1) check
      dmesg: parse level when --color is used
      tests: add ipcmk(1) and ipcrm(1) checks
      tests: sort commands strings

 .gitignore                          |   3 ++
 disk-utils/mkswap.8                 |   2 +-
 sys-utils/dmesg.c                   |   6 ++-
 tests/commands.sh                   |  69 +++++++++++++-----------
 tests/expected/dmesg/console-levels | 104 +++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/decode         | 105 ++++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/delta          | 105 ++++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/facilities     |  96 +++++++++++++++++++++++++++++++++
 tests/expected/ipcs/mk-rm-msg       |   2 +
 tests/expected/ipcs/mk-rm-sem       |   2 +
 tests/expected/ipcs/mk-rm-shm       |   2 +
 tests/expected/isosize/print-size   |   1 +
 tests/expected/misc/fallocate       |   1 +
 tests/expected/misc/getopt          |   9 ++++
 tests/expected/misc/ionice          |   9 ++++
 tests/expected/misc/line            |   1 +
 tests/expected/misc/mcookie         |   1 +
 tests/expected/misc/rev             |   1 +
 tests/expected/misc/setarch         |   1 +
 tests/expected/misc/setsid          |   1 +
 tests/expected/misc/ul              |   3 ++
 tests/expected/misc/whereis         |   1 +
 tests/expected/more/regexp          |   4 ++
 tests/expected/more/squeeze         |   3 ++
 tests/expected/tailf/simple         |   2 +
 tests/expected/utmpdump/to-binary   | Bin 0 -> 3840 bytes
 tests/expected/utmpdump/to-text     |  10 ++++
 tests/ts/dmesg/console-levels       |  25 +++++++++
 tests/ts/dmesg/decode               |  23 ++++++++
 tests/ts/dmesg/delta                |  23 ++++++++
 tests/ts/dmesg/facilities           |  25 +++++++++
 tests/ts/dmesg/input                | 105 ++++++++++++++++++++++++++++++++++++
 tests/ts/ipcs/functions.sh          |  17 ++++++
 tests/ts/ipcs/mk-rm-msg             |  36 +++++++++++++
 tests/ts/ipcs/mk-rm-sem             |  36 +++++++++++++
 tests/ts/ipcs/mk-rm-shm             |  36 +++++++++++++
 tests/ts/isosize/print-size         |  25 +++++++++
 tests/ts/isosize/sample.iso.gz      | Bin 0 -> 632 bytes
 tests/ts/misc/fallocate             |  25 +++++++++
 tests/ts/misc/getopt                |  46 ++++++++++++++++
 tests/ts/misc/ionice                |  28 ++++++++++
 tests/ts/misc/line                  |  24 +++++++++
 tests/ts/misc/mcookie               |  26 +++++++++
 tests/ts/misc/rev                   |  24 +++++++++
 tests/ts/misc/setarch               |  23 ++++++++
 tests/ts/misc/setsid                |  23 ++++++++
 tests/ts/misc/ul                    |  24 +++++++++
 tests/ts/misc/whereis               |  28 ++++++++++
 tests/ts/more/regexp                |  24 +++++++++
 tests/ts/more/squeeze               |  24 +++++++++
 tests/ts/tailf/simple               |  29 ++++++++++
 tests/ts/utmpdump/binary            | Bin 0 -> 3840 bytes
 tests/ts/utmpdump/text              |  10 ++++
 tests/ts/utmpdump/to-binary         |  23 ++++++++
 tests/ts/utmpdump/to-text           |  23 ++++++++
 text-utils/more.1                   |   5 ++
 text-utils/more.c                   |  17 +++---
 57 files changed, 1281 insertions(+), 40 deletions(-)
 create mode 100644 tests/expected/dmesg/console-levels
 create mode 100644 tests/expected/dmesg/decode
 create mode 100644 tests/expected/dmesg/delta
 create mode 100644 tests/expected/dmesg/facilities
 create mode 100644 tests/expected/ipcs/mk-rm-msg
 create mode 100644 tests/expected/ipcs/mk-rm-sem
 create mode 100644 tests/expected/ipcs/mk-rm-shm
 create mode 100644 tests/expected/isosize/print-size
 create mode 100644 tests/expected/misc/fallocate
 create mode 100644 tests/expected/misc/getopt
 create mode 100644 tests/expected/misc/ionice
 create mode 100644 tests/expected/misc/line
 create mode 100644 tests/expected/misc/mcookie
 create mode 100644 tests/expected/misc/rev
 create mode 100644 tests/expected/misc/setarch
 create mode 100644 tests/expected/misc/setsid
 create mode 100644 tests/expected/misc/ul
 create mode 100644 tests/expected/misc/whereis
 create mode 100644 tests/expected/more/regexp
 create mode 100644 tests/expected/more/squeeze
 create mode 100644 tests/expected/tailf/simple
 create mode 100644 tests/expected/utmpdump/to-binary
 create mode 100644 tests/expected/utmpdump/to-text
 create mode 100755 tests/ts/dmesg/console-levels
 create mode 100755 tests/ts/dmesg/decode
 create mode 100755 tests/ts/dmesg/delta
 create mode 100755 tests/ts/dmesg/facilities
 create mode 100644 tests/ts/dmesg/input
 create mode 100755 tests/ts/ipcs/mk-rm-msg
 create mode 100755 tests/ts/ipcs/mk-rm-sem
 create mode 100755 tests/ts/ipcs/mk-rm-shm
 create mode 100755 tests/ts/isosize/print-size
 create mode 100644 tests/ts/isosize/sample.iso.gz
 create mode 100755 tests/ts/misc/fallocate
 create mode 100755 tests/ts/misc/getopt
 create mode 100755 tests/ts/misc/ionice
 create mode 100755 tests/ts/misc/line
 create mode 100755 tests/ts/misc/mcookie
 create mode 100755 tests/ts/misc/rev
 create mode 100755 tests/ts/misc/setarch
 create mode 100755 tests/ts/misc/setsid
 create mode 100755 tests/ts/misc/ul
 create mode 100755 tests/ts/misc/whereis
 create mode 100755 tests/ts/more/regexp
 create mode 100755 tests/ts/more/squeeze
 create mode 100755 tests/ts/tailf/simple
 create mode 100644 tests/ts/utmpdump/binary
 create mode 100644 tests/ts/utmpdump/text
 create mode 100755 tests/ts/utmpdump/to-binary
 create mode 100755 tests/ts/utmpdump/to-text


