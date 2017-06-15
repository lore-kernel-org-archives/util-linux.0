Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55004 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdFOXfU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:35:20 -0400
Subject: [PATCH 00/10] parse-date: pull request (round one)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Date: Thu, 15 Jun 2017 19:35:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Rudi requested to 're-sync' parse-date.y with gnulib's parse-datetime.y
after a massive commit was made there. Here is a partial breakdown:

 GNULIB COMMIT		UTIL-LINUX
gnu coding style fixes	doesn't apply (ul uses Linux kernel style)
debugging fixes		doesn't apply (ul removed debugging from its fork)
gnulib dependent fixes	doesn't apply (ul does not want gnulib)

That covers the bulk of the commit.

The most straight forward changes are in this patch set. It also
includes a fix for Rudi's original bug report (Paul's solution is
gnulib dependent and will not apply). In the process another bug became
apparent and I fixed that.

What is left todo are mostly math overflow checks; some of which are
already handled in a more tradition way. The overflow checks from the
commit all use gnulib dependent solutions.

The following changes since commit c0b0748544ae85b8ff42fb4dbd63ddd7aed4de7d:

  fstrim: remove obsolete comment (2017-06-15 11:49:09 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170424

for you to fetch changes up to 480d6bd80af3f32737400bc57a277a2210ef1797:

  parse-date: time_zone_hhmm() bug fixes (2017-06-15 15:03:04 -0400)

----------------------------------------------------------------
J William Piggott (10):
      parse-date: replace ISDIGIT with c_isdigit
      parse-date: remove unused EPOCH_YEAR
      parse-date: use intmax_t where appropriate
      parse-date: use int where appropriate
      parse-date: use uintmax_t where appropriate
      parse-date: use to_uchar() instead of assignment.
      parse-date: refactor tm_diff()
      parse-date: remove unused year_seen
      parse-date: remove unused ordinal_day_seen
      parse-date: time_zone_hhmm() bug fixes

 lib/parse-date.y | 180 ++++++++++++++++++++++++-------------------------------
 1 file changed, 77 insertions(+), 103 deletions(-)

