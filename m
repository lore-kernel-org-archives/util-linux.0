Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:59794 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3CPXkZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:25 -0400
Received: by mail-we0-f174.google.com with SMTP id r6so3954881wey.19
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/7] pull: whereis changes
Date: Sat, 16 Mar 2013 23:40:12 +0000
Message-Id: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel, and all,

Here are the results of the whereis(1) work which I mentioned earlier the
week in irc.  All of the patches are related to that command, and as you
can see from the diff stats a lot has changed.

The first patch is quite big.  Unfortunately I ran out of imagination how
to make it smaller, as the patch is the core change enabling rest of the
work.  Most what the 0001 has got going is with search directory list
building using new data structure.

In between patches are quite straight forward till second last which will
canonicalize output file names.  I think that is what users are
interested, but I a may be wrong as well.  Comments, anyone?

The last patch is a bug fix to RedHat item.  See commit message for
further details.

One funky side note.  After the changes the whereis seems to run about
20% quicker.  That was unintentional enhancement.


The following changes since commit 2029dbd9b168319d8a4717c1523e4facb5cff9cc:

  docs: update year (2013-03-15 15:18:22 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git whereis

for you to fetch changes up to 41f50bc7efcda1acc179c159ccc04e91e1ed5965:

  whereis: remove duplicates from search results (2013-03-16 23:22:02 +0000)

----------------------------------------------------------------
Sami Kerola (7):
      whereis: rewrite most of the command
      whereis: add search scope listing option
      whereis: align with howto-usage-function.txt
      whereis: support MANPATH environment variable
      docs: generic whereis.1 clean up
      whereis: canonicalize files before printing
      whereis: remove duplicates from search results

 misc-utils/Makemodule.am |   1 +
 misc-utils/whereis.1     |  93 ++++----
 misc-utils/whereis.c     | 555 ++++++++++++++++++++++++++---------------------
 3 files changed, 350 insertions(+), 299 deletions(-)
