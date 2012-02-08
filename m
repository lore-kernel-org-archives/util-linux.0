Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47512 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749Ab2BHJQy convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Feb 2012 04:16:54 -0500
Received: by obcva7 with SMTP id va7so530626obc.19
        for <util-linux@vger.kernel.org>; Wed, 08 Feb 2012 01:16:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 8 Feb 2012 10:16:53 +0100
Message-ID: <CAG27Bk1RXEBfo6KX4_HrAuY7AGPCCKGbFBiXdd6M5rrGU5waBw@mail.gmail.com>
Subject: autotools readability fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Just as yesterdays fix this pull request is best to leave to post
release merge queue. Meanwhile comments are welcome.

The following changes since commit 0892d88d1a3c155b2791a5137182ab98a22a7bac:

  tools: use gpg-aggent in ko-release-gen (2012-02-07 11:30:56 +0100)

are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git autotools

Sami Kerola (2):
      build-sys: remove unused function and header checks
      build-sys: enhance readability of the autotools files

 Makefile.am                          |   22 ++--
 config/include-Makefile.am           |    4 +-
 configure.ac                         |  196 +++++++++++++++++-----------------
 disk-utils/Makefile.am               |   54 +++++++--
 fdisk/Makefile.am                    |   37 +++++--
 hwclock/Makefile.am                  |    7 +-
 include/Makefile.am                  |    4 +-
 lib/Makefile.am                      |   24 +++--
 libblkid/Makefile.am                 |    1 -
 libblkid/samples/Makefile.am         |    7 +-
 libblkid/src/Makefile.am             |   86 ++++++++++-----
 libblkid/src/partitions/Makefile.am  |   33 +++---
 libblkid/src/superblocks/Makefile.am |   92 ++++++++--------
 libblkid/src/topology/Makefile.am    |   18 ++--
 libmount/src/Makefile.am             |   78 +++++++++-----
 libuuid/Makefile.am                  |    1 -
 libuuid/man/Makefile.am              |   17 +++-
 libuuid/src/Makefile.am              |   22 +++-
 login-utils/Makefile.am              |   41 ++++++--
 misc-utils/Makefile.am               |   68 ++++++++----
 mount/Makefile.am                    |   48 +++++---
 partx/Makefile.am                    |   23 ++--
 schedutils/Makefile.am               |    5 +-
 sys-utils/Makefile.am                |  102 ++++++++++++------
 tests/Makefile.am                    |    9 +-
 tests/helpers/Makefile.am            |    8 +-
 text-utils/Makefile.am               |   28 ++++-
 27 files changed, 649 insertions(+), 386 deletions(-)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
