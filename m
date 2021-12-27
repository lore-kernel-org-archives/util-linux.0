Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7ABC433EF
	for <util-linux@archiver.kernel.org>; Mon, 27 Dec 2021 15:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhL0P0P (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Dec 2021 10:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhL0P0P (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Dec 2021 10:26:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC5C06173E
        for <util-linux@vger.kernel.org>; Mon, 27 Dec 2021 07:26:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j124so25794312oih.12
        for <util-linux@vger.kernel.org>; Mon, 27 Dec 2021 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mAEAhTGfMIlDa+64fpcg52XtTJXuZZCEOJk5oOIDm7E=;
        b=WYjJDkAaYbnPO3S6VUm8vWVKa1GWhYwSGexQeZlNGnYXvB6JRaliuE9z/qK2MxpSJ0
         DKyX89bc/OJgOS7359Y79xyuxM0LXbH4veafUNDQd2wKCTFoWuDqvZB0qh22ZrDJWrz3
         Ka1MdbhImIYKh5qAnKNPtt8dEZuBCNGp2NEBxFSQvsEN6uiU3AH+Qrq7mAaD6xiGjA0t
         Oh1xE3dCyHhJ0tD+VQfmEDkhurZJEwW41QDtppIJbedysdYNifHJOvD8gXFLpkdMn1gm
         UHzZ65zAHiGaykf3Esu9FO8hFzwmUIwR30aiUWuYVLCrlidy+Kuq+gan/VdXpUwS129M
         I2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mAEAhTGfMIlDa+64fpcg52XtTJXuZZCEOJk5oOIDm7E=;
        b=ZMdsTkkdesZWKJtyygxaGqLYD4bwktzZj7eI59NPil3+1oRCF/jMzzxLsaIY03f+dF
         MDR1Q+8I6TnrYEF0A2n0hA8SqrPiBKIPiN0pyNpfk1Bm8H6HbrMVagjlErZEn44ZV8br
         C8hn4DAscAeuft/uykeRpQlXl/++eiwBeiPGLyEIBN4SVp2Ss04UsrpandU4lff5+9rN
         6GLxUv/KIyxAdvJOFCRXCpgGrw7GS1ezJnOncAFH49FYSgfqiq7uaj97TGgkVTxfjjRR
         WaNAjzIu2Wy0pwPFV4i4aZglncgPI1kDbDWLCSyZdlpJ9vJt80Nt2WT+Iq3grRmCInrn
         thAg==
X-Gm-Message-State: AOAM531/nmPZXDOKewRsfQqwXYTwoqdaFamGTMMQfln85fLZZFt4YaDm
        BoiXJMtIwbA3VFaQohbjGZAM8ufG0Xg=
X-Google-Smtp-Source: ABdhPJyOAsipGs4adPXfxUhPChfHrJiZfSpg3j+IY2sZ908O/xCXRtH/I0mOuY/fnusx2MuovnwJtA==
X-Received: by 2002:a54:4e90:: with SMTP id c16mr12888922oiy.107.1640618774439;
        Mon, 27 Dec 2021 07:26:14 -0800 (PST)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id i16sm3283214oig.15.2021.12.27.07.26.13
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 07:26:14 -0800 (PST)
To:     util-linux@vger.kernel.org
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: su currently requires PAM
Message-ID: <0616772a-c45c-d003-c338-45dd7071fb70@gmail.com>
Date:   Mon, 27 Dec 2021 09:26:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In linuxfromscratch, we have been using su from the shadow package because the 
util-linux version requires Linux-PAM.  Recently the maintainers of shadow have 
announced that they are deprecating su.  Our problem is that some of our users prefer 
to not install PAM.

Is it possible to make the requirement of Linux-PAM optional in the util-linux 
version of su?  From a preliminary inspection of the code, it looks like only 
login-utils/su-common.c would need to be modified with some #ifdef constructs, but I 
am not completely comfortable doing that myself.

I am asking one of the maintainers to make the change, but I am willing to attempt 
creating a patch if no one else wants to do it and the approach would be acceptable 
to the util-linux project.

   -- Bruce Dubbs
      linuxfromscratch.org
