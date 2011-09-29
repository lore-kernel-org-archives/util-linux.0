Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45533 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1I2VAv convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Sep 2011 17:00:51 -0400
Received: by vws1 with SMTP id 1so850848vws.19
        for <util-linux@vger.kernel.org>; Thu, 29 Sep 2011 14:00:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Thu, 29 Sep 2011 23:00:50 +0200
Message-ID: <CAG27Bk1tpBCE4+15YnKFR6vkOsxj_mUm0v4b9gV8nFsKEM2S1w@mail.gmail.com>
Subject: [pull] more sys-utils improvements
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit faa9d6431f831bcf6b6f3d962da7451a4d3e9e7f:

  tests: add loopdev libmount test (2011-09-29 20:50:27 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit sys-utils-again

Sami Kerola (18):
      docs: align fallocate.1 with howto-man-page.txt
      flock: fix coding style
      flock: move long_options struct to function scope
      flock: use libc error printing facilities
      flock: align with howto-usage-function.txt
      flock: use function attributes
      flock: use sysexit.h for all exit values
      flock: use strutils.h to check numeric user input
      lib: [strutils] add strtod_or_err() function
      flock: simplify strtotimeval()
      docs: restructure flock.1 manual page
      cytune: add long options and usage()
      cytune: check numeric user inputs
      cytune: use libc error printing facilities
      cytune: refactor main(), new function query_tty_stats()
      cytune: coding style fixes
      docs: mention long options in cytune.8
      cytune: fix printf type warning

 include/strutils.h    |    1 +
 lib/strutils.c        |   24 ++
 sys-utils/Makefile.am |    3 +-
 sys-utils/cytune.8    |  111 ++++----
 sys-utils/cytune.c    |  733 +++++++++++++++++++++++++------------------------
 sys-utils/fallocate.1 |   26 +-
 sys-utils/flock.1     |  124 ++++++---
 sys-utils/flock.c     |  538 +++++++++++++++++-------------------
 8 files changed, 807 insertions(+), 753 deletions(-)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
