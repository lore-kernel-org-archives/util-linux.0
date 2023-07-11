Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9AEB64DC
	for <util-linux@archiver.kernel.org>; Tue, 11 Jul 2023 12:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGKMwt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jul 2023 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGKMwt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Jul 2023 08:52:49 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE3135
        for <util-linux@vger.kernel.org>; Tue, 11 Jul 2023 05:52:47 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1689079965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s84UZP6AzkeR8+120CdXpi7X6fUEKdtDb0RbpKyky0Q=;
        b=A54KJeZZmwqXBbBmbCgHv+7RTwPVC1n0PzKILQ7B/d6mLjZjvsPB4uvAKur2Ao103+gf8x
        BVdSobSm1XJWf/tnVc2J4/poKFV4vD0gKo3Z1ZXepcB6bwio+31xXjnZIS3c+GqUzickkC
        H9i/ONDpFwjFJRFFvKJxaM1i46tTSCduiQ38rvax7Q7rX5Fcme3YshT+PZZXDW+fjGjHYD
        IWtENRitlS3f8qlD1TkRKoSBaL6syeQYthbQXNKq4aaocZGeuRnEmOfH8151FQF5ddC+qa
        DqR5kHo87VicFqceWM8JSJApJUQaLi0YzaYnOX8LJhgA0uGkbeI790jwU6oujg==
Date:   Tue, 11 Jul 2023 14:52:44 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] dmesg: Delete redundant pager setup
In-Reply-To: <20230711095509.v7ptu2rjhe2x5tat@ws.net.home>
References: <20230704091430.3555428-1-dsimic@manjaro.org>
 <20230704091430.3555428-2-dsimic@manjaro.org>
 <20230711095509.v7ptu2rjhe2x5tat@ws.net.home>
Message-ID: <f7b8386914de0c96c58d1b383d4417e4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-07-11 11:55, Karel Zak wrote:
> On Tue, Jul 04, 2023 at 11:14:29AM +0200, Dragan Simic wrote:
>> The setup of the pager is already performed a few lines of code above,
>> so it's safe to delete the repeated setup, which actually does 
>> nothing.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  sys-utils/dmesg.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
>> index 02358e449..971712b56 100644
>> --- a/sys-utils/dmesg.c
>> +++ b/sys-utils/dmesg.c
>> @@ -1646,8 +1646,6 @@ int main(int argc, char *argv[])
>>  		/* only kmsg supports multi-line messages */
>>  		if (ctl.force_prefix && ctl.method != DMESG_METHOD_KMSG)
>>  			ctl.force_prefix = 0;
>> -		if (ctl.pager)
>> -			pager_redirect();
> 
> I have removed the initial (global) pager_redirect() call, because it
> makes sense only for the section when it prints kernel messages.
> 
> https://github.com/util-linux/util-linux/commit/0619aa8fda39e40776dd2a73346bd7cc5ab4a33f

Nice catch, thanks.  It's much better to do it that way, which may also 
be seen as a small performance improvement.
