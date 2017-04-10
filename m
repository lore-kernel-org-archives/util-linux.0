Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbdDJWsE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 18:48:04 -0400
Subject: [PATCH 0/5] Various small fixes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Date: Mon, 10 Apr 2017 18:47:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The first commit reintroduces Karel's change to hwclock on
Dec 19 last year, and extends errtryhelp() use to invalid
arguments.  The rest are style and man-page fixes.


The following changes since commit dddbfa4e9ba63fb731dd04f3b9c1ba18c57f5f69:

  agetty: various man-page fixes (2017-04-10 15:46:26 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170409

for you to fetch changes up to 697bfcf57695087713750900f369af28ae0cbd74:

  hwclock: remove residual 'compare' from man-page (2017-04-10 14:57:01 -0400)

----------------------------------------------------------------
J William Piggott (5):
      hwclock: use errtryhelp()
      parse-date: remove extraneous form feed
      docs: parse-date.txt fix whitespace
      hwclock: fix whitespace in hwclock-rtc.c
      hwclock: remove residual 'compare' from man-page

 Documentation/parse-date.txt | 4 ++--
 lib/parse-date.y             | 2 --
 sys-utils/hwclock-rtc.c      | 3 +--
 sys-utils/hwclock.8.in       | 2 +-
 sys-utils/hwclock.c          | 9 ++++-----
 5 files changed, 8 insertions(+), 12 deletions(-)
