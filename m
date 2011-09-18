Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46137 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab1IRTiR convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 Sep 2011 15:38:17 -0400
Received: by qyk7 with SMTP id 7so5833941qyk.19
        for <util-linux@vger.kernel.org>; Sun, 18 Sep 2011 12:38:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 18 Sep 2011 21:38:17 +0200
Message-ID: <CAG27Bk2O5ynXup+P_toB4aALK+fumY61tkeEAiLZXKvwrDifTQ@mail.gmail.com>
Subject: [pull] retire mandoc syntax
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This is mostly about retiring mandoc syntax. The util-linux uses groff
man macros instead.

The following changes since commit 277a6dd53569a409e05316a7bdaed0e78e326762:

  mount: check for target before source on remount (2011-09-13 22:59:39 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit manuals

Sami Kerola (15):
      docs: chcpu and readprofile are sysadmin utils
      docs: fix return value table in fsck.8
      docs: align vipw.8 with howto-man-page.txt
      docs: align logger.1  with howto-man-page.txt
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
 text-utils/colcrt.1                        |  121 +++----
 text-utils/colrm.1                         |   69 ++--
 text-utils/hexdump.1                       |  525 ++++++++++++++--------------
 text-utils/more.1                          |  285 +++++++++-------
 text-utils/rev.1                           |   40 +--
 text-utils/ul.1                            |  137 ++++----
 17 files changed, 1110 insertions(+), 1217 deletions(-)
 rename sys-utils/{chcpu.1 => chcpu.8} (98%)
 rename sys-utils/{readprofile.1 => readprofile.8} (98%)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
