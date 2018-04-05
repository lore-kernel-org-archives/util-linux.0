Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f180.google.com ([209.85.128.180]:40817 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDET5B (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 15:57:01 -0400
Received: by mail-wr0-f180.google.com with SMTP id n2so27017325wrj.7
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 12:57:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/4] pull: couple bash-completion fixes
Date: Thu,  5 Apr 2018 20:56:52 +0100
Message-Id: <20180405195656.4946-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel and other,

It would have been better to get these in before relese v2.32 got out, so
sorry for missing that.  I'm sure these fairly trivial corrections are
welcome to be part of the next releaese, so perhaps missing one is not great
misfortune at the end.

----------------------------------------------------------------
The following changes since commit 6963338ca586bef3370e189f13785b4b6b63bbdb:
  dmesg: fix raw output (2018-04-05 15:59:59 +0200)
are available in the Git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git bash-comp
for you to fetch changes up to 1ea4305b1c541333a2c9e4434dc7c3ca05cf188d:
  bash-completion: fix typo in blockdev file (2018-04-05 20:49:27 +0100)
----------------------------------------------------------------

Sami Kerola (4):
  bash-completion: fix few bash set -u issues
  bash-completion: do not print eject --cdspeed error messages
  bash-completion: setpriv --securebits argument can be comma separated list
  bash-completion: fix typo in blockdev file

 bash-completion/blockdev |  2 +-
 bash-completion/chcpu    |  4 ++--
 bash-completion/eject    |  2 +-
 bash-completion/lsblk    | 10 +++++-----
 bash-completion/lscpu    |  2 +-
 bash-completion/lslogins |  2 +-
 bash-completion/lsns     |  2 +-
 bash-completion/mount    |  2 +-
 bash-completion/setpriv  | 23 ++++++++++++++++++-----
 bash-completion/taskset  |  2 +-
 10 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.17.0

