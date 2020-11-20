Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50614C5519F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 03:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC46122249
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 03:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am3RXacm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKTDZY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgKTDZY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 19 Nov 2020 22:25:24 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148DC0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 19:25:22 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so7798257qke.1
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uk+YxBN0/Y/XWS8zwCOtB/NKcuszw0poXNHTI7OuNA0=;
        b=Am3RXacmoaGqsed9kWVB8a75rQ+rKRj8UBnOM2j3oAUsAAx8svt+BIpSU8K0Sv2CDi
         AzbyqBON+FrfIslwCOkMbtjR7C/2N+S07SNJuf0kbl122W0rUCuKJukcnFGy73escQf/
         YJGZC0CDGzX3NqLZbo959GDJ6keRt/PAZrloSi8D/eBd7RFViVBZJFKYaGxwdUqbiFat
         NriLZGWTECnX3hrsa9QS2YBXuKPVE1+P9QdiX5QBjTxOF0RwfhXVSeyyMowrtlTpf4zj
         Wot2PEBWmtXGo8yDoOPiH21CR7h9O6rI6scWQCYauBvD8wt5ofXiCn2bLxkcQjzJXCuc
         /Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uk+YxBN0/Y/XWS8zwCOtB/NKcuszw0poXNHTI7OuNA0=;
        b=izq6EgCmzQ/JXnZTrmh0hOdqbr16ObamVKMjqLwz3HpmSvKeQoarwPwTpN8RiZ8SdO
         fLPpgoXicA2YzcQ1KUGpEdSrQwVr/+PK7K0p1SIbL8i4XsN3N8LSp3f1/IrKyMGeAn5z
         EQVH01Cfq2XyApN0X19cnvl+O26lj4ufjhoncGCYRYvDe5/Zhwl0yjVC/q5Kwum9FmHx
         8mA9p6rclMbIb9lj8/XkdkDf6S7kTgA5eYblnSZJPUX5bca5/BG4qfHN5BRubRDPN/J1
         oX0eIZpCfgCYCa/WY2Tr1d5ldoxbbr38hpKzQUeGt07EFEPnqMYKFeGkhVOAWQFSznY6
         n0Ew==
X-Gm-Message-State: AOAM533Di9USOhy7a+DnmDiS+PDFGqPOOC36JalyeEdq6iT/5OsS2cjT
        AguOVYtIZP4K7uqLhVCZZA==
X-Google-Smtp-Source: ABdhPJypn2OEbNzxzQYUQP8WNtlP832r/SjJdQaKqgCDpgVfXgRS5pSnPqe72+K8V6hS6g8yvuf76g==
X-Received: by 2002:a37:9b0b:: with SMTP id d11mr4366964qke.129.1605842721601;
        Thu, 19 Nov 2020 19:25:21 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id b25sm1281360qto.17.2020.11.19.19.25.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 19:25:20 -0800 (PST)
Date:   Thu, 19 Nov 2020 22:25:18 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v2 1/5] lscpu: use cluster on aarch64 machine which
 doesn't have ACPI PPTT
Message-ID: <20201120032518.6sncjeunsu3n444d@gabell>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
 <20201114041229.26417-2-msys.mizuma@gmail.com>
 <20201119083820.q2sso5agv5v56bja@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119083820.q2sso5agv5v56bja@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 19, 2020 at 09:38:20AM +0100, Karel Zak wrote:
> On Fri, Nov 13, 2020 at 11:12:25PM -0500, Masayoshi Mizuma wrote:
> >  cpu_column_name_to_id(const char *name, size_t namesz)
> >  {
> >  	size_t i;
> > +	int is_cluster = lscpu_is_cluster_arm(NULL);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(coldescs_cpu); i++) {
> >  		const char *cn = coldescs_cpu[i].name;
> >  
> > -		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
> > +		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz)) {
> > +			if ((!strncasecmp(cn, "cluster", namesz)) && (!is_cluster)) {
> > +				warnx(_("%s doesn't work on this machine. Use socket."), name);
> > +				return -1;
> > +			} else if ((!strncasecmp(cn, "socket", namesz)) && (is_cluster)) {
> > +				warnx(_("%s doesn't work on this machine. Use cluster."), name);
> > +				return -1;
> > +			}
> 
> This is very unusual for your utils and it makes scripts with lscpu
> non-portable. It would be better to remove this change.
> 
> We usually follow the columns as specified by user and if we can't
> fill any data then we return nothing (or "-"). For example you can use
> "-o DRAWER" on system where this stuff is not supported.

Thanks, got it. I'll remove this change.

> 
> >  			return i;
> > +		}
> >  	}
> >  	warnx(_("unknown column: %s"), name);
> >  	return -1;
> > @@ -337,6 +348,7 @@ static char *get_cell_data(
> >  		fill_id(cxt, cpu, core, buf, bufsz);
> >  		break;
> >  	case COL_CPU_SOCKET:
> > +	case COL_CPU_CLUSTER:
> >  		fill_id(cxt, cpu, socket, buf, bufsz);
> >  		break;
> 
>   What about:
> 
>   case COL_CPU_SOCKET:
>     fill_id(cxt, cpu, socket, buf, bufsz); 
>     break;
>   case COL_CPU_CLUSTER:
>     if (cxt->is_cluster)
>         fill_id(cxt, cpu, socket, buf, bufsz);
>     break;
> 
>  It means "SOCKET" works everywhere, "CLUSTER" returns data only on
>  ARMs with cluster(s).

Great idea! I'll fix it as that.

Thanks!
Masa
