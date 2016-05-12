Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33224 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcELLyv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 May 2016 07:54:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so15687839wme.0
        for <util-linux@vger.kernel.org>; Thu, 12 May 2016 04:54:51 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH v2 0/3] Add support for altering GPT size
Date: Thu, 12 May 2016 12:54:40 +0100
Message-Id: <1463054083-2485-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As requested by Karel, this version adds a GPT specific function.

The following additional error checking is performed:
* Check that memory for the new entries array could be allocated
* Check that the new table will fit on the disk
* Check that no existing partition will be overlapped by the new table

fdisk and sfdisk have been modified to use the new function and the
pre-existing fdisk_get_npartitions instead of the two new generic
functions added by the previous patch version.

Sassan Panahinejad (3):
  libfdisk: Add support for altering GPT size
  fdisk: Add support for altering GPT size
  sfdisk: Add support for altering GPT size

 disk-utils/fdisk-menu.c    |   8 ++++
 libfdisk/src/gpt.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++
 libfdisk/src/libfdisk.h.in |   1 +
 libfdisk/src/libfdisk.sym  |   1 +
 libfdisk/src/script.c      |  15 ++++++-
 5 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.1.0

