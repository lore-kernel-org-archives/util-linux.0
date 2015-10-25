Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36628 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbJYQFJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Oct 2015 12:05:09 -0400
Received: by wicfx6 with SMTP id fx6so84660911wic.1
        for <util-linux@vger.kernel.org>; Sun, 25 Oct 2015 09:05:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/4] pull: uuid tests
Date: Sun, 25 Oct 2015 16:04:56 +0000
Message-Id: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Thanks for earlier uuid tests review.  The following changes are completely
rewrote approach to do the checks.  Parser check is all about testing format
validation works, and when the format validation can be trusted then it is
not a problem to have random uuid's to be validated by it.

Here are the changes in my remote git.

----------------------------------------------------------------
The following changes since commit c2f03da93d9b79679e4e7e65807cc9a31036dbe7:
  script: be pedantic and use "%"SCNi64 (2015-10-16 11:48:47 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git uuid
for you to fetch changes up to 244d48331e2ead3fbb2a6439081d7487cc04cfff:
  tests: add uuidd output check (2015-10-18 20:17:07 +0100)
----------------------------------------------------------------
Sami Kerola (4):
      tests: add uuid parser check
      tests: make test_uuid_parser to read files
      tests: add uuidgen output check
      tests: add uuidd output check


You might remember there were some other changes mixed up with the earlier
uuid submission.  I have not changed content of these changed, but put them
available in separate branch.  I hope this helps.

----------------------------------------------------------------
The following changes since commit c2f03da93d9b79679e4e7e65807cc9a31036dbe7:
  script: be pedantic and use "%"SCNi64 (2015-10-16 11:48:47 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git various
for you to fetch changes up to 82cac348896156ae081f9e99fafa28f393fa9115:
  ctrlaltdel: display setting when ran without arguments (2015-10-18 18:03:57 +100)
----------------------------------------------------------------
Sami Kerola (5):
      last: display input file in usage() according to command name
      nologin: require /etc/nologin.txt to be file
      ctrlaltdel: improve error messaging
      docs: update ctrlaltdel.8 man page
      ctrlaltdel: display setting when ran without arguments
