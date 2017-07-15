Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36622 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdGOVUv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id 15so4724176wmm.3
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/5] pull: five mutually unrelated changes
Date: Sat, 15 Jul 2017 22:20:41 +0100
Message-Id: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The 'big' change in this pull request is to drop reset(1) from util-linux. 
I don't think there is any point of keep this script hanging around.  Rest
should be pretty straightforward review.

Sorry about forgetting uuidparse(1) bash-completion file when that command
was introduced, but on good side when I got around adding the completion I
noticed that bash set -u is broken here and there.  All instances of the set
-u issue should be now fixed.

Both boilerplate.c and ldattach(8) changes are very minor, and hopefully do
not need further explaining.

----------------------------------------------------------------
The following changes since commit 8ffa3b651d7e74acba8f1d831b7f68fdb3c66aae:
  libfdisk: make fdisk compliant to UEFI/GPT specification on PMBR (2017-07-14 12:48:18 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk28
for you to fetch changes up to abbcec4fc9c8d7fb835b4eafd1bc9d82acbf0056:
  bash-completion: make completions to work when bash set -u is in use (2017-07-15 22:05:42 +0100)
----------------------------------------------------------------

Sami Kerola (5):
  reset: remove script from the package
  ldattach: simplify debugging function when vwarnx(3) is available
  docs: add optional option back to struct option
  uuidparse: add bash-completion file
  bash-completion: make completions to work when bash set -u is in use

 Documentation/boilerplate.c   | 17 ++++++++--------
 Documentation/deprecated.txt  |  5 -----
 bash-completion/Makemodule.am |  3 +++
 bash-completion/blkid         |  2 +-
 bash-completion/fdisk         |  2 +-
 bash-completion/fincore       |  2 +-
 bash-completion/findmnt       |  2 +-
 bash-completion/losetup       |  2 +-
 bash-completion/lsipc         |  2 +-
 bash-completion/lslocks       |  2 +-
 bash-completion/lsmem         |  2 +-
 bash-completion/partx         |  2 +-
 bash-completion/prlimit       |  2 +-
 bash-completion/sfdisk        |  2 +-
 bash-completion/swapon        |  2 +-
 bash-completion/uuidparse     | 37 +++++++++++++++++++++++++++++++++++
 bash-completion/wdctl         |  2 +-
 bash-completion/zramctl       |  2 +-
 configure.ac                  |  9 +--------
 sys-utils/ldattach.c          | 10 +++++++---
 term-utils/Makemodule.am      |  6 ------
 term-utils/reset              | 19 ------------------
 term-utils/reset.1            | 45 -------------------------------------------
 23 files changed, 71 insertions(+), 108 deletions(-)
 create mode 100644 bash-completion/uuidparse
 delete mode 100755 term-utils/reset
 delete mode 100644 term-utils/reset.1

-- 
2.13.3

