Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D76C4743C
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B885861447
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 10:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhFNKqJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234018AbhFNKng (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 06:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623667293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7Zv3aFmUtBW1li7z/s1Q46fdmPo/ypely3J4UYgo3U=;
        b=N/fhuC8Db5QUJ+vDeyJb1md+eY6kRnOa4vPMCPuqIFLFMlCBxoIhHelxDD0qCnWkreAdAv
        /XUvJGlpXmqXDqJDmwQI8tLNVH43c/21g/xANm3jCUmRQ3GAh4b7PzLKP7LzeXf0WUwk+H
        uzGHas7wWhp/0hsZQh2l9Lk9qkStCS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-it92l3uLPLa1JdK7_yRZ7Q-1; Mon, 14 Jun 2021 06:41:32 -0400
X-MC-Unique: it92l3uLPLa1JdK7_yRZ7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E84D0100B3AC;
        Mon, 14 Jun 2021 10:41:30 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5815C233;
        Mon, 14 Jun 2021 10:41:29 +0000 (UTC)
Date:   Mon, 14 Jun 2021 12:41:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614094845.13958-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


CC: Masayoshi and Jeffrey,

On Mon, Jun 14, 2021 at 09:48:45AM +0000, Huang Shijie wrote:
> The patch :367c85c47286 ("lscpu: use SMBIOS tables on ARM for lscpu")
> relies on the existence of "/sys/firmware/dmi/entries/4-0/raw",
> which may not exist in standard linux kernel.
> 
> But "/sys/firmware/dmi/tables/DMI" should exist and can provide the required
> processor information.

Good idea to add a fallback solution.

> This patch uses "/sys/firmware/dmi/tables/DMI"
> to get the processor information:
>   1.) Use the DMI to provide more accurate "Model name" information.

We've had a long discussion about data from DMI  and we had a few
attempts to implement it ;-) The conclusion is to differentiate
between information decoded from IDs and information from BIOS, so now
we have two fields ct->bios_modelname and ct->modelname (and
ct->bios_vendor).

The reason is that in some cases the strings from DMI do not provide
well-known CPU names and info by user.

        Vendor ID:           ARM
        BIOS Vendor ID:      https://www.mellanox.com
        Model:               0
        Model name:          Cortex-A72
        BIOS Model name:     Mellanox BlueField-2 [A0] A72(D08) r1p0

"Cortex-A72" is pretty well-known, Mellanox BlueField is some
marketing name, another example:

        Vendor ID:           Cavium
        BIOS Vendor ID:      CN8890-2000BG2601-AAP-PR-Y-G
        Model:               0
        Model name:          ThunderX 88XX
        BIOS Model name:     2.0

> After this patch, we can get the lscpu output
> in Ampere Altra platform:
>    ---------------------------------------------
> 	Architecture:                    aarch64
> 	CPU op-mode(s):                  32-bit, 64-bit
> 	Byte Order:                      Little Endian
> 	CPU(s):                          160
> 	On-line CPU(s) list:             0-159
> 	Vendor ID:                       ARM
> 	Model name:                      Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz

Should be 

    Model name:          Neoverse-N1
    BIOS Model name:     Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz

>  static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
>  {
> +	/* dmi_decode_cputype may get more accurate information later */
> +	arm_ids_decode(ct);
> +
>  	/* use SMBIOS Type 4 data if available */
>  	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
>  		arm_smbios_decode(ct);
> +	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
> +		dmi_decode_cputype(ct);
>  
> -	arm_ids_decode(ct);

Please, do not move arm_ids_decode().

> +int dmi_decode_cputype(struct lscpu_cputype *ct)
> +{
> +	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
> +	struct dmi_info di = { };
> +	struct stat st;
> +	uint8_t *data;
> +	int rc = 0;
> +	char buf[100] = { };
> +
> +	if (stat(sys_fw_dmi_tables, &st))
> +		return rc;
> +
> +	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
> +	if (!data)
> +		return rc;
> +
> +	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
> +	if (rc < 0) {
> +		free(data);
> +		return rc;
> +	}
> +
> +	/* Get module name */
> +	sprintf(buf, "%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
> +			di.current_speed/1000, (di.current_speed % 1000) / 100);

So, it's not string from DMI, but it's composed from more information
and it seems compatible to "model name:" from (x86) /proc/cpuinfo. I'm
fine with it.

> +	free(ct->modelname);
> +	ct->modelname = xstrdup(buf);

Please:

  ct->bios_modelname = xstrdup(buf);


> +	/* Get CPU family */
> +	memset(buf, 0, sizeof(buf));
> +	sprintf(buf, "%d", di.processor_family);
> +	free(ct->family);
> +	ct->family = xstrdup(buf);

is there any difference between "cpu family" from /proc/cpuinfo and
this DMI field? Do we need a new field ct->bios_family or overwrite 
the ct->family good enough? I don't know ;-)

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

