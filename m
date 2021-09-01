Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74DC4320E
	for <util-linux@archiver.kernel.org>; Wed,  1 Sep 2021 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762A861053
	for <util-linux@archiver.kernel.org>; Wed,  1 Sep 2021 16:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbhIAQdk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:33:40 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36791 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhIAQdj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Sep 2021 12:33:39 -0400
Received: by mail-io1-f41.google.com with SMTP id q3so4836007iot.3
        for <util-linux@vger.kernel.org>; Wed, 01 Sep 2021 09:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wvZgugBxXPIeukGlr3awh2HVMSuIKxJrWhdHXovVLwQ=;
        b=F+V085Ft7m6CSRbHC4NgKOkncco9oIC2z+LQIDfjzaTXflX5sB3x4wjyde8d4kcyy4
         AV9A55gyEhcLAExs5xqJBmNq9Yedmd7bmhpEpSV1T1DtpvvKr1VnGxTG/R5kQnGosKYG
         uAs3uiqphD2dmf5foi3N3aeawGjM/fhpw2nKPn8/14HNzG1wpKN1f3yKfMYlwqTEWcca
         gUhvkmajA3aXgaN9hQUFTCBRYvOAl2gJZkdkdmzs91f75jlI7/Th0sSYJMyp7K9qEzMi
         epWtU+hGIpo9Un8K8tfValEkeamdp4SIW8L04lwkW11tHl+Q62XnK6tYat3H3YRgQ4Qr
         sA4A==
X-Gm-Message-State: AOAM531zihngrWRe7SsUZ0DOrquH5oyzQ7UX5kTMLYIg6QEhRVa4ND93
        qQoHLCYQOglTvQ6DG2JU/3GAsiucXAOVQr+D
X-Google-Smtp-Source: ABdhPJwXvcXuDRC98o9ZB3l2icy48R1gfhSlP83dUrqaKzIK53fCzpgS1iD3aEItlTh9bLB1MotLwQ==
X-Received: by 2002:a5e:d712:: with SMTP id v18mr373449iom.65.1630513962480;
        Wed, 01 Sep 2021 09:32:42 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id u13sm48068iot.29.2021.09.01.09.32.40
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:32:40 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y18so4882184ioc.1
        for <util-linux@vger.kernel.org>; Wed, 01 Sep 2021 09:32:40 -0700 (PDT)
X-Received: by 2002:a6b:b512:: with SMTP id e18mr407274iof.98.1630513960173;
 Wed, 01 Sep 2021 09:32:40 -0700 (PDT)
MIME-Version: 1.0
From:   Rafael Fontenelle <rafaelff@gnome.org>
Date:   Wed, 1 Sep 2021 13:32:04 -0300
X-Gmail-Original-Message-ID: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
Message-ID: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
Subject: Update translations in Translation Project
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi there,

Translation Project has util-linux-man domain POT in version 2.37-rc2,
and it seems that a few strings are different from released 2.37.
Please consider updating the POT version on the Translation Project to
avoid losing translation effort.

Best regards,
Rafael Fontenelle
