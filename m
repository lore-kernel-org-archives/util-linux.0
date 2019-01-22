Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E37BC282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1320866
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 23:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0SrgEVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAVXSV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:18:21 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44703 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfAVXSU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2019 18:18:20 -0500
Received: by mail-pf1-f170.google.com with SMTP id u6so128262pfh.11
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2019 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UrlUThut/MZA8CkZwpQxqLukRzfeJ+aw56eRuMaobjI=;
        b=P0SrgEVkdohW2BVtEAtPenz+VBwTX3n4mvEiygPavvIxXdfw8tBnit9G/VIc6rl9Vt
         lU6m7TV5Ojo0lXxZH70OdpKrBStpRCbXZKV6qtT9QgnwyKVDvKgConSVzQDePZH8hdvI
         5JuiJy8qk+upR+W5S9D8ima7TvGmhEck1iJV8mkw18iEsJV+supgCP03gt3WToNheSde
         Pu2TuKTzamJLRqmhv2fNt/wwQssPnALt78VfCTrPc7CEaicuFbrMOrtQdFntFucF2khm
         p36ytXSDSAbVbDmI9wCi4AW8KuTFT219L+dDkDyIBlueIdAvIbnRsPPTN/Tnq/4FYKek
         w/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=UrlUThut/MZA8CkZwpQxqLukRzfeJ+aw56eRuMaobjI=;
        b=F7dHG53z5PxPPexvbdILRU4xbwqTaRoW9TdVde/Ceu8YrzmV+FCIb6wmcHwZVz0iPT
         XpFOtnhgg08HvgTWcKuwe8guyIF5Uo8AOufFClO27jihVhLa5yNpxOOHZSkkS67q8RR+
         RBOkKjCDFcW5J5e4FMFIosqBe1bp0FFmXMJYyTuRMqv3z0zD3kr4edkvOU1d+0utdUGT
         uZem2NU9Q4FfG6L8AmrqPz7aQRnbuKFh7rlngXS65yAjDHCNcQ7jZtXqqP+zF789d73x
         uBkR0OpUaEt1bg4+dCWsySTv64B3JrnZtgV+KOO4XXEo0X0/UQip1vlnJ2oK0ACOkcru
         vpfA==
X-Gm-Message-State: AJcUukfaxF6ortK5mBwlbO61Sd7w4fOpEIL47pDwEtaHC7BISvPvdvCy
        PU7OOKjAo9cJb/XbkNPH/uwfWe7B
X-Google-Smtp-Source: ALg8bN49Zt7/9w8lhzUSIicT+kfiPKSVrQ/2ipmkRzOz9n3N6N1lu2iDTP4e8WmpCM9D4xKFZBQV/Q==
X-Received: by 2002:a62:4e16:: with SMTP id c22mr34821581pfb.167.1548199099639;
        Tue, 22 Jan 2019 15:18:19 -0800 (PST)
Received: from [10.67.51.137] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm22022212pga.6.2019.01.22.15.18.19
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:18:19 -0800 (PST)
To:     util-linux@vger.kernel.org
From:   Doug Berger <opendmb@gmail.com>
Subject: rtcwake timing hazard
Openpgp: preference=signencrypt
Autocrypt: addr=opendmb@gmail.com; prefer-encrypt=mutual; keydata=
 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 YVs=
Message-ID: <e97fa13c-4df6-14c2-14b9-baeb084324a5@gmail.com>
Date:   Tue, 22 Jan 2019 15:18:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I'm observing a behavior when using rtcwake that appears to be the
result of a timing hazard in the design between the RTC Class framework
and the interfaces for entering system sleep states.

My understanding of the RTC Driver's expected behavior is that it should
generate an alarm at a programmed time and if the system is in a sleep
state at that time it should wake.

Rtcwake appears to program an RTC alarm using RTC IOCTLs and then
initiate the transition to a system sleep state. The timing hazard I am
observing is that the RTC driver may service an alarm expiration before
the RTC driver is informed that it is transitioning to a system sleep
state. In this case the system may enter the sleep state with no alarm set.

This happens when the alarm time is short and the suspend time is long.
For example, the command 'rtcwake -m off -s 1' may exhibit the problem.

The obvious work-around is to set the alarm further in the future to
allow more time for the system to enter the desired system sleep state.
However, I would welcome any advice on how this problem could/should be
solved in the general case.

For example, if there were a way to communicate to the driver that a
system sleep state transition is imminent, it could hold off servicing
the alarm until after it is directed to transition to the sleep state.
Of course, if the system sleep state transition gets aborted for some
other reason the driver may never get notified to enter the sleep state
and the alarm may never get serviced.

Any thoughts are appreciated,
    Doug
