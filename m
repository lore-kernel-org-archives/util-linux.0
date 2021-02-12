Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B3C433E0
	for <util-linux@archiver.kernel.org>; Fri, 12 Feb 2021 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7662364E05
	for <util-linux@archiver.kernel.org>; Fri, 12 Feb 2021 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBLRFt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBLRFo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Feb 2021 12:05:44 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A65C061574
        for <util-linux@vger.kernel.org>; Fri, 12 Feb 2021 09:05:04 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id x19so2226249ooj.10
        for <util-linux@vger.kernel.org>; Fri, 12 Feb 2021 09:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/53TJfg2D+UvF2K2eDoe8snj7E/ycC0lSPTpvVFvBrg=;
        b=CG9FuK5EX7ojNopy3KZtd+62SURvsD/el00JGVOe4fvxtFKWVCIty4PQhMXOOhl1TO
         nSTUEogdP/8iMivu5M2famfK7ohykThIQttnOH8pqkIZreP399F6JI7CCJoEynG8TBQO
         dtL4pgewlgqV2BTc2wS5UwXp/IK8Gl9kojwf+DJd6f60Gbh+XBmfSRqbWfY5DYB3o/J+
         P4OCYJXhNnmH/ZP49JMZOqNkunjvrwqPK3AxMsJeffJXUeezuhN2tua7jvoRSuXMvrnL
         wV9Yq+C6387rEQLFrFX5A/XPLoahGUeDPaH41xUOkM6Yze4TtBzQvvuDCx6EJsCn5UEJ
         PoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/53TJfg2D+UvF2K2eDoe8snj7E/ycC0lSPTpvVFvBrg=;
        b=D2jU/Vh0vHhWkKR+odSEYNjOuUuC4Sm/hNg10sQR2J9vrLVnu/vz8IP5fCnJqSSlzK
         5j6t9VrTXEkk77PJNErckcsanrGMTWMqSScQmr4yvyhyJKWX1dlhyA5ml8bskGq4I3ar
         bZLZcyvpUclUZMONgx4YPdzq341fgvB54Kkxlf9WvZEDfCoFpnNYOvXxtdGrFY7UXaB4
         omdO7hyKg66VCtrXdT70ICedzkitXMfZV5oPfvrwgbEQWJhig8IQlGckRE1kaGFnzjO+
         qgWJeL8Kg8Izzb/dLTmQUwgosYH0kM1pK09UOFempqdZx58nF4PRa9IfLRupH9msdG/I
         tTWA==
X-Gm-Message-State: AOAM532ygjMa4zzyhpArtEl0gYZwekPZsM4nZUwtvW5awSTuyVdqZCNj
        DhAH6ni5a9Xetwsgn7ybXBdZrq+QILo=
X-Google-Smtp-Source: ABdhPJzkmoz9iBM9I4kR56uciLfiQHzaEj/qVAAXsJBDk2gbjaB5Z3hA1phq0TvaihI8ghjz+fYquw==
X-Received: by 2002:a4a:b103:: with SMTP id a3mr2542269ooo.30.1613149502859;
        Fri, 12 Feb 2021 09:05:02 -0800 (PST)
Received: from [192.168.0.91] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id w196sm1905112oif.12.2021.02.12.09.05.01
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:05:02 -0800 (PST)
To:     Util-Linux <util-linux@vger.kernel.org>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Suggested changes to util-linux for FHS compliance.
Message-ID: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
Date:   Fri, 12 Feb 2021 11:04:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I don't recall if this has come up before, but I suggest a couple of 
changes to the default util-linux build configuuration:

1. Change the default ADJTIME_PATH to be /var/lib/hwclock/adjtime

This would be a one line change to include/pathnames.h:
   # define _PATH_ADJTIME              "/etc/adjtime"

For a reference, see the FHS paragraph 5.8.6:

https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05s08.html#varlibhwclockStateDirectoryForHwclo

Currently this behavior can be done by exporting the environment 
variable ADJTIME_PATH=/var/lib/hwclock/adjtime before running configure, 
but is undocumented except in the 2.25 release notes.

2. Change the references to /var/run to just /run or at least add a 
configure option --runstatedir=<path>.

Most systems today create /run as a tmpfs.  See:

https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s15.html and
https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05s13.html

Currently this change can be manually made by setting an environment 
variable, runstatedir=/run when running configure, but is undocumented.

   -- Bruce Dubbs
      linuxfromscratch.org
