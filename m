Return-Path: <SRS0=LbFG=PS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62947C43387
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7420651
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk-org.20150623.gappssmtp.com header.i=@jguk-org.20150623.gappssmtp.com header.b="nLRWHqWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfAJMWs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:22:48 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42012 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMWs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Jan 2019 07:22:48 -0500
Received: by mail-wr1-f51.google.com with SMTP id q18so11116356wrx.9
        for <util-linux@vger.kernel.org>; Thu, 10 Jan 2019 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5FoxBlz7stzTCvJ72eZorFbCi2i8Qwa+y3fw69I/i8=;
        b=nLRWHqWAp7+keULrxy3Xv6YVW0OOD95H7Tb4UEhLVyj35QYx34d8BtMoHH2nSK2DF+
         lUdmqAF9O7T1uBtQ2alhYKtLJZsnUdih2+KwlhBz8vLDg6Zsuc3cl9mvFYGwpmpsOjs2
         wuvDH7RJPW8NpmIr3kqoMBnefLtArF51gYhYqh+JZjHRs9eMWQ31v4JzXUFJCQIrGvbB
         cGebL1sZtNlOT64Is9qhr5fc8cQGDIfEPwmlCY6Wh3DmnNSfr9yE6lQMR5iZjc9x7y81
         I3pVbHKzdgsrGFChJexhwB8Vjjje833Ee3u7s3TSEjTCK8qE4I/Q6rUQwNONbD9RfxVU
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5FoxBlz7stzTCvJ72eZorFbCi2i8Qwa+y3fw69I/i8=;
        b=rJHyCR10GpS19KMYLDyQqN3orwF4CuCRZXbDAyitIKB00UhL8S9DbhFxN9R/vNHQRF
         vFB5ohq6XNRVats4gUwAKaq7zjM2/oFU8eBGzb6909HfjDhF71jkA5b8HezAlolrHH0p
         xSbChFH0vB7ZN58CChbCnRH7zjKYQ/da5RmUWU+Z4Eg3HewVPD4VhoG+dGqf+VpEVdY6
         QbBhESwc6RgZL8dTGSWKp0qpC1FlouqUKK53ecWSj9O1xjYQEGrlRM0JEZJnlo4p66am
         D24uWzSn+77PwHC8k019u/5s/RfjcavYS6d4tNcLfP+AdyK9eJGLRmAlNQd5Yv2i7wsk
         BiqA==
X-Gm-Message-State: AJcUukeZcca8COCWvySS8e0WN+qbaYLhxOF1YfxCMMcqgsaYsolAV1xh
        Ih3FGHi3DwMxSVjZAYStdCy08vKgmPM=
X-Google-Smtp-Source: ALg8bN5DxrcX1zX5YmLZalvYtJEbQVwXDvX24Ajva7oHxO7jSdrYH/fCCXtpoesmSVWe8WYYXLuEZQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr8634281wrm.232.1547122965163;
        Thu, 10 Jan 2019 04:22:45 -0800 (PST)
Received: from [192.168.1.64] (147.98.189.80.dyn.plus.net. [80.189.98.147])
        by smtp.gmail.com with ESMTPSA id c202sm17345605wmd.40.2019.01.10.04.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:22:44 -0800 (PST)
Subject: Re: fdisk Ctrl+C
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <9bf2cc25-1b6a-88ae-c293-7a613b1255d8@jguk.org>
 <20190110112249.hem6qvd7jqzzvhxg@ws.net.home>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <b8a1d828-db9d-2f56-697c-b14d838c44d3@jguk.org>
Date:   Thu, 10 Jan 2019 12:22:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110112249.hem6qvd7jqzzvhxg@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On 10/01/2019 11:22, Karel Zak wrote:
> On Wed, Jan 09, 2019 at 06:01:18PM +0000, Jonny Grant wrote:
>> 1. Could Ctrl+C be added to get out of changing a partition type?
> 
> Implemented.
> 
>> 2 Could the partition code check that it is hex. At the moment if I type 'q'
>> I get partition type 0.
> 
> Fixed.
> 
>> 3.
>> For partition type 0, which is called "Empty" probably this message should
>> say "Empty" and not 'unknown' ?
> 
> Works for me now.
> 
> Thanks for your report.
> 
>      Karel

Great work!
Looking forward to my next dist-upgrade
Jonny
