Return-Path: <SRS0=w2q8=MV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB1C67879
	for <util-linux@archiver.kernel.org>; Tue,  9 Oct 2018 01:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E4B20835
	for <util-linux@archiver.kernel.org>; Tue,  9 Oct 2018 01:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E4B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJIJBu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:01:50 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43268 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeJIJBu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Oct 2018 05:01:50 -0400
Received: by mail-pg1-f169.google.com with SMTP id 80-v6so8623585pgh.10
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2018 18:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UzWiHVBT1+GJ2Ppha6wq+q7E7QzJ6HsexgYelodywSQ=;
        b=CBUtzg3n1Ppnad/P/gl/AqVf1ppyAH0/C041cwa4XW2RKGK71eKIGCzyJPXWXEO7xG
         TVyuUACyun9rc9RckcaFWkXgkeuP1cexUvceS9LkV+Hxl2l6Bxbs+mo7HKq0O5FTjGKp
         baPBqGvaukb1sz5o2lGurig6n8bUNTKSiirktoJ3Jk/o9CdEH2FyshYM40XflJbKZuHZ
         St+GwydLq1sPcklY7aROXYjI63teN5VyHKRV1ZwJbI5Wkjn9vROtk3e0t6eshBF/7yS3
         yUbmE2bPxU35sGvJURlzI8eyQ3revM0UgUKBOdWwWHCAkqyULTE37BDfcv6dNNbbT+tu
         cqOg==
X-Gm-Message-State: ABuFfoiiPsyPTHrZOqaFucQTt83CaxZ9wmGSOOH1aiaNb7XnNMwctRxf
        WnAD6XMCcXXnBMyP8LdimU5HHgoL1BQ=
X-Google-Smtp-Source: ACcGV61ConMpKWN6XV9TUo1Ybi3kaZQBvGgEOQ/3QUreOhT38c6CBS62h4GK5RqdpFZracB+fdZJng==
X-Received: by 2002:a63:6d83:: with SMTP id i125-v6mr22851408pgc.215.1539049639019;
        Mon, 08 Oct 2018 18:47:19 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id r1-v6sm31678183pff.145.2018.10.08.18.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 18:47:18 -0700 (PDT)
Subject: Re: List archives on lore.kernel.org
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20181008092424.jgaxi4s3pizopphg@ws.net.home>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee7b4842-38ff-28a2-2687-1b307fad47d8@acm.org>
Date:   Mon, 8 Oct 2018 18:47:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008092424.jgaxi4s3pizopphg@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/8/18 2:24 AM, Karel Zak wrote:
>   small announce. This mailing list has archives on
>   now, see:
>   
>      https://lore.kernel.org/util-linux/
> 
>   For more details about Lore see
> 
>      https://www.kernel.org/lore.html

That's good to know. Thanks for the update :-)

Bart.
