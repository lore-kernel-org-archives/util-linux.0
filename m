Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4EC2B9F4
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6013861246
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFNUCW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:45206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235202AbhFNUCU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 16:02:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DCD611D4;
        Mon, 14 Jun 2021 13:00:17 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C57523F694;
        Mon, 14 Jun 2021 13:00:16 -0700 (PDT)
Subject: Re: [PATCH] lscpu: get the processor information by DMI
To:     Karel Zak <kzak@redhat.com>,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ec45d3f7-6c6f-08c7-3d0d-9f38723c1d97@arm.com>
Date:   Mon, 14 Jun 2021 15:00:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/14/21 5:41 AM, Karel Zak wrote:
> 
> CC: Masayoshi and Jeffrey,
> 
> On Mon, Jun 14, 2021 at 09:48:45AM +0000, Huang Shijie wrote:
>> The patch :367c85c47286 ("lscpu: use SMBIOS tables on ARM for lscpu")
>> relies on the existence of "/sys/firmware/dmi/entries/4-0/raw",
>> which may not exist in standard linux kernel.
>>
>> But "/sys/firmware/dmi/tables/DMI" should exist and can provide the required
>> processor information.
> 
> Good idea to add a fallback solution.
> 
>> This patch uses "/sys/firmware/dmi/tables/DMI"
>> to get the processor information:
>>    1.) Use the DMI to provide more accurate "Model name" information.
> 
> We've had a long discussion about data from DMI  and we had a few
> attempts to implement it ;-) The conclusion is to differentiate
> between information decoded from IDs and information from BIOS, so now
> we have two fields ct->bios_modelname and ct->modelname (and
> ct->bios_vendor).
> 
> The reason is that in some cases the strings from DMI do not provide
> well-known CPU names and info by user.
> 
>          Vendor ID:           ARM
>          BIOS Vendor ID:      https://www.mellanox.com
>          Model:               0
>          Model name:          Cortex-A72
>          BIOS Model name:     Mellanox BlueField-2 [A0] A72(D08) r1p0
> 
> "Cortex-A72" is pretty well-known, Mellanox BlueField is some
> marketing name, another example:
> 
>          Vendor ID:           Cavium
>          BIOS Vendor ID:      CN8890-2000BG2601-AAP-PR-Y-G
>          Model:               0
>          Model name:          ThunderX 88XX
>          BIOS Model name:     2.0


Yes, I was one of the people who asked that the DMI and the lookup table 
be displayed as different fields and so far it looks like its working 
well. Thanks!

> 
>> After this patch, we can get the lscpu output
>> in Ampere Altra platform:
>>     ---------------------------------------------
>> 	Architecture:                    aarch64
>> 	CPU op-mode(s):                  32-bit, 64-bit
>> 	Byte Order:                      Little Endian
>> 	CPU(s):                          160
>> 	On-line CPU(s) list:             0-159
>> 	Vendor ID:                       ARM
>> 	Model name:                      Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz

> 
> Should be
> 
>      Model name:          Neoverse-N1
>      BIOS Model name:     Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz

Right, another example :


Vendor ID:              ARM
   BIOS Vendor ID:       Broadcom
   Model name:           Cortex-A72
     BIOS Model name:    BCM2711 (ARM Cortex-A72)


Which is helpful when comparing with various other utilities, like gcc, 
which take cortex-a72 as -mtune parameters.

> 
>>   static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
>>   {
>> +	/* dmi_decode_cputype may get more accurate information later */
>> +	arm_ids_decode(ct);
>> +
>>   	/* use SMBIOS Type 4 data if available */
>>   	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
>>   		arm_smbios_decode(ct);
>> +	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
>> +		dmi_decode_cputype(ct);
>>   
>> -	arm_ids_decode(ct);
> 
> Please, do not move arm_ids_decode().
> 
>> +int dmi_decode_cputype(struct lscpu_cputype *ct)
>> +{
>> +	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
>> +	struct dmi_info di = { };
>> +	struct stat st;
>> +	uint8_t *data;
>> +	int rc = 0;
>> +	char buf[100] = { };
>> +
>> +	if (stat(sys_fw_dmi_tables, &st))
>> +		return rc;
>> +
>> +	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
>> +	if (!data)
>> +		return rc;
>> +
>> +	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
>> +	if (rc < 0) {
>> +		free(data);
>> +		return rc;
>> +	}
>> +
>> +	/* Get module name */
>> +	sprintf(buf, "%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
>> +			di.current_speed/1000, (di.current_speed % 1000) / 100);
> 
> So, it's not string from DMI, but it's composed from more information
> and it seems compatible to "model name:" from (x86) /proc/cpuinfo. I'm
> fine with it.
> 
>> +	free(ct->modelname);
>> +	ct->modelname = xstrdup(buf);
> 
> Please:
> 
>    ct->bios_modelname = xstrdup(buf);
> 
> 
>> +	/* Get CPU family */
>> +	memset(buf, 0, sizeof(buf));
>> +	sprintf(buf, "%d", di.processor_family);
>> +	free(ct->family);
>> +	ct->family = xstrdup(buf);
> 
> is there any difference between "cpu family" from /proc/cpuinfo and
> this DMI field? Do we need a new field ct->bios_family or overwrite
> the ct->family good enough? I don't know ;-)
> 
>    Karel
> 

