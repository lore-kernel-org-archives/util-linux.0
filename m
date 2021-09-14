Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6FC433EF
	for <util-linux@archiver.kernel.org>; Tue, 14 Sep 2021 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4112610A2
	for <util-linux@archiver.kernel.org>; Tue, 14 Sep 2021 22:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhINWJJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhINWJH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Sep 2021 18:09:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C375C061574
        for <util-linux@vger.kernel.org>; Tue, 14 Sep 2021 15:07:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so642159pgf.5
        for <util-linux@vger.kernel.org>; Tue, 14 Sep 2021 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCy/euFiyPlaSxTkr5DvZ8EZvgLFh6p1kGuCw66Yess=;
        b=ERFhl+kmJ76oaf5GRNKZGp5sz0d35QJxhsHRfeYFMO0h2DnTFdk+lYc6qzH0bKJcps
         +RnE+AAMjHt0VGwUowNjOJys3GxGn/FTGQXaGh+2N14YQVEZmfkV3SDWNzvgKVq9TAXp
         CsmZfSxPjQ2vXWLmMyGDbKlkJ/+IHZMXcdWjAZ8wW7Ioimo32XmDy5BqCFuwGS4D0vIt
         C2HQ+KNWERNYFaUgOOZSMI56rglWxtgH7pTUdMmzOyNG2TxR5R5DDG1NsxEjm4d9HZia
         00wQChYc9uT3SHKFF98Ea25Rw5bVsvwSDgQ/LmIgUBYanlUbM/N6qbLGal1BM5jXvtd/
         ovgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCy/euFiyPlaSxTkr5DvZ8EZvgLFh6p1kGuCw66Yess=;
        b=rdJr0ULpGnb57f0W5IX041smoZKGIgmhx8YiHEnPmLIJx+LtaXuTrvb9s20s8E+WNq
         IgGXjB0i6UPRwaSGaHnINMxisJQSQrSjGKOkVGCIVhycWlkLp6GQ5DbuHlBTj93/fPYv
         xL301pqGySb7P8/dz9k6zgGlFmMNZ2dojosNUqh6dl6H2f3SvKRjJdMJzJ7Bxg3Bs7yJ
         Qjhu6bAp7kKvOhp/5c3gzfI24hs/ghuWzO1uYonL8yUSOfGsT/bQ5qbQTNhySsG6/Jb/
         iTrPPZHcu8VOLdesl7M1Kw2UzIO7q1yPDDdAY7u7P3zjsiKRut4tpU7C/yBZGyE9FErm
         NgtQ==
X-Gm-Message-State: AOAM532tBIcn6tlJJPNKLTMqJaSJqR7tGUd2WaKwQpxDVmo/R2zvMSnT
        I3No6frGYscPbSFTxqkC7zeGwU77NWxNA96u
X-Google-Smtp-Source: ABdhPJx73YcpGUJrYJcT91mH3/8dB+JMPAr+HS7tHFiO59aBqoiA7GwHZA0o4pwsPuZH1dGhVfbU2g==
X-Received: by 2002:a63:9313:: with SMTP id b19mr17341242pge.128.1631657268604;
        Tue, 14 Sep 2021 15:07:48 -0700 (PDT)
Received: from Rajdev.localdomain ([49.156.64.163])
        by smtp.googlemail.com with ESMTPSA id z124sm12302821pgz.94.2021.09.14.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:07:48 -0700 (PDT)
From:   ritikrajdev <ritikrajdev761@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     ritikrajdev <ritikrajdev761@gmail.com>
Subject: [PATCH 0/1] pull: more - Bug Resolve - new line separated command re execution
Date:   Wed, 15 Sep 2021 03:34:12 +0530
Message-Id: <20210914220413.65881-1-ritikrajdev761@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The following changes since commit 78001b7af36f685265e21feaf384a4be12118c64:

  Merge branch 'master' of https://github.com/yugart/util-linux (2021-09-07 12:30:15 +0200)

are available in the Git repository at:

  git://github.com/ritikrajdev/util-linux.git more-shell-execution

for you to fetch changes up to e5e0eac42c55b007766221e1971fceda3a64bb08:

  more - Bug Resolve - new line separated command execution (2021-09-14 04:27:14 +0530)

----------------------------------------------------------------
ritikrajdev (1):
  more - Bug Resolve - new line separated command execution

 text-utils/more.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.33.0

