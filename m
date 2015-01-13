Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:49691 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbbAMSrF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Jan 2015 13:47:05 -0500
Message-ID: <54B56822.40805@gmx.com>
Date: Tue, 13 Jan 2015 13:46:58 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/4] tools: checkman.sh portability
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So, Sami Kerola's checkmans.sh tool caught me stuttering in
hwclock.8 and I had to find out why checkmans did not work
on my system:

 1) Any test file with 'git' or 'lib' in its path fails.
    Including my entire repo under $PATH/github/util-linux
    and the ./lib/terminal-colors.d.5 man-page.

 2) It depends on the man-db package.

The changes seem to be an improvement as it detected 4 new
man-page problems (see separate patch).

I did alter the behavior slightly, previously failed pages
required checking them again manually. Now it shows the troff
parsing errors in progress. When grog fails there is nothing
more to check, and when lexgrog fails I left the old behavior
telling the caller to rerun the command, because I did not
bother to install man-db to see what lexgrog actually does.


The following changes since commit 2e5bf10e32b00c92a3f7fb8b38d793ea6fc1dff2:

  build-sys: add sfdisk.static (2015-01-13 16:59:03 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git checkman

J William Piggott (4):
  tools: checkman.sh portability
  tools: checkman.sh portability lexgrog
  tools: checkmans.sh clean up 'let'
  tools: checkmans.sh add stats

 tools/checkmans.sh | 85 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 33 deletions(-)

