Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314CCC001DF
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjHARuw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHARun (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 13:50:43 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075582706
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 10:50:37 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1690912235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRuOUTf8cAbIzUmAtJbHMIv7Sz1G6iZSKe7eASZ1Y+0=;
        b=JFer6rDz/9hdnWciz0iuc9EJ/Z2Dhd3sN2By1MBhYIJZwzGbSSVBlolwyzMrZsVmNotnEn
        gGdoeBu+kULPK38Q1mYEcOaCy/SmCRyifVOqLU9yvsdBeHdp8xl+/SQ09Q4oo/GuRZf4Qp
        Z83rjrXuvpdfWXVZXnhUtzvlWrofsRKB/AvSZ8G8z1QgXAsmnUKRnvo/eNqzVSRQsM54qy
        Hg3GE+K0WLsVDA+KAUmLqtzhJ0mO7mc0e2uXDJcWEANB4Gumoyrud5tk1iTo1en2AOOENx
        Lv9+h8C2BZPsQvXq0pibuXhnEWT0JWrnU7e39BGxB8CGGuqx7G9/SvINKZEFrw==
Date:   Tue, 01 Aug 2023 19:50:34 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] Alternative color configuration for dmesg
In-Reply-To: <20230801134210.ayct6znedmnh5vhn@ws.net.home>
References: <e6370090700c26776e2ce6444a05a2d2@manjaro.org>
 <20230801134210.ayct6znedmnh5vhn@ws.net.home>
Message-ID: <fd2d84cc464af4ed22e21ea7f678b828@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-08-01 15:42, Karel Zak wrote:
> Hi,

Hello! :)

> On Sun, Jul 16, 2023 at 07:32:03PM +0200, Dragan Simic wrote:
>> I'd like to implement support for an additional, alternative way for 
>> the
>> color configuration in the dmesg utility.  It would use an environment
>> variable to store the color configuration, in a way rather similar to 
>> what
>> grep(1) does using the GREP_COLORS environment variable.
> 
> frankly, terminal-colors.d has been implemented to avoid environment
> variables :-)
> 
> Anyway, I have nothing against support for <util>_COLORS= if it will
> be implemented into lib/colors.c and the code will work together.
> 
> For example if terminal-colors.d/*.disable will force application to
> ignore <util>_COLORS= too.
> 
> The ideal solution will be if the env.variable will be just another
> way how to specify color scheme (alternative to .scheme file).

Great, thanks!  That's exactly what I had in mind:  the DMESG_COLORS 
environment variable would/will be just another way to specify the color 
scheme, and will work in parallel to the already existing 
terminal-colors.d mechanism.  That will keep the already existing 
terminal-colors.d option intact for those who prefer configuration 
files, and add another option for those who prefer environment 
variables.

> Maybe also follow conventions used by terminal-colors.d, it means
> scheme, enable and disable options, for example:
> 
>     DMESG_COLORS=disable
>     DMESG_COLORS=enable
>     DMESG_COLORS=alart:37;41,warning:37;42
> 
> (not sure about the format, this just brain-storming ... ;-)

That's exactly what I had in mind, :) to have the DMESG_COLORS 
environment variable reuse the disable/enable/scheme value layout, 
employed by the already existing terminal-colors.d mechanism.  That will 
keep the things uniform across the two different color-scheme options.

I'll move forward and start implementing this patch, following the 
approach we've agreed upon.
