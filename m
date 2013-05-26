Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62660 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3EZJOQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 05:14:16 -0400
Received: by mail-wi0-f178.google.com with SMTP id hj6so770034wib.11
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 02:14:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0000] pull: cal the branch four
Date: Sun, 26 May 2013 10:14:06 +0100
Message-Id: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

The cal branch I have in my git has got fixes to issues reviewed earlier,
and I hope all works.  Based on that I decided to get rid of upper cal
year limit, 9999, and replace it with unsigned long.  I know the change
does not make much practical sense, the point of the change is that where
there is no need to have artificial limits to a random magic number they
should not exist.

Assuming the patch series are applied at somepoint I think the next thing
to do for this command is the cal_context Karel proposed[1].  Having more
sensible way to pass run time configuration will hopefully make
implementing the week numbering column easy (which I originally wanted),
and may even make various color additions possible.  Meanwhile here comes
mostly old patch series, with couple new changes.

[1] http://www.spinics.net/lists/util-linux-ng/msg07983.html


The following changes since commit ef264c830effc91add6da334204215f61eb8515e:

  agetty: allow full control on CLOCAL flag (2013-05-23 09:47:58 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git cal-fourth

for you to fetch changes up to 3f5e9ecbf54213867ec787f40bd23d76d43dbd61:

  docs: cal: stop telling year 9999 is upper limit (2013-05-26 09:59:21 +0100)

----------------------------------------------------------------
Sami Kerola (18):
      cal: fix preprocessor directive indendation
      cal: convert function like definitions to functions
      cal: clean up use of constants
      tests: add calendar reformation check
      cal: simplify calendar reformat calculations
      cal: remove unnecessary initializations
      cal: de-duplicate julian specific functions
      cal: support --color[={auto,always,never}]
      cal: add --color to usage()
      docs: cal: add --color option description to manual page
      tests: add cal day color corner cases
      cal: stop trimming whitespaces
      cal: mark all functions static
      cal: simplify day_in_week() calculation
      cal: use Claus Tøndering's day of the week algorithm
      cal: remove arbitrary limit of maxium year being 9999
      tests: check cal works when year is far in future
      docs: cal: stop telling year 9999 is upper limit

 misc-utils/Makemodule.am   |   2 +-
 misc-utils/cal.1           |  16 +-
 misc-utils/cal.c           | 611 +++++++++++++++++++++++----------------------
 tests/expected/cal/1m      |  48 ++--
 tests/expected/cal/3m      |  48 ++--
 tests/expected/cal/bigyear | 206 +++++++++++++++
 tests/expected/cal/color   |  55 ++++
 tests/expected/cal/sep1752 | 198 +++++++++++++++
 tests/expected/cal/year    | 240 +++++++++---------
 tests/ts/cal/bigyear       |  95 +++++++
 tests/ts/cal/color         |  68 +++++
 tests/ts/cal/sep1752       |  95 +++++++
 12 files changed, 1211 insertions(+), 471 deletions(-)
 create mode 100644 tests/expected/cal/bigyear
 create mode 100644 tests/expected/cal/color
 create mode 100644 tests/expected/cal/sep1752
 create mode 100755 tests/ts/cal/bigyear
 create mode 100755 tests/ts/cal/color
 create mode 100755 tests/ts/cal/sep1752


