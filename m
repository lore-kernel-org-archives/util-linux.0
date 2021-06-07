Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86273C48BD1
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697046054E
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhFGQ2j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:28:39 -0400
Received: from foss.arm.com ([217.140.110.172]:37190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhFGQYo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Jun 2021 12:24:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D036143D;
        Mon,  7 Jun 2021 09:22:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CBE93F694;
        Mon,  7 Jun 2021 09:22:52 -0700 (PDT)
Date:   Mon, 7 Jun 2021 17:22:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Missing getext dependency in v2.37
Message-ID: <20210607162249.ez6dtms5xxansg26@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karl

While building v2.37 I hit the following build error

	: --update --no-wrap --previous --lang=ca ca.po util-linux.pot
	rm -f ca.gmo && : -c --statistics --verbose -o ca.gmo ca.po
	mv: cannot stat 't-ca.gmo': No such file or directory

which turned out to be due to a missing gettext package on my system. After
installing it then re-running configure it builds fine.

It was a fresh checkout where I ran autogen.sh, configure and then make.

Should configure fail when it detects gettext is missing? Maybe this is
a symptom of something else failing somewhere else; I admit I didn't dig much
into it.

Thanks

--
Qais Yousef
