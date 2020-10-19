Return-Path: <SRS0=4gC6=D2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308CC433DF
	for <util-linux@archiver.kernel.org>; Mon, 19 Oct 2020 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F3E223BF
	for <util-linux@archiver.kernel.org>; Mon, 19 Oct 2020 18:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq6l8OH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgJSSz2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSSz2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Oct 2020 14:55:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD7AC0613CE
        for <util-linux@vger.kernel.org>; Mon, 19 Oct 2020 11:55:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so1286956ilr.12
        for <util-linux@vger.kernel.org>; Mon, 19 Oct 2020 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7J6d9NHsnAOMjQEQ7Rr9eX46mWpR1221dxi0UG6an9Q=;
        b=Kq6l8OH/PPWQlNFlIJI1ki26bVv10e/eQJF+WmteuVUletu3KLqsdLKCHn7daeLld3
         U23qAa+slMqxAuA8v/IGqCodwoeB3woTPugxCWR8+awEXzIiks8NivZASK225I3YCHDZ
         jWHEV6XJeGIzhMIQBvrxsKlshOjSpj9jFaoCYhVFU20Y3t7JHZ4fqudQq31Apx3LRdvd
         TLQzx/MKiCb59YHgo1vSAokxPHNdWX6xKIKCiAGY77C713vIxUYdWB0hykiX9sVNhYnB
         B+cX7K/sFwczNGjVoDm5RqYgqW54AeVtYD7QXDeBAUumSiBhpAZPkr1tRWun4v9s7oei
         pqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7J6d9NHsnAOMjQEQ7Rr9eX46mWpR1221dxi0UG6an9Q=;
        b=qM71MIr4olro0MIcDdLCzwhC0fP8kVPsQB7kd7c4YxsEWwNzwY/BGhQtmLFxTY/ZjL
         UZiP5Y3XyyGvNXLD4MZGq5iWOvXXHsJjAUcg+hxwiSkeHADyzu42XwxPB0+du4oBd6cI
         Zi8hqKAAhn0LNXHHFq5VkFKaJ/+yi7ZT/La5nUbCiSrlwkTO63B5QEA9oyaphB4vPReC
         3gYI7J+sv0EB+da8KpyYv7Pzno1N7+MiQ3gPS/4/MGXPY1ZQ6s157lvBAb6cSzgkYoUg
         goH4tMvMuhAi3/GguFHBy9A8AfvDqZbwWEv08gX4+l8u1DYCdjyh9+uLJueKPBcHoAVf
         3PQg==
X-Gm-Message-State: AOAM531BCwri0dsumwAfyqIW0wlKjQ0/V4nAzdGBZ0OcyosJJTwYYFPU
        W2Vl1F/YVyRtZdjx6FrLbQ==
X-Google-Smtp-Source: ABdhPJxc4+VW1QE122aXLCu24lxoYwuyQTMd9ZRv1yn1jKsbaYcGvJ/Edus/VOEgSxfT4G1exzpdSA==
X-Received: by 2002:a05:6e02:11af:: with SMTP id 15mr1144439ilj.5.1603133727955;
        Mon, 19 Oct 2020 11:55:27 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id c85sm521277ila.88.2020.10.19.11.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 11:55:26 -0700 (PDT)
Date:   Mon, 19 Oct 2020 14:55:24 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Jeffrey Bastian <jbastian@redhat.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20201019185524.grdvarfrvw3hcbwp@gabell>
References: <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
 <20201001030519.6d65sqhd54oxmlic@gabell>
 <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <20201005133550.e5zvvtdfv44r64o2@tarantula.users.ipa.redhat.com>
 <20201008121012.nfeemhwih5dxnwjh@gabell>
 <20201015185321.i5ugnvlx5rq36yrl@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015185321.i5ugnvlx5rq36yrl@tarantula.users.ipa.redhat.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 15, 2020 at 01:53:21PM -0500, Jeffrey Bastian wrote:
> On Thu, Oct 08, 2020 at 08:10:12AM -0400, Masayoshi Mizuma wrote:
> > Hi Jeffrey,
> > 
> > Could you try the following patch?
> 
> This patch works for X-Gene and eMAG, but unfortunately it broke the
> output on the Altra.  The Altra is based on the Neoverse N1 design from
> ARM and so it inherited the N1 values in the MIDR register (at least on
> the prototype I'm using).
> 
> Before your patch:
> 
> [root@ampere-altra ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> Vendor ID:                       Ampere(TM)
> Model:                           1
> Model name:                      Ampere(TM) Altra(TM) Processor
> Stepping:                        0x3
> 
> After your patch:
> 
> [root@ampere-altra ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> Vendor ID:                       ARM
> Model:                           1
> Model name:                      Neoverse-N1
> Stepping:                        r3p1
> 
> Raw cpuinfo values:
> 
> [root@ampere-altra ~]# grep -m5 CPU /proc/cpuinfo
> CPU implementer	: 0x41
> CPU architecture: 8
> CPU variant	: 0x3
> CPU part	: 0xd0c
> CPU revision	: 1

Thank you for your testing! Probably the Altra should use SMBIOS info, not
hard corded table.

I'll send the v2.

- Masa
> 
> 
> 
> > ====================================================================
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Subject: [PATCH] lscpu-arm: Set the order to search the model name
> > 
> > After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
> > Model name for A64FX shows like as:
> > 
> >   Model name:       461F0010
> > 
> > That's because 367c85c47 changes to get the modelname from Processor
> > Version of SMBIOS.
> > 
> > The SMBIOS info would be great if the system is based on SBBR v1.2E and
> > BBR v1.0 because the specs require the Processor Version of SMBIOS
> > as "This field must provide a human readable description of the processor
> > part number".
> > 
> > However, it's not good for the systems aren't based on the specs,
> > like A64FX. Such systems need to have the model name to the hard
> > corded table.
> > 
> > Let's set the order; first, search the hard corded table, then SMBIOS.
> > 
> > Note, some systems, like APM X-Gene, may not match the information
> > between MIDR register (/proc/cpuinfo) and SMBIOS. To be consistency,
> > use Processor Manufacturer of SMBIOS when Processor Version is used
> > even if the hard corded table has the vendor id.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> > sys-utils/lscpu-arm.c | 30 ++++++++++++++++--------------
> > 1 file changed, 16 insertions(+), 14 deletions(-)
> > 
> > diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
> > index 20c7291e5..4e48f6d65 100644
> > --- a/sys-utils/lscpu-arm.c
> > +++ b/sys-utils/lscpu-arm.c
> > @@ -110,7 +110,6 @@ static const struct id_part cavium_part[] = {
> > };
> > 
> > static const struct id_part apm_part[] = {
> > -    { 0x000, "X-Gene" },
> >     { -1, "unknown" },
> > };
> > 
> > @@ -288,6 +287,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
> > 	struct lscpu_dmi_header h;
> > 	int fd;
> > 	ssize_t rs;
> > +	int use_smbios = 0;
> > 
> > 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
> > 	if (fd < 0)
> > @@ -301,16 +301,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
> > 
> > 	to_dmi_header(&h, data);
> > 
> > -	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
> > -	if (str) {
> > -		xstrncpy(buf, str, 127);
> > -		desc->vendor = xstrdup(buf);
> > +	if (!desc->modelname) {
> > +		str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
> > +		if (str) {
> > +			xstrncpy(buf, str, 127);
> > +			desc->modelname = xstrdup(buf);
> > +			use_smbios = 1;
> > +		}
> > 	}
> > 
> > -	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
> > -	if (str) {
> > -		xstrncpy(buf, str, 127);
> > -		desc->modelname = xstrdup(buf);
> > +	if ((startswith(desc->vendor, "0x")) || use_smbios) {
> > +		str = dmi_string(&h, data[PROC_MFR_OFFSET]);
> > +		if (str) {
> > +			xstrncpy(buf, str, 127);
> > +			desc->vendor = xstrdup(buf);
> > +		}
> > 	}
> > 
> > 	return 0;
> > @@ -318,14 +323,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
> > 
> > void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
> > {
> > -	int rc = -1;
> > +	__arm_cpu_decode(desc);
> > 
> > 	/* use SMBIOS Type 4 data if available,
> > 	 * else fall back to manual decoding using the tables above */
> > 	if (mod->system == SYSTEM_LIVE &&
> > 	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
> > -		rc = __arm_cpu_smbios(desc);
> > -
> > -	if (rc)
> > -		__arm_cpu_decode(desc);
> > +		__arm_cpu_smbios(desc);
> > }
> > -- 
> > 2.27.0
> > 
> > 
> > Thanks,
> > Masa
> > 
> 
> -- 
> Jeff Bastian
> Kernel QE - Hardware Enablement
> Red Hat
> 
