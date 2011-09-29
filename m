Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52814 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab1I2VGK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Sep 2011 17:06:10 -0400
Received: by vcbfk10 with SMTP id fk10so838500vcb.19
        for <util-linux@vger.kernel.org>; Thu, 29 Sep 2011 14:06:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Thu, 29 Sep 2011 23:06:09 +0200
Message-ID: <CAG27Bk1KR_OKDavZV+vLspWEFQBz71ggGcif+1ir6VG7eEQKmw@mail.gmail.com>
Subject: [pull] retire mandoc groff syntax
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The first patch is a reclassification of two utilities to say they are
system administration manuals, not user commands. Does that make
sense? If not drop the patch.

Second patch is tiny style fix, and the rest is about retiring mandoc syntax.

The following changes since commit faa9d6431f831bcf6b6f3d962da7451a4d3e9e7f:

  tests: add loopdev libmount test (2011-09-29 20:50:27 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit manuals

Sami Kerola (15):
      docs: chcpu and readprofile are sysadmin utils
      docs: fix return value table in fsck.8
      docs: align vipw.8 with howto-man-page.txt
      docs: align logger.1 with howto-man-page.txt
      docs: align renice.1 with howto-man-page.txt
      docs: align script.1 with howto-man-page.txt
      docs: align scriptreplay.1 with howto-man-page.txt
      docs: align wall.1 with howto-man-page.txt
      docs: align col.1 with howto-man-page.txt
      docs: align colcrt.1 with howto-man-page.txt
      docs: align colrm.1 with howto-man-page.txt
      docs: align more.1 with howto-man-page.txt
      docs: align rev.1 with howto-man-page.txt
      docs: align ul.1 with howto-man-page.txt
      docs: align hexdump.1 with howto-man-page.txt

 fsck/fsck.8                                |   58 ++--
 login-utils/vipw.8                         |   76 ++--
 misc-utils/logger.1                        |  176 +++++-----
 sys-utils/Makefile.am                      |    2 +-
 sys-utils/{chcpu.1 => chcpu.8}             |    2 +-
 sys-utils/{readprofile.1 => readprofile.8} |    3 +-
 sys-utils/renice.1                         |  180 ++++------
 term-utils/script.1                        |  189 +++++-----
 term-utils/scriptreplay.1                  |  192 ++---------
 term-utils/wall.1                          |   92 +++---
 text-utils/col.1                           |  180 +++++-----
 text-utils/colcrt.1                        |  119 +++----
 text-utils/colrm.1                         |   69 ++--
 text-utils/hexdump.1                       |  525 ++++++++++++++--------------
 text-utils/more.1                          |  285 +++++++++-------
 text-utils/rev.1                           |   40 +--
 text-utils/ul.1                            |  137 ++++----
 17 files changed, 1109 insertions(+), 1216 deletions(-)
 rename sys-utils/{chcpu.1 => chcpu.8} (98%)
 rename sys-utils/{readprofile.1 => readprofile.8} (98%)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
