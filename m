Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53940C7619A
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjDEKIO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjDEKIM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 06:08:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEC3AA5
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 03:08:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so33962749plo.2
        for <util-linux@vger.kernel.org>; Wed, 05 Apr 2023 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680689290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlKuoNFIbf1OVKBr5MB5QWK9RSyh/B3dzSZBr5mFX3A=;
        b=RaDVgnnBNpLY9uZKM7IBBcGlyn1Je6EJOk2vssuClH0wLjhvAiC4guIktw+BOr0AYi
         Oh3/2EqsWcczvPWAeZ21HEEN9uZyb0LHTIackXKTSc4Uc8jcJbThDB2Zt26C8Adf8mJd
         xuQLsOmf1PB/d3Q1jNRmhLuoQZEc2wLm8VN/brOna5GWBb0YVntyQ8KEtZ/4Ox9Es7S9
         S/m/3veRvsmEtyyq09VhLFXfwmlXXdGVcBA869QDVVW8JWlRjZB+4IGlH97F5b8sdAuw
         tGxtq4VfWSH0aogzxMv1qJu2zgIPTk9ItRAiWOd5d1Ljsndau8TZ4XZ5Qh+GCt34uZag
         Y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlKuoNFIbf1OVKBr5MB5QWK9RSyh/B3dzSZBr5mFX3A=;
        b=5RWm5ALQAKZzryrmeVonJmLAP3n1SKlrnTQ+8SdEpyEBIdfhLtfru4LnPNZEpojF7F
         Zvs+Rd1555AWB6VffxXzWNmfw4hpdCHUjpg2YZNAc6rfHsUIZ/iw/+SpmU84cEaOGH1n
         TRvKJz0EMFjHyrsXLjzwH+E518gJQJfdl6KHhbu9wRRjCRAimC22Nw9QdE+MWsk4+oln
         jUOwgPro0mNvUNCGprPIYctlB2/p926EhwF+GJewe3QXL5OmmjI/J0rPByf70WKRku7Q
         RGhw86sNy8KsMOeeFVBvXiivkgtstvy83HyJe5r3RYg/O4M45FIodbXN1e7SYfOktAhI
         53jQ==
X-Gm-Message-State: AAQBX9fq+lDEhJEFNelWzY+MpyJ5FleVVy1BJxDzKufgQfekwB9pa2La
        c6Lib2uH0nyWT1ZDGBiwQ4eeIaZQXhyNcKsSrooQ1g==
X-Google-Smtp-Source: AKy350bVhlq3kXnR5zAV7kW1Rs17yS+CDRIfFROuHYCScRvTbxR1ixHF8/l9bqqlSUMSvEOsUj7oWQ==
X-Received: by 2002:a05:6a20:7511:b0:d9:199a:c719 with SMTP id r17-20020a056a20751100b000d9199ac719mr4809457pzd.37.1680689290124;
        Wed, 05 Apr 2023 03:08:10 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79212000000b0062db34242aesm10300379pfo.167.2023.04.05.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:08:09 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/1] docs: add blkpr in AUTHORS file
Date:   Wed,  5 Apr 2023 18:08:01 +0800
Message-Id: <20230405100801.10295-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405100801.10295-1-pizhenwei@bytedance.com>
References: <20230405100801.10295-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

blkpr command was added in the v2.39 development window, add this in
AUTHORS file.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 AUTHORS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/AUTHORS b/AUTHORS
index 98808f18e..ae3229af9 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -15,6 +15,7 @@ PAST MAINTAINERS:
 AUTHORS (merged projects & commands):
 
       blkdiscard:      Lukas Czerner <lczerner@redhat.com>
+      blkpr:           zhenwei pi <pizhenwei@bytedance.com>
       blkzone:         Shaun Tancheff <shaun@tancheff.com>
                        Damien Le Moal <damien.lemoal@wdc.com>
       fallocate:       Eric Sandeen <sandeen@redhat.com>
-- 
2.25.1

