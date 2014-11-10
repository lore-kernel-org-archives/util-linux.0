Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:59883 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaKJVuB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:01 -0500
Received: by mail-wg0-f51.google.com with SMTP id l18so9915384wgh.24
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:00 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/6] pull: almost working AddressSanitizer support
Date: Mon, 10 Nov 2014 21:49:49 +0000
Message-Id: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

As said some time ago

http://markmail.org/message/xfd6u2s53jlsjoc6

the more static analysis the better.  So I to heard about AddressSanitizer
I thought why not to give it a go, to see if making it work would benefit
this project.  This patch set fixes one real issue '4/6: libmount: fix
memory overflow' and makes some noise to go away.  I am hoping to get the
AddressSanitizer to run without issues so that it could be part of travis
clang root build.

But it seems nothing is never that easy.  For some reason the mkswap(8)
refuses to work when it is build with

export CC=clang
export CFLAGS='-O1 -g -fsanitize=address -fno-omit-frame-pointer'
export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer
export LD=ld.gold

The short description is: when the code is at very last line of mkswap at
'return EXIT_SUCCESS;' somehow the EXIT_SUCCESS is 1.  If I change the
'return EXIT_SUCCESS;' to 'exit(EXIT_SUCCESS);' the return value stays
expected.  Possible explanations include:

1. I'm doing something silly and/or wrong.

2. This happens only on my laptop (or imagination).  Please, let it not
   be this.

3. This is a bug in clang, llvm, and/or AddressSanitizer.
   clang / llvm version 3.5.0 from Archlinux packages 3.5.0-2.1

4. With gcc 4.9.2 and the same CFLAGS the mkswap works.

Adding a AddressSanitizer travis build rules while having this sort of
problem going on does not sound right thing to do.  Getting a hint what
might be going on is highly appreciated.


----------------------------------------------------------------
The following changes since commit 9a83b03c7307715b45b143f203f9bf8b0bcf7a5d:
  mkswap: make final report more human readable (2014-11-07 14:03:35 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git asan
for you to fetch changes up to d07a5b79ec55bffceb6db994fc5a0ddadd8a1ca5:
  tests: mark python libmount tests known to fail with AddressSanitizer (2014-11-10 20:02:53 +0000)
----------------------------------------------------------------

Sami Kerola (6):
  build-sys: make scanf_cv_alloc_modifier to work [AddressSanitizer]
  tests: fix memory leak [AddressSanitizer]
  tests: add mkswap size printout to expected output
  libmount: fix memory overflow [AddressSanitizer]
  tests: skip kill -SEGV test when running AddressSanitizer
  tests: mark python libmount tests known to fail with AddressSanitizer

 configure.ac                       | 1 +
 lib/cpuset.c                       | 1 +
 libmount/src/utils.c               | 2 +-
 tests/expected/misc/swaplabel      | 2 +-
 tests/ts/kill/name_to_number       | 3 +++
 tests/ts/libmount/tabfiles-py      | 4 ++++
 tests/ts/libmount/tabfiles-tags    | 4 ++++
 tests/ts/libmount/tabfiles-tags-py | 4 ++++
 tests/ts/libmount/update-py        | 6 +++++-
 9 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.1.3

