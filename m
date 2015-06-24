Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33323 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbFXIP2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:28 -0400
Received: by wgck11 with SMTP id k11so29415067wgc.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/12] pull: minix updates
Date: Wed, 24 Jun 2015 09:15:07 +0100
Message-Id: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

The patch 0001 is not re-submitted.  It is the change Joshua Hudson sent
to mail list couple days ago.  The rest are new changes, and they are
also available from my remote branch 'minix'.

The following changes since commit 4b7248c0296e94fc1d85c22bbad5f7b943689971:
  libfdisk: add GPT GUIDs for ARMs (2015-06-22 11:56:43 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git minix
for you to fetch changes up to d60409ed753acb02fa1ea382e0c638d378653448:
  docs: make fsck.minix(8) more pretty (2015-06-24 09:10:20 +0100)

Joshua Hudson (1):
  mkfs.minix: increase maximum minix v2 and v3 file system sizes

Sami Kerola (11):
  mkfs.minix: introduce long options to the command
  mkfs.minix: use is_mounted() from libcommon
  mkfs.minix: remove unuseful code
  mkfs.minix: add fs_control structure, and remove most global variables
  mkfs.minix: check user input carefully
  mkfs.minix: check requested blocks will not exceed available on device
  mkfs.minix: refactor root block content creation
  fsck.minix: rename device file descriptor variable
  fsck.minix: add minix v3 support
  fsck.minix: introduce long options to the command
  docs: make fsck.minix(8) more pretty

 bash-completion/fsck.minix |  12 +-
 bash-completion/mkfs.minix |  16 +-
 disk-utils/fsck.minix.8    | 159 +++++++-----
 disk-utils/fsck.minix.c    | 223 ++++++++--------
 disk-utils/mkfs.minix.8    |  37 +--
 disk-utils/mkfs.minix.c    | 623 +++++++++++++++++++++++----------------------
 6 files changed, 567 insertions(+), 503 deletions(-)

-- 
2.4.4

