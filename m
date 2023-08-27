Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E3C83F15
	for <util-linux@archiver.kernel.org>; Sun, 27 Aug 2023 23:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjH0X4w (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 27 Aug 2023 19:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjH0X4U (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 27 Aug 2023 19:56:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22FF5
        for <util-linux@vger.kernel.org>; Sun, 27 Aug 2023 16:56:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76d93cf8e13so183179285a.2
        for <util-linux@vger.kernel.org>; Sun, 27 Aug 2023 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693180578; x=1693785378;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsseYA3Cp2Cn4mud3y7IkJWkxirYaxtgHQDA9QL4wFU=;
        b=fww6fHJJ0qbsHyubwARlmXKysqKooWxWfQmKf6d5Z++V3Ee0CnrWae03PyD/OeFPoL
         /zal9/wlDCHL3/UNu9fhQR0ht2C4E/AFvYLb1IGgsfr5txUzlZEYLa5nlthTRgyCLWLk
         fkX6HeluCRo46jSrapDG7jUn7LB7nqxmg4Qsg+r6I03I5gTnt52tTNch0bSOFhMU3Vz9
         dZA5/xojUQYL3u/Cc99OSqXY0w+MFTXKOnixp0u0P3elvJAQxNTVdPU10zyu+abjFXzl
         3neJ9OcLjiRyQUnI+Hko4AsW7YIKY/xo3ubMTviybwslaJ1o30NQ0XnkIwTtZ1C/Qx3+
         J7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693180578; x=1693785378;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IsseYA3Cp2Cn4mud3y7IkJWkxirYaxtgHQDA9QL4wFU=;
        b=l9Kf9YSaGXoR4KP4pBzLNzQmIM0txpbpekffsJfj0TtgIem5KH2Mt3I7b0qEfrSCiw
         kiYXOAqhziDg7fU+Vl98AwBjPGbZOzCH2G4VwhXY5CCF9fBmBPdOYxCxa48qzI5J+myo
         KD0MVdeB2GL6wapX/75JGkh1jlSzRM+0B8c+tUJC8ovyVSoHDFbR5Bw/75TXVYe8yESg
         lVRtVnur/QVmaXq9/c+1OHH+AeEXFp9YKx7WW0C0nDyk2PJ7H78x6Nzpyp+25R89EseC
         f/D+BBzMfUibG7JQ7lgit9NsyFbdHhBt3DQt0dLJG1mvxsC08wkotIEodwHMeol4tg8f
         hLWA==
X-Gm-Message-State: AOJu0YwNcbOaKmt4bka7CEdyvxvAOT4XhyH7yg/PWGMEpqmmUeJLjRwL
        X3hzy1yLGoMatK25UiiteuOqWsKKnaByHg==
X-Google-Smtp-Source: AGHT+IHifhokaqnLC1VMrBigd1OKhLNfHQ+2Fo0QJquQ2QOGO+H+svs0QKR4ull69UqNUaB/sV3KhA==
X-Received: by 2002:a0c:e409:0:b0:64f:6d8d:f65f with SMTP id o9-20020a0ce409000000b0064f6d8df65fmr11948072qvl.51.1693180577736;
        Sun, 27 Aug 2023 16:56:17 -0700 (PDT)
Received: from [192.168.21.81] (c-67-168-188-36.hsd1.wa.comcast.net. [67.168.188.36])
        by smtp.gmail.com with ESMTPSA id s2-20020a0ce302000000b0064c71d67362sm2185884qvl.118.2023.08.27.16.56.16
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 16:56:17 -0700 (PDT)
Message-ID: <97a0149d-8e08-46d7-a2c9-7aa27defb55d@gmail.com>
Date:   Sun, 27 Aug 2023 16:56:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Tony Rodriguez <unixpro1970@gmail.com>
To:     util-linux@vger.kernel.org
Subject: Help: Trying to obtain KNAME and PKNAME via <blkid.h> and
 partititons.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello blkid team,

Please help.   Compiled the example blkid partitions.c (iink id below) 
which works well for obtaining the UUID.  However, I also would like to 
obtain KNAME and PKNAME for each fstab entry.   When I attempt to modify 
the partitions.c code code, I am unable to obtain KNAME and PKNAME.

How can I obtain KNAME and PKNAME by modifying the following 
partitions.c example.  lsblk.c does it, but requires functions that 
don't appear to part of <blkid.h> and I am sure what to do?

https://github.com/util-linux/util-linux/blob/master/libblkid/samples/partitions.c

Thanks,
Tony
