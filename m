Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2AC432BE
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A99604DC
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhHPQw6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:52:58 -0400
Received: from luckmann.name ([213.239.213.133]:50635 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231997AbhHPQwz (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:55 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000BD604A.00000000611A97BD.0000141F; Mon, 16 Aug 2021 18:52:13 +0200
Date:   Mon, 16 Aug 2021 18:52:13 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     mario.blaettermann@gmail.com
Subject: Issue in man page mount.8
Message-ID: <20210816165213.GA5136@Debian-50-lenny-64-minimal>
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

Issue: cvf__module_ → cvf___module__ (Asciidoc markup!)

"Forces the driver to use the CVF (Compressed Volume File) module "
"cvf__module_ instead of auto-detection. If the kernel supports kmod, the "
"cvf_format=xxx option also controls on-demand CVF module loading. This "
"option is obsolete."
