Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F197C77B7A
	for <util-linux@archiver.kernel.org>; Wed, 19 Apr 2023 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDSSZC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 19 Apr 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjDSSZB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 19 Apr 2023 14:25:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF98AEB
        for <util-linux@vger.kernel.org>; Wed, 19 Apr 2023 11:24:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n193so394519ybf.12
        for <util-linux@vger.kernel.org>; Wed, 19 Apr 2023 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681928698; x=1684520698;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CxBrdkScDD4ppwkRSLMwb8tbx5kNJzyakIfKd61HM5Q=;
        b=fpO9xRpcy329RXmVs+iX4iu5z0UZwiPH+TZlPdkNt/PJQ34MLeW6nhXinEUZ7OxK/l
         fBxWTp6Ej+OhBGjUtk3V6/Q4YRI6zgeRSmkuch7SRkdCvbbbmRXhfcCgONbOhhOtsGp8
         qRIUC3VWY1UdugMOY/Ix0My6e8Wz05rRDJSH0QAcwm+DsqbrBNCdVnN14kqexGVXxBE3
         2wpsc+gr3ItTjdmLsCCeL6ELzYYIq0HPzagpxSwFY3DtFavkdHgsqtgkuH5alv66Q/r+
         sBXxRjuqOnIbPXB1Y0wGTl3h3MYn5eWVQF+kUUBWhypWCJMZviZuZXMcheGr7FtD/oky
         jExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681928698; x=1684520698;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxBrdkScDD4ppwkRSLMwb8tbx5kNJzyakIfKd61HM5Q=;
        b=SBSK+nPMi9rdF27mCA0SGRtIC6WVIYwIhGbc2jofoXMErchpbWKs3z4YiusFhm9xxV
         0ILA+GtgGuZuT+vVllKNgJIdXl2+EgzIlgYMmQ9hwTRHwU2ZBP0NjzZdwPKxCKiP0dac
         S32bnAsenLx0fQPAIpkTK4mX8rNHCByQgjg+nvSibNCoXqRLECcEa3453WM8xQnuFGON
         xfaOgP9MGfkuNtIwqZp3kktnHJ9lSc37nIu0cvKe+wnxu4wbImhlFdGqMZN44+wy+smE
         Qbgl/+N4Oq7trPgp6881J1wZeLKpF6TuwKQC4oqonx6F7+i7U+3sNRBZB++IjMQYIGbX
         ox7Q==
X-Gm-Message-State: AAQBX9d2crcvWYTkyDv3+AhQOygz926KHgUmqCN92oss1eZI5sVQoY9N
        ujyBjyv6LWAYwc0b31nB/eSuAo0XiTThTvOdh2szAdPxWE4=
X-Google-Smtp-Source: AKy350a+v+yx/gBzicW3cPzB173GkDd/vaCRnJdXfrU5VTTVddK8PhKu79u5lVBKTC/l3vIxISw3R6Kcy6kjfyrJY1s=
X-Received: by 2002:a25:c545:0:b0:acc:ee1a:3090 with SMTP id
 v66-20020a25c545000000b00accee1a3090mr702461ybe.33.1681928698228; Wed, 19 Apr
 2023 11:24:58 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Wed, 19 Apr 2023 20:24:47 +0200
Message-ID: <CAHi0vA9nvmh7qiWX2oWbOcanCesk2M9dS0Goef6772emz=uy4g@mail.gmail.com>
Subject: util-linux v2.39 with translated man pages by default?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

when I run ./configure (without any option) on the current Git content, I get:

        Manual pages:              yes
        Manual pages translated:   no

This means, creating and installing the translated man pages is still
not enabled by default. What may we expect for v2.39? If this remains
disabled, no downstream packager will notice it, and the effort of the
translators (6 languages, more than 500 translated *.adoc files) was
for the trashscan.

Best Regards,
Mario
