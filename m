Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f49.google.com ([209.85.215.49]:43944 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbbCHVCN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Mar 2015 17:02:13 -0400
Received: by labgf13 with SMTP id gf13so42605358lab.10
        for <util-linux@vger.kernel.org>; Sun, 08 Mar 2015 14:02:11 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 8 Mar 2015 21:02:11 +0000
Message-ID: <CALjAwxjTo=krFxHht2029Sh-h3maEvGK1Xa0fXUOScsamG_=Eg@mail.gmail.com>
Subject: agetty --reload
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've been trying to use agetty --reload from util-linux 2.26 but I've
been running into problems.

The main issue seems to be that /etc/issue isn't reparsed when agetty
--reload is done unless /run/agetty.reload exists before the original
agetty is started. Is this the intended behaviour?

The second issue occurs when --autologin and --login-pause are being
used and a reload happens even when the above is done. Since the login
program hasn't actually been started (as we are waiting for the user
to press enter) I expected the reload to cause agetty to reload
/etc/issue and start waiting again but this does not currently happen.
Is this also intentional?

-- 
Sitsofe | http://sucs.org/~sits/
