Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE6AC7619A
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjDEKIb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjDEKIa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 06:08:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E63ABD
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 03:08:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so36738692pjt.5
        for <util-linux@vger.kernel.org>; Wed, 05 Apr 2023 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680689287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul1Njc0fj9ws0NCsfYT49UcBU1JA1P8pjVHrh4obsNM=;
        b=izADiynWAqr7YK3SjV/erSqyRbHFLUiflrogt/+BnGeN+kDdNmpzTp9y5Y728nLSf1
         65Wu1ABWw0pJZQLdbd1SeRdrfxh+4ZvfKduCQD+VJXPvUHITsMvS4G5nFcZUUkIIPOJU
         3xDMlyClr3SuL2gi4grgVJN/F3EtgxpR32C6ES1V628hTOpdDwnOZAkqZQuNcb3zz5kx
         lh4tBTq/5hT9ElhtUpXoeDhta1SMD6UIcdauFcTpI9JvT/mGtJcD7L+rEMCJfcsJdIcj
         LDT9NfgL9u+K0WZja1C5Q8cm2iDeHDl7MJ1eYsbuVOjvWBQrlegzdog4CN1fc1JpkSkp
         CVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul1Njc0fj9ws0NCsfYT49UcBU1JA1P8pjVHrh4obsNM=;
        b=ovhu1HoE6psR6JQpo3wMkHIM3uIKcpqSjwgmNb2d9BcKzeYcxuYwNFY24tijW5BVzu
         PNljFAt0CX8dIGQ1BwlcP/BytnqmryIM3FdxK21guBBFVVkM7d3M7wHXQcJaKLZA+8TQ
         9Es38m3Y/lNOXHAGa7fd/1Oz238enXrimcqnYp55E2lIS7KxKyMM4XntXZXAZwiWz1N0
         mLJlmmYyhVndZIIyOBPrNmJ1URuoElI1m2VF/UvgUDUJ+OMWoq3yZdLEoi6lPsj0q+M+
         1gPZN3hkoMZvrMT2LA+lKB26uldUCYSgH/QiYWzM5LyKxJ8G4dEA9GRXrCqjBfOjPNxj
         vowQ==
X-Gm-Message-State: AAQBX9eMQLRbjmybtZgTrMp7QSLXBeSSEi5Yf0DE8nybLt2y8VLzcTAO
        GW1NmT4PWEEd5T4s2F2+DmgG2HddHHprp3dirvKd2g==
X-Google-Smtp-Source: AKy350bv/yqAz8KgCzuji620ld45NfqmvXk/+HT9JFzK53wnf/IQDRHP0PojnpoJFeSE+g6LfN9BaA==
X-Received: by 2002:a05:6a20:2921:b0:dd:ee39:5e90 with SMTP id t33-20020a056a20292100b000ddee395e90mr4652698pzf.23.1680689287620;
        Wed, 05 Apr 2023 03:08:07 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79212000000b0062db34242aesm10300379pfo.167.2023.04.05.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:08:07 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/1] add blkpr in AUTHORS file
Date:   Wed,  5 Apr 2023 18:08:00 +0800
Message-Id: <20230405100801.10295-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi, Karel

I noticed that you announced the v2.39-rcX, and I find the lack of
blkpr entry in AUTHORS.

zhenwei pi (1):
  docs: add blkpr in AUTHORS file

 AUTHORS | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1

