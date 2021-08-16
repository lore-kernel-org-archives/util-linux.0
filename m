Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C542C19F37
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A976604DC
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhHPQwk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:52:40 -0400
Received: from luckmann.name ([213.239.213.133]:60273 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230095AbhHPQwj (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:39 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000BD603C.00000000611A97B3.000011C8; Mon, 16 Aug 2021 18:52:03 +0200
Date:   Mon, 16 Aug 2021 18:52:03 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     mario.blaettermann@gmail.com
Subject: Issue in man page agetty.8
Message-ID: <20210816165203.GA4537@Debian-50-lenny-64-minimal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Without further ado, the following was found:

Issue: agetty → B<agetty>

"Display the current issue file (or other) on the current terminal and exit. "
"Use this option to review the current setting, it is not designed for any "
"other purpose. Note that output may use some default or incomplete "
"information as proper output depends on terminal and agetty command line."

"Try to keep the existing baud rate. The baud rates from the command line are "
"used when B<agetty> receives a BREAK character. If another baud rates "
"specified then the original baud rate is also saved to the end of the wanted "
"baud rates list. This can be used to return to the original baud rate after "
"unexpected BREAKs."

"Since version 2.35 additional locations for issue file and directory are "
"supported. If the default I</etc/issue> does not exist, then B<agetty> "
"checks for I</run/issue> and I</run/issue.d>, thereafter for I</usr/lib/"
"issue> and I</usr/lib/issue.d>. The directory I</etc> is expected for host "
"specific configuration, I</run> is expected for generated stuff and I</usr/"
"lib> for static distribution maintained configuration."
