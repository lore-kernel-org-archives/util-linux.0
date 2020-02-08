Return-Path: <SRS0=Y/tB=34=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF1FC35242
	for <util-linux@archiver.kernel.org>; Sat,  8 Feb 2020 17:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C9E20658
	for <util-linux@archiver.kernel.org>; Sat,  8 Feb 2020 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBHRZl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 8 Feb 2020 12:25:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45737 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHRZl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 8 Feb 2020 12:25:41 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so2995448ioi.12
        for <util-linux@vger.kernel.org>; Sat, 08 Feb 2020 09:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bsAjSM4V52P0EB0BXJPnbn6NZSicHjPlPWbxPrj6Xb0=;
        b=WmZUVgBXoxC8FXKIxv/RvnroM8yTwIzsioD6wlicmjU+Y2ckhAEYI8p/TxFCauJT3Z
         /qLatpNI51NfCfUvEWz+eCsOE0FRj0kmnJ8l0ZC/+GMEI0tlBIOZzrswPZM241MVy8PH
         G9VB5g0B0ZjLvdk7C0QovsrmRu4zqpdOmJ7Gun6qlYiKr+dU3GZbe75tdM85JvkevOqQ
         KBQgUzXsQMDBGvBbWbD3L0N2tVzOldihOGSbs01T1gaaWNm9QLaoQCZ9qi1sEpK8a91a
         w5o0bZeGwBecfWEBbnLvicPKRGp3qELv35FFLXZ2VDon/27xa/sQBJr2pj6+0JSLET1k
         pZPA==
X-Gm-Message-State: APjAAAV7uRXhFX73zG3tlcUUB4hnmfi28o8u6qPm2RnkCGvfHlYdjs9s
        D/9pk6a5fSZEk5yJigK71LEK9X2eBVXV53G9WNY=
X-Google-Smtp-Source: APXvYqz34zxWzrUpD8XA/SuAawG0GUM9iKpx+EYWs12DqAT8p569hOwH7fO6HBuFNAAsj8sC9jCDPC9o9FVrA1KnaaQ=
X-Received: by 2002:a05:6638:723:: with SMTP id j3mr3722347jad.131.1581182740624;
 Sat, 08 Feb 2020 09:25:40 -0800 (PST)
MIME-Version: 1.0
References: <CAG27Bk0x4LZJSb-0PXKR8VLTmoPiZdKBPtfB4N2HPnPjxbrSKQ@mail.gmail.com>
 <3e1bf9df-b530-738b-fc7f-00e4cf144420@bytedance.com> <20200106105256.3phh5bdgs4qgqzpp@10.255.255.10>
 <69b8ca4c-aa39-0c8f-1c48-e9ef514f55d8@bytedance.com>
In-Reply-To: <69b8ca4c-aa39-0c8f-1c48-e9ef514f55d8@bytedance.com>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Sat, 8 Feb 2020 17:25:29 +0000
Message-ID: <CAG27Bk0vNs+3s6FM2k44p2N+xkZYD1aL-R6Th8m9+-nZOaMMSg@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] irqtop todo note
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 6 Feb 2020 at 01:23, zhenwei pi <pizhenwei@bytedance.com> wrote:
> Hey, I notice that v2.35 has been released. How about continuing this work?

Yes, that's the plan: https://github.com/karelzak/util-linux/pull/952

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
