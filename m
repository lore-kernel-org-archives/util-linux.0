Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36197 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759705AbbFBR7R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Jun 2015 13:59:17 -0400
Received: by lbbqq2 with SMTP id qq2so109571457lbb.3
        for <util-linux@vger.kernel.org>; Tue, 02 Jun 2015 10:59:15 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 0/3] bash-completion: handle comma-separated options, sync with code, cleanup
Date: Tue,  2 Jun 2015 23:59:00 +0600
Message-Id: <1433267943-2276-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Boris Egorov (3):
  bash-completion: handle comma-separated options
  bash-completion: sync lscpu completion with code
  bash-completion: remove unused variables [shellcheck]

 bash-completion/addpart    |  2 +-
 bash-completion/chcpu      | 32 ++++++++++++++++++++++----------
 bash-completion/findmnt    | 16 ++++++++++++----
 bash-completion/fsck       |  2 +-
 bash-completion/fsck.minix |  2 +-
 bash-completion/losetup    | 14 ++++++++++----
 bash-completion/lsblk      | 31 +++++++++++++++++++++----------
 bash-completion/lscpu      | 33 ++++++++++++++++-----------------
 bash-completion/lslocks    | 14 ++++++++++----
 bash-completion/mkfs       |  2 +-
 bash-completion/mkfs.bfs   |  2 +-
 bash-completion/mkfs.minix |  1 -
 bash-completion/partx      | 15 +++++++++++----
 bash-completion/prlimit    | 14 ++++++++++----
 bash-completion/setpriv    | 28 ++++++++++++++++++++--------
 bash-completion/swapon     | 14 ++++++++++----
 bash-completion/taskset    | 16 +++++++++++-----
 bash-completion/wdctl      | 14 ++++++++++----
 bash-completion/zramctl    | 14 ++++++++++----
 19 files changed, 178 insertions(+), 88 deletions(-)

-- 
2.1.4

