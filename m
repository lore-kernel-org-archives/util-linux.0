Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB1EC19F3B
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC14604DC
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhHPQwb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:52:31 -0400
Received: from luckmann.name ([213.239.213.133]:60273 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhHPQwa (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:30 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000BD602D.00000000611A97AD.00001055; Mon, 16 Aug 2021 18:51:57 +0200
Date:   Mon, 16 Aug 2021 18:51:57 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     mario.blaettermann@gmail.com
Subject: Issue in man page hexdump.1
Message-ID: <20210816165157.GA4166@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Without further ado, the following was found:

Issue: both citation and formatting of conversion characters

"Further output by such format strings is replaced by an equivalent number of "
"spaces. An equivalent number of spaces is defined as the number of spaces "
"output by an B<s> conversion character with the same field width and "
"precision as the original conversion character or conversion string but with "
"any \\(aqB<+>\\(aq, \\(aq \\(aq, \\(aqB<#>\\(aq conversion flag characters "
"removed, and referencing a NULL string."
