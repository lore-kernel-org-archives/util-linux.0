Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60156 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GANvq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:46 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 0/6] Trivial documentation fixes
Date: Fri,  1 Jul 2011 15:51:39 +0200
Message-Id: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

this series contains trivial low-priority documentation fixes
for bugs in Debian BTS. References to bugs addressed
are mentioned in the commit messages.


Petr Uzel (6):
  mount.8: fix reference to sharedsubtree documentation
  mount.8: remove accidental extra word in ext4 documentation
  mount.8: fix typo
  mount.8: fix typo
  mount: make the error message clear
  mount.8: fix typos

 mount/mount.8 |   12 ++++++------
 mount/mount.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.7.3.4

