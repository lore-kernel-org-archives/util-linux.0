Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0902C433F5
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 15:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiAFPsI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiAFPsI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jan 2022 10:48:08 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9778C061245
        for <util-linux@vger.kernel.org>; Thu,  6 Jan 2022 07:48:07 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r7-20020a05683001c700b005906f5b0969so3513350ota.5
        for <util-linux@vger.kernel.org>; Thu, 06 Jan 2022 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mVbms8uRuxTmpFr310HGXJxRxb0QYt9jatfZGipveew=;
        b=PFwThjaTmvv1sGhaE/Lu93nOAMO1xgMqkkKtr3YDtEjmJz/KfyBxUN11on0zQFtVsL
         DbnD8eTQJkH56neTfhJBfhDyTRnxYFaLsn/ieaxUqvZbe65ptnTJ6ZVHal2iW3JRZ+8J
         fUoeLpL1uWsb7YpBLwhv8YXONxd7cW/1i2LtkKup5UTKJ5Zs4JGyBghVn7DBO7sY9Ujn
         5kHJ70ASNkhGrh/LYiscscG0faiah6wabRe+WnhPWjy3zcDppeD0fDr1T+gzdta7OunI
         DBhNi76TbxImFDnVo2h8JxJ5EzmDBRZqEN6z4JrWuFZoH9YKrtyCql9j5g+zY3mVtMVK
         46dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mVbms8uRuxTmpFr310HGXJxRxb0QYt9jatfZGipveew=;
        b=AtPZrvc1FGKHEpmAssliam+PQ+nkxL4+RV+w46pC97MErZZurJlyXyIv8WNhAxQ3BC
         allotJ1oGcwefHxiPl3n7N9ZsOqS69fMuAhXRlX+rLHS7PQq9JxDKHDHk2DGpJnno0u/
         xDfoIBM/cBvWbvCIQLBWDFPOCoMAJHq+l+IpVN8/hwV4fWoVd7p9LGR0YET1cD6BehmC
         ol1BTzlBJC6cttDC2oDUfszustKQDlQs4PS3WBUSjN6sPrzvHjvzvCId0Jc4489KyjSe
         8jVgErPacGEoJZxjMAh9wuaJ2HrcDfny8q7ZJ4rTWGM+/GlD5cpKizzo8H0HGtZ/QdOy
         ETdg==
X-Gm-Message-State: AOAM533bT3sBXLanaLQN9BFGJt/ruYgFOiXV4RsZjjuGhNTJCnHIWXNA
        TfZ5c0qO3ZgrfRVESt772v2wwhY442Y=
X-Google-Smtp-Source: ABdhPJwePFe6/AuxNBqR8LM+U4Cf8DelT/t/+LcDE+dfc3YmWHxGbzKBARqx7cWe9nYNTjbmbs7JIQ==
X-Received: by 2002:a05:6830:1384:: with SMTP id d4mr5310349otq.139.1641484087201;
        Thu, 06 Jan 2022 07:48:07 -0800 (PST)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id z24sm398598oti.32.2022.01.06.07.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 07:48:07 -0800 (PST)
Subject: Re: su currently requires PAM
To:     "Serge E. Hallyn" <serge@hallyn.com>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <0616772a-c45c-d003-c338-45dd7071fb70@gmail.com>
 <20220106132746.pcxng3anm5kave6w@ws.net.home>
 <20220106143950.GB24764@mail.hallyn.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <a0dbafed-68d8-5770-b065-886aacbb629c@gmail.com>
Date:   Thu, 6 Jan 2022 09:48:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220106143950.GB24764@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/6/22 8:39 AM, Serge E. Hallyn wrote:
> On Thu, Jan 06, 2022 at 02:27:46PM +0100, Karel Zak wrote:
>> On Mon, Dec 27, 2021 at 09:26:01AM -0600, Bruce Dubbs wrote:
>>> In linuxfromscratch, we have been using su from the shadow package because
>>> the util-linux version requires Linux-PAM.  Recently the maintainers of
>>> shadow have announced that they are deprecating su.  Our problem is that
>>> some of our users prefer to not install PAM.
>>
>> I had a discussion about it with Serge (in CC), it seems the current
>> the conclusion is that "for now shadow will have to keep shipping su".

That sounds good.  Thanks for looking into it.

   -- Bruce

> I haven't mentioned it in the Changelog, but have implied here
> https://github.com/shadow-maint/shadow/issues/464
> that yes we will not drop su in shadow until there is an alternative.
> 
>>> Is it possible to make the requirement of Linux-PAM optional in the
>>> util-linux version of su?  From a preliminary inspection of the code, it
>>> looks like only login-utils/su-common.c would need to be modified with some
>>> #ifdef constructs, but I am not completely comfortable doing that myself.
>>
>> The problem is not #ifdef, but that you need local reimplementation
>> for the very basic PAM functionality.
>>
>> I have suggested creating some minimalistic library with PAM
>> compatible API, but without all the functionality. Maybe we can
>> develop this library in util-linux and later offer it to other
>> projects. Volunteers? ;-)
>>                                                           
>> Another possibility is to improve the original PAM to make it possible
>> to compile it without modules, etc.


