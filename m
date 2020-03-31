Return-Path: <SRS0=mypX=5Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AAC2D0F1
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170AE206CC
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3MmZjG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgCaQob (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:44:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35999 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgCaQob (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Mar 2020 12:44:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so19515015oib.3
        for <util-linux@vger.kernel.org>; Tue, 31 Mar 2020 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6gZujJ+mehG1CjGdI8pnbUp0KNPiJxyJwKXtxpX+pjs=;
        b=b3MmZjG3bQRk31Rk+f3RoohLTWwcocLjU44GCy60FiQm3AdHOwFoqHfxS/CqZiYJwD
         wYOUbPh0/3rjZyzC/HNVjhq4OCVe30xZOXLHWKc1diXxWTLkcO3U4wsOcWfVrePT9vrR
         iVkhW10eHcWnYu2hdTI8ozYmzLLQR1GgUG/7n8NtKejGRWh0DGUJ2AAe6K/2vaCdPf3q
         +hfJgzEkOxtNii5IdM8L1oUuczY9eT5EVyF2dhZD3yYGzrCZquHPHYwqjlWtedq9Wj1C
         CFxGBCOeFd81xzw52Xuo+UPTR4q3HW/No0Z97wM+x20HFehmgUWQq2T/jGLEUSs2lk36
         TBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6gZujJ+mehG1CjGdI8pnbUp0KNPiJxyJwKXtxpX+pjs=;
        b=FzdMX62Dd7CuU3At1j449lLyR17izP9mg5VTzkt6lTgUOhtYNXQzSeA26rCo5sb/nN
         lpCXV5QhYIeceJan2N1L96ntBO90sauLLle6jzxR95QhYt4rYjUtmP0uJsUAfvaRqYsS
         0W0rNYWMA7dHsDB/gJAOUkbB5O0aJ80BiPJhEtwWR0atrDj+kcr1RVUgRlGeqJQSUpJl
         qdYBEokwre7thRa97QaAZX57RyVZ53gqYXndGDJJbAMIs6PMJbftwAfECZ26l7Ui2SYX
         xwqWwBweslDIKXoAK7jEbw6pWIpnKIBA7wPfOs34Moimsg/4hBMhQ8B+8jfDv0mxMC2s
         qmWQ==
X-Gm-Message-State: ANhLgQ1i4RW/ttY7XitAE5cdTYzdTSZTwSSf963z+B25ALUyoyGakDg/
        Q4VahrUxV47qXTXXb+p8szCfkkWa
X-Google-Smtp-Source: ADFU+vvdrTpHfvhxW5W6NPZYYCYKU8NQMu2Ya0tbT3+buEAsujOwnthWmZ/q3mC8n8khUYsD/vJrMg==
X-Received: by 2002:aca:310a:: with SMTP id x10mr2584191oix.151.1585673070622;
        Tue, 31 Mar 2020 09:44:30 -0700 (PDT)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id k11sm5349313otj.25.2020.03.31.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 09:44:29 -0700 (PDT)
Subject: Re: [PATCH 2/3] cal: Correctly center the year
To:     Karel Zak <kzak@redhat.com>, J William Piggott <elseifthen@gmx.com>
Cc:     Aurelien LAJOIE <orel@melix.net>, util-linux@vger.kernel.org
References: <20200328223341.11463-1-orel@melix.net>
 <20200328223341.11463-2-orel@melix.net>
 <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz>
 <20200331134154.ok6zuym6w5p5sa2o@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5ede644d-b128-d0b3-aacf-663a7036b346@gmail.com>
Date:   Tue, 31 Mar 2020 11:44:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331134154.ok6zuym6w5p5sa2o@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 3/31/20 8:41 AM, Karel Zak wrote:
> On Sun, Mar 29, 2020 at 10:39:51AM -0400, J William Piggott wrote:
>> I still believe the year header is nonsense. IIRC, when I brought this
>> up last time nobody replied with any justification for it.
> 
> Backward compatibility? I personally have no problem with the year
> number in "cal -y" output.
> 
> I don't think we can create output which will be esthetic enough
> for everyone, but we can introduce --noyear-header if it will make
> cal(1) more useful for you.

Why?  A user can pipe the output through something like 'sed -e 1d' 
instead of changing the code for everyone.

   -- Bruce

