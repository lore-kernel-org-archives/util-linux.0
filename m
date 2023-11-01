Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3EC4332F
	for <util-linux@archiver.kernel.org>; Wed,  1 Nov 2023 02:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjKAC4I (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Oct 2023 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKAC4I (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Oct 2023 22:56:08 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827FBD
        for <util-linux@vger.kernel.org>; Tue, 31 Oct 2023 19:56:02 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1698807359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4r2qdy/XX8LJDPXiEvfzTYBvs5xxjZV45b90QUn7h+k=;
        b=cF+jrCFVLDCphdgqBNeUqKUUfiThgAInkmB9+soQX4xJh0GyM/0ymuYkgncVkfFZ816qCh
        vLi2H2077Uwa+ByiC/Z72GxC/gRhIVYbrqaknRKpnwmCB2+Q70khJy+FSHOOTl/yIsZWrM
        lg7e+AlqadJqCmBr35P4KgFVZkhAK8jB+nicQCLUL7AOkSQMducXW7KkIRcsPXKlOubDri
        pKvRskgglbGcdXeHcjddxrqvhninZumcnCsz0EeKjt7OIdQbGCedpvcPQZtwBLVJ6uF2BR
        yTtH3ZLAtSQJRW25iEjnUUkP/NjqmhpdaQi6JHjzyW2ekt4Lt6mRfKPKP/+7ng==
Date:   Wed, 01 Nov 2023 03:55:59 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Emanuele Rocca <ema@debian.org>
Subject: Re: [PATCH] setterm: avoid restoring flags from uninitialized memory
In-Reply-To: <20231031135226.10243-1-zeha@debian.org>
References: <20231031135226.10243-1-zeha@debian.org>
Message-ID: <97bb06f8ada1efe436c24962f0ed8eb3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-10-31 14:52, Chris Hofstaedtler wrote:
> Depending on the used compiler and flags, previously either F_SETFL was 
> called
> with 0 or with a random value. Never with the intended previous flags.
> 
> Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
> Tested-by: Emanuele Rocca <ema@debian.org>

Looks good to me, FWIW.

> ---
>  term-utils/setterm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index 1bf9a5bb4..92bf75a46 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> @@ -846,7 +846,10 @@ static void tty_raw(struct termios
> *saved_attributes, int *saved_fl)
>  {
>  	struct termios tattr;
> 
> -	fcntl(STDIN_FILENO, F_GETFL, saved_fl);
> +	*saved_fl = fcntl(STDIN_FILENO, F_GETFL);
> +	if (*saved_fl == -1) {
> +		err(EXIT_FAILURE, _("fcntl failed"));
> +	}
>  	tcgetattr(STDIN_FILENO, saved_attributes);
>  	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
>  	memcpy(&tattr, saved_attributes, sizeof(struct termios));
> @@ -898,7 +901,7 @@ static int resizetty(void)
>  	ssize_t rc;
>  	struct winsize ws;
>  	struct termios saved_attributes;
> -	int saved_fl;
> +	int saved_fl = 0;
> 
>  	if (!isatty(STDIN_FILENO))
>  		errx(EXIT_FAILURE, _("stdin does not refer to a terminal"));
