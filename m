Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43744 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab1KBT2p convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Nov 2011 15:28:45 -0400
Received: by eye27 with SMTP id 27so462509eye.19
        for <util-linux@vger.kernel.org>; Wed, 02 Nov 2011 12:28:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 2 Nov 2011 20:28:43 +0100
Message-ID: <CAG27Bk1acCRkXM=6wf5BRZ_Q6niOheappANqBKHiObZv86GL2g@mail.gmail.com>
Subject: [pull] third sys-utils patch set
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here's remaining usage(), howto alignment, code style fix patches
about utilities in sys-utils directory. Many of the patches are
trivial, but there are couple which I want to mention.

The switch_root did not use translations. I wonder was that
intentional, and it should not have them? If so the patch has to be
knocked out.

The ldattach usage output 'Known ... names' output tables are now
wider and shorter. IMHO that is better, since the usage is a lot
longer than it used to be. My only question is that should the output
tables be more smart,  and use tt_print_table() combined with terminal
width detection to make table as wide as possible?

Rest is ready for review.


The following changes since commit 6bac2825af7216c5471148e219dbcf62ec5ede84:

  prlimit: new command (2011-10-21 23:19:51 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit sys-utils-3rd

Sami Kerola (20):
      setsid: add long options and fix coding style
      rtcwake: align with howto-usage-function.txt
      unshare: align with howto-usage-function.txt
      switch_root: align with howto-usage-function.txt
      switch_root: add nls support
      tunelp: fix coding style
      tunelp: use symbolic exit values
      tunelp: use libc error printing facilities
      tunelp: add long options and align with howto-usage-function.txt
      docs: add long options to tunelp.8
      docs: align tunelp.8 with howto-man-page.txt
      readprofile: add long options
      readprofile: use libc error printing facilities
      readprofile: fix coding style
      docs: add long options to readprofile.8
      ldattach: fix coding style
      ldattach: align with howto-usage-function.txt
      ldattach: check numeric user inputs with strtol_or_err
      ldattach: convert debug macro to function
      ldattach: add default case to switches

 sys-utils/Makefile.am   |    1 +
 sys-utils/ldattach.c    |  477 +++++++++++++++++++++++++----------------------
 sys-utils/readprofile.8 |  148 +++++++--------
 sys-utils/readprofile.c |  292 +++++++++++++++---------------
 sys-utils/rtcwake.c     |   16 +-
 sys-utils/setsid.c      |   73 +++++--
 sys-utils/switch_root.c |   55 +++---
 sys-utils/tunelp.8      |  227 +++++++++-------------
 sys-utils/tunelp.c      |  456 ++++++++++++++++++++++++--------------------
 sys-utils/unshare.c     |   19 ++-
 10 files changed, 913 insertions(+), 851 deletions(-)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
