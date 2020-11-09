Return-Path: <SRS0=8RqP=EP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C6C388F9
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 03:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92527206E3
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 03:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvvv1pq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgKIDBy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKIDBy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2020 22:01:54 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD1FC0613CF
        for <util-linux@vger.kernel.org>; Sun,  8 Nov 2020 19:01:53 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so5136254qtx.3
        for <util-linux@vger.kernel.org>; Sun, 08 Nov 2020 19:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8nAGv2641jeb1ii6p2U8apCVcHQjrFSpepIqZytdIVo=;
        b=Pvvv1pq8akHsghh1Sauqaaq0PWFbo8I2sf8mskoid0YhmHGw8SjIBGeJtaZ5RRmvqI
         ZnfCYx2cgfPQSBg39iS/aF9xwFwueZrb78+ArliHabnKXs0Jwo4mikjUR4QJp9FJI6hL
         Afoajo87Hz1dkzCrYN0V+pOS6aM9IGcFoiJVOo1+6Q9wf+TS/9Ijsy3dWlKdCvhLRcDC
         kptQjA9oY3lxdDwW2XMoSOAeLT5SU9jLvCnWjkukUQPDR9rFIEmcteMrw1Gxwm1tP83W
         pM7YgSRYzA/8p02PWFwcV20NjCNvNYj2j5SX5oP4UBQNkhYAwiXBvhR1RYW3+n7pe3bu
         WcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nAGv2641jeb1ii6p2U8apCVcHQjrFSpepIqZytdIVo=;
        b=Oy/BzwJaelWGuUAPvE+30h4FBk0Rm84WBnz9oebY7W3ArvJLAOx3Pkl8sD2tFZuB7A
         xQUnQCVhCD23NB0CkUlphVo6Kkz8W4EizfAn8mqblIVmpyU0pFGsX1VWwZVwInnlET0+
         YnYCaBNRChjHsTXPOw5RdkUrmZF6FTt6oaT8i1+P05XmkenWFoxiT0tDDRhTj7VMnNRa
         qgIfWeguu5pL1BBXD8H8Dlwg8/C8S7/MVxXLjPzKVOFePHt8Uy402jT2Dl+RbW8QJJtI
         2lauiW2QHS/4ak4szyzCJr13RB5jc/sTM/IbHfdX4w5v8ci848yGp6Zjyq8De4K7M5VQ
         /iqA==
X-Gm-Message-State: AOAM533Q5bHNVpolIrYeBDRcRdqt4QYlXP1YzzFfUJc9pFcnQkb10LkJ
        rqLO9i+x/4jFmIFYACK3Hfm7jo25hw==
X-Google-Smtp-Source: ABdhPJwFMSxDFaczCR4BXIWbXvgfCZ7rvda39tjcm2Kxl8DJsklaH+P7jj9dD2B35GdKk+gfR7GWYg==
X-Received: by 2002:ac8:59cb:: with SMTP id f11mr11876800qtf.367.1604890913116;
        Sun, 08 Nov 2020 19:01:53 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id q28sm5673636qkn.39.2020.11.08.19.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Nov 2020 19:01:52 -0800 (PST)
Date:   Sun, 8 Nov 2020 22:01:50 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org, jbastian@redhat.com
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v3 1/2] lscpu-arm: Set the order to search the model name
Message-ID: <20201109030150.ivqlla6ixgf76t62@gabell>
References: <20201109025806.26567-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109025806.26567-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Oops... I forgot to add Signed-off. Will resend them soon.
Sorry about that.

On Sun, Nov 08, 2020 at 09:58:05PM -0500, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
> Model name for A64FX shows like as:
> 
>    Model name:       461F0010
> 
> That's because 367c85c47 changes to get the modelname from Processor
> Version of SMBIOS.
> 
> The SMBIOS info would be great if the system is based on SBBR v1.2E and
> BBR v1.0 because the specs require the Processor Version of SMBIOS
> as "This field must provide a human readable description of the processor
> part number".
> 
> However, it's not good for the systems aren't based on the specs,
> like A64FX. Such systems need to have the model name to the hard
> corded table.
> 
> Let's set the order; first, search the hard corded table, then SMBIOS.
> ---
>  sys-utils/lscpu-arm.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
> index 20c7291e5..3f258a710 100644
> --- a/sys-utils/lscpu-arm.c
> +++ b/sys-utils/lscpu-arm.c
> @@ -288,6 +288,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
>  	struct lscpu_dmi_header h;
>  	int fd;
>  	ssize_t rs;
> +	int use_smbios = 0;
>  
>  	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
>  	if (fd < 0)
> @@ -301,16 +302,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
>  
>  	to_dmi_header(&h, data);
>  
> -	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
> -	if (str) {
> -		xstrncpy(buf, str, 127);
> -		desc->vendor = xstrdup(buf);
> +	if (!desc->modelname) {
> +		str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
> +		if (str) {
> +			xstrncpy(buf, str, 127);
> +			desc->modelname = xstrdup(buf);
> +			use_smbios = 1;
> +		}
>  	}
>  
> -	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
> -	if (str) {
> -		xstrncpy(buf, str, 127);
> -		desc->modelname = xstrdup(buf);
> +	if ((startswith(desc->vendor, "0x")) || use_smbios) {
> +		str = dmi_string(&h, data[PROC_MFR_OFFSET]);
> +		if (str) {
> +			xstrncpy(buf, str, 127);
> +			desc->vendor = xstrdup(buf);
> +		}
>  	}
>  
>  	return 0;
> @@ -318,14 +324,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
>  
>  void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
>  {
> -	int rc = -1;
> +	__arm_cpu_decode(desc);
>  
>  	/* use SMBIOS Type 4 data if available,
>  	 * else fall back to manual decoding using the tables above */
>  	if (mod->system == SYSTEM_LIVE &&
>  	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
> -		rc = __arm_cpu_smbios(desc);
> -
> -	if (rc)
> -		__arm_cpu_decode(desc);
> +		__arm_cpu_smbios(desc);
>  }
> -- 
> 2.27.0
> 
