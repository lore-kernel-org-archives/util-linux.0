Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB6C6379D
	for <util-linux@archiver.kernel.org>; Thu, 19 Nov 2020 08:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E049246CE
	for <util-linux@archiver.kernel.org>; Thu, 19 Nov 2020 08:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFENnCSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgKSIib (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbgKSIib (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 19 Nov 2020 03:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605775110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWQ6nbiaLEiiuANYRhj4RFJz/zlFRylSvmPdSDaiYpg=;
        b=hFENnCSBRSv3ihO4qlWST4KMGMuTC9WzSwyH5DNjWD2p0w6OfwIBA6y18KT5NU4hYVKrNg
        554sgRi2cbDTA1NOzVjTsRmDXoUEyINdlFbzFXH/HBOaZhckwcEeSu64yt653DZhYdZMgu
        EnVSHm1dE47wGLrfb4PNIC1KrJZhVZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-7DNPLibINPC9jqo9Yy6crA-1; Thu, 19 Nov 2020 03:38:25 -0500
X-MC-Unique: 7DNPLibINPC9jqo9Yy6crA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BAB21005D50;
        Thu, 19 Nov 2020 08:38:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7590460BE2;
        Thu, 19 Nov 2020 08:38:23 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:38:20 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v2 1/5] lscpu: use cluster on aarch64 machine which
 doesn't have ACPI PPTT
Message-ID: <20201119083820.q2sso5agv5v56bja@ws.net.home>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
 <20201114041229.26417-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114041229.26417-2-msys.mizuma@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Nov 13, 2020 at 11:12:25PM -0500, Masayoshi Mizuma wrote:
>  cpu_column_name_to_id(const char *name, size_t namesz)
>  {
>  	size_t i;
> +	int is_cluster = lscpu_is_cluster_arm(NULL);
>  
>  	for (i = 0; i < ARRAY_SIZE(coldescs_cpu); i++) {
>  		const char *cn = coldescs_cpu[i].name;
>  
> -		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
> +		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz)) {
> +			if ((!strncasecmp(cn, "cluster", namesz)) && (!is_cluster)) {
> +				warnx(_("%s doesn't work on this machine. Use socket."), name);
> +				return -1;
> +			} else if ((!strncasecmp(cn, "socket", namesz)) && (is_cluster)) {
> +				warnx(_("%s doesn't work on this machine. Use cluster."), name);
> +				return -1;
> +			}

This is very unusual for your utils and it makes scripts with lscpu
non-portable. It would be better to remove this change.

We usually follow the columns as specified by user and if we can't
fill any data then we return nothing (or "-"). For example you can use
"-o DRAWER" on system where this stuff is not supported.

>  			return i;
> +		}
>  	}
>  	warnx(_("unknown column: %s"), name);
>  	return -1;
> @@ -337,6 +348,7 @@ static char *get_cell_data(
>  		fill_id(cxt, cpu, core, buf, bufsz);
>  		break;
>  	case COL_CPU_SOCKET:
> +	case COL_CPU_CLUSTER:
>  		fill_id(cxt, cpu, socket, buf, bufsz);
>  		break;

  What about:

  case COL_CPU_SOCKET:
    fill_id(cxt, cpu, socket, buf, bufsz); 
    break;
  case COL_CPU_CLUSTER:
    if (cxt->is_cluster)
        fill_id(cxt, cpu, socket, buf, bufsz);
    break;

 It means "SOCKET" works everywhere, "CLUSTER" returns data only on
 ARMs with cluster(s).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

