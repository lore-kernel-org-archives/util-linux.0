Return-Path: <SRS0=JGtg=2Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E42C2D0C2
	for <util-linux@archiver.kernel.org>; Sat,  4 Jan 2020 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC72215A4
	for <util-linux@archiver.kernel.org>; Sat,  4 Jan 2020 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgADKVK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:21:10 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:35484 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgADKVK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Jan 2020 05:21:10 -0500
Received: by mail-io1-f43.google.com with SMTP id v18so43845700iol.2
        for <util-linux@vger.kernel.org>; Sat, 04 Jan 2020 02:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=y+Z/+aet+AXSZ+xFHiGv3INHI7rSFtF4jdSJFRedjyA=;
        b=A8MXhWxQzV5+Wt3gm7ak8hdKK+G308W0NYZRPAHftfYHLxtaeKqFDQoq1LKYR29kmf
         OdX0MPvlfWBXTEq7pfTA5/Un28ZE6OlrY19zphHs3rPk9pGHdONjg9yqMqAk5ixHf0Ay
         lgj8KNfJ8MCT9CwJ7fTzuSR3/uBQ6QpZXjV3/CNV/yqjc8fp3YpogK9LFSijzglFKgDM
         UBLaGXYw1Zg/mwcNbDM/HD3c7fazrEA1ImOUftOIKpJWVAuwKdo+vMgDDJ5x2g23Rn9N
         SAx1rk8lG2AmOnuzY7YlFYDzps7S6I5Iy7J6Cwb+gqMI2BYacu3Q+1iEA9W9B5nIHapI
         jEfg==
X-Gm-Message-State: APjAAAXWT03K1hcCgbKQQ/oaoUAVRVqMnZQk0kksHc3xmnTjQoEwKWTW
        SyZLWhmghEuK2xEUlBPpqOKI4gTsImL3vi4jzh+ksr9T
X-Google-Smtp-Source: APXvYqwABc21S17O+I3SmGGt2z64gby3kmMR9kFbEAGAKb7zkr57sAP4fL+4P3HMACQLFNMInLWAoxucZnVwjsXDFII=
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr58388985iot.199.1578133269339;
 Sat, 04 Jan 2020 02:21:09 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Sat, 4 Jan 2020 10:20:58 +0000
Message-ID: <CAG27Bk0x4LZJSb-0PXKR8VLTmoPiZdKBPtfB4N2HPnPjxbrSKQ@mail.gmail.com>
Subject: irqtop todo note
To:     util-linux <util-linux@vger.kernel.org>,
        zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

I notice irqtop to todo file, so I decided to look into that. Changes
in my branch are nowhere near ready to be considered to upstream
ready, so no pull request yet maybe sometime later January or early
February. Meanwhile if someone else is working with the same I'm sure
efforts can be combined.

https://github.com/kerolasa/util-linux/commits/irqtop

Things to fix with my work.

* Save git history from https://github.com/pacepi/irqtop
* Write proper commit messages
* Use smartcolums
* Change output header to include hostname and iso timestamp
* Use signalfd to catch signals
* Use timerfd  for periodic execution
* Make main() shorter / simpler by moving bits and bobs to functions
* And the things I don't know yet, but without doubt there will be some

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
