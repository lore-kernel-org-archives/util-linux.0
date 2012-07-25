Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2GYTPs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:48 -0400
Received: by wibhr14 with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/27] preparation to release some time soon
Date: Wed, 25 Jul 2012 21:15:18 +0200
Message-Id: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This is just a review submission of my all recent pull request patches.
Karel proposed I should do in IRC:

21:40 < kzak> kerolasa: it would be nice to send the patches
              independently to the list, (as well as important things 
              from your -Wshadow branch)

The last 5 patches appear first time in the list, and some of them are
quit relevant get next release on track.  IMHO the important patches
are;

[PATCH 1/3] tests: partx changed default output format
[PATCH 2/3] tests: look: add words file
[PATCH 3/3] tests: fdisk: change expected test output
[PATCH 1/5] ddate: russian manual missing from package
[PATCH 3/5] wdctl: fix conflicting types on old systems
[PATCH 4/5] dmesg: inform user when klogctl() or read_buffer() fails

Everything else is in 'would be nice to have' category.

Patches are also available in my git, which some may favour as delivery
method more than email.

git://github.com/kerolasa/lelux-utiliteetit.git test-fixes
git://github.com/kerolasa/lelux-utiliteetit.git 2012wk29
git://github.com/kerolasa/lelux-utiliteetit.git 2012wk30

I think in future I will send the pull requests format 'git send-email 
--compose' cover letter.  Without doubt doing this is noisier than  
sending only pull request, but hopefully makes review more transparent.
Lets try for few times, and if this works the method should probably be
documented in Documentation/howto-contribute.txt as preferred way to
send pull request.  What do you think, does this make sense, help
review, etc, comments?
