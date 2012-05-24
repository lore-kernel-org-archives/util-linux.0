Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:47653 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520Ab2EXM6G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 May 2012 08:58:06 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DF0929A3F6
	for <util-linux@vger.kernel.org>; Thu, 24 May 2012 14:58:04 +0200 (CEST)
Message-ID: <4FBE3059.3030806@suse.de>
Date: Thu, 24 May 2012 14:58:01 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PULL] su
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

coreutils isn't really interested in maintaining su anymore.
Distributions have to add custom patches to fix bugs and add
features. The worst offender is probably the pam patch. Fortunately
we managed to sync the patch between openSUSE and Fedora meanwhile.
Over time the risk that the patches divert again increases though.
Since util-linux now contains a common login program it looks like a
good new home for su too.

To integrate su into util-linux I've extracted the history of the su
program until the last GPLv2 version (they've changed to GPLv3
meanwhile) from coreutils' git and merged it with util-linux.
Then I've added the patches used in Fedora and openSUSE and fixed the
files to actually build.

You can find the result in branch su-v1 (ff6b15d) at
git@github.com:lnussel/util-linux.git

I've also filed a pull request on github:
https://github.com/karelzak/util-linux/pull/10

Originally I had planned to implement separate tty allocation for
the child program on top of that to get rid of the evil setsid
patch. It turned out to be more complicated than I thought though. The
change would be too massive to backport anyways I guess. So the next
step would be to rip out the non-pam legacy stuff and clean up the code
to make it readable again.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
