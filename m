Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3806C2B9F4
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735BE613F9
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFOCdn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:33:43 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com ([40.107.243.109]:19041
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229689AbhFOCdn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 22:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsI/eZ1+zu+F5toEbHrbJMWp/Rxnzhc7qh817TtQJuDFtPq4W8rRRDmQvKPX8MPkih+XJQA6nQ7F6xRV2DBv00Y55JTSPZ8Zjqje0Y8rb2Hmiw6y5tAXd09Jn2Akn14+cs32d3DsY6vyj04yg6Nduh4UV1WQX9UQw8xTdeg8FwJlQS+9cdKBg2GcYZuA8XXQVmsaeKYBT6LpPkaF+bfTG3kD+OcYddbwFPlPbYjs8WXU1nqCzVjuxs8/TqhBFOhYJq1tC6URAvM/LGKNgO9mTht3+DQS1tp2Y/norZt6NoZtbLvJli39l8Dfk2kErr/tO0ynA2VNOvTlbtsP8eCN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/3CTXDKKeI6Z+mgkexfnSnX2xJ654e3S8CoPSe088I=;
 b=QbAp9vUD5r92tvDbaI81hwnIV2OzK7GwX6vKAMQsLZ/M0/AztcpkMG+iwLWKpgvdQR9ku7F3ig/tuav8NlvPTdTg3MYu8LQxyzM3UXVo99oxizviuKibVCMt6EI4UPATFRMt1YExsSPO6lkLBGdNzFziPM0kpj7FiJoLBliakxl5i/splYz+9pgyVa2zDRWZI1Jqyrf5iYLrxFcecPRCvDVC5IHoprQIkY/W+MTEwPWvQJ7JB8buT8RbJ/ipptCLeepSpoQrFS0IelPeJjYfq7DNTO7dmqyQoVRDEFIxt+8MR08HqUmKF6FJwXOhDONZY6V04o2aT6Jedd6U/phLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/3CTXDKKeI6Z+mgkexfnSnX2xJ654e3S8CoPSe088I=;
 b=mYitozLnCqQ9yePVConEtIpR4u51jGGi8089GqQySZnCyHVxDiGvtWBqkK1QewogRYzIwRtCovY9jpBXBq+mVXSUy+kmqspg3DBDudLo9zG5qaG3BOvS2X/Q0PrzOlm7pkXznVL72TJfnjTk0MvX7vrIvdN9D7WhF42m8IOOOf8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR01MB3312.prod.exchangelabs.com (2603:10b6:300:fe::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Tue, 15 Jun 2021 01:21:44 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 01:21:44 +0000
Date:   Tue, 15 Jun 2021 09:20:55 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <YMhw94JMDieTpqLA@hsj>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:910:16::16) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CY4PR1201CA0006.namprd12.prod.outlook.com (2603:10b6:910:16::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 01:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf4bef3-b98c-4c58-9388-08d92f9bef82
X-MS-TrafficTypeDiagnostic: MWHPR01MB3312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB3312A053AE1C4BFECB7123BCED309@MWHPR01MB3312.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF1fLhTYFNBcDVQqvBmjVqc1GyKsTNrMPkrdFsNhhYGHYr4FW4yJVViaOLDqti75Yg0gInnRJVSi15ucIN1JjCoPcXRh/vVb5SSpjnaVSgqvQgXFtkcJfH7lvq+Ua6jCuSGXH6/UL0jSn4Ngjez4ISBVF1wpxGHExIruM30d+szJotC6K64IO+7Yz1HhZnsGiUQn1nd8i6Aw5KKlGrdXTVy9WydMIGor4BreVVS/6J9RQGfmbRIUgrLmlb9VAhkOaDwEuDrveGu/Fg97VjaLFNnwLr2MEmeDF3nfHUC63Kumo6VYB201ETmo4U1BPQAfWfW68n7CcEfe6IH5Q0QBsPKFjd4Aas02vDkbHG9UxWmeIcorVH4PMm1rinS4A5gukukKVLBCpFa9nbwDN2FhQEDetHt3dBSUNqw711KVfq65rHiJuaJ1mAJeIkg0aaAjme8oeTNFTGMfeIeRc51iJfA/kdDndK5f0KKSe87zV1C017dL5L/Ch+7mZzs3Bgq2y40S6nFZRDJH8u8sd2KiQq2WZor+MDQWNnPL8VVoDAINHHYtRTR32sjvT/hFnl5w4FViY8luPx2l9QOizks7+IwO+a2h0GfBdsXox3bJ4mZ6AicO8lT6CdhcKVZkISHUrvBBzW5QvWzkXJBsZ3U4r+MRFn1pxpWmQdg//CIEA92Cj2eaX6gSOKmTg6FEacitnkIXsOUjhPik7kLTvQ8hlUG1Vgk0rQ2YEBkqCSEOzR2SsDVxmryLnzSpz+g7kElLCcG7jy+MVIp/atcw+pA8qicAr9+KMEmeb+5cg1tynGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(6496006)(9686003)(8936002)(52116002)(8676002)(33716001)(956004)(316002)(9576002)(4326008)(6916009)(66556008)(66946007)(6666004)(478600001)(83380400001)(2906002)(966005)(66476007)(55016002)(26005)(186003)(16526019)(5660300002)(86362001)(38350700002)(38100700002)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0x7vxywz78MqSZ4vpOUr+XvMNJEYIzOPUcDPxVv8IGw9sl4Ewfc3wN9DB6X?=
 =?us-ascii?Q?sStpGLMY83bPvAudd806hrIDoxTRifP31rScbNq2gbvMBv7K9iGqrMm8osJV?=
 =?us-ascii?Q?HsyZ6sS9yBjwW2tn1vJuVV9ZURJUFp8W+z7UFc+wHpY/7muDrdNG52Q/X5oF?=
 =?us-ascii?Q?iEzU9SeVsMRfpuwwj/IPD25yi9gZqKp2HxIEgUnCXCGOm/P7bCUI8VeJ+PgN?=
 =?us-ascii?Q?02hhMbv2nrUZ5PRCeID2SEKSjVWej12/V7idkxdz9C9VWzgzJTzqFYRkDNgK?=
 =?us-ascii?Q?p4Ipk90ZJv5yQXv61alLUdITHhkXD40TD/QCNQDXoujLW+SnX9bQNrEqE3m+?=
 =?us-ascii?Q?TVnLpKCYIVMtb3MwRZG/Pr6SsL0BGWyT7POr8Lzq9Hv9CHpokOzZDy9vp6xf?=
 =?us-ascii?Q?13Udo1Ey/bxgRM5CAvaptaBKJqeoPW0s/c+sApU0ORujwxRe7/80Yb+jbpOT?=
 =?us-ascii?Q?ngA7i3CLQuMQivNI9/9jqWE9MxnwqDWsm/3irgxyLm9r85d7ZRljfv3SWCSs?=
 =?us-ascii?Q?GtvnPOO+KYCg0whrBLgyYll8nlDnpi1a4snKgo+7EuMB3rGSLi6kBL9D6jlb?=
 =?us-ascii?Q?vqS9wQGM1/CEh+Kdz+B8WZvwkY/YiWSwQYatZwMXrp89jCPCVBmJEPO1OYYG?=
 =?us-ascii?Q?rMw+Ad+m96eYSN7yY2g7MtLBCn8N0UFlWBk8ex/yFbsPRwu+zEqBM0iEdtIo?=
 =?us-ascii?Q?NjhcLik7nX0mMXekA4RzWqCCviv65nNbiwAb+16tNNQdjjJdkOb3T80gOSFe?=
 =?us-ascii?Q?Xocx+VAV6AJfu02ALYJsFl+Vp7IXbWEMBhdaNjn/OL2I54dwJjhYOKCe/a/w?=
 =?us-ascii?Q?8yagxo0UzbzwEmoQqOcYsKoYBQRn+oHyqui6LKHMw7uVRGPB5Y36Rn7eed4O?=
 =?us-ascii?Q?2iV9sOwvvXBEUulBq5Wsest/3sdXp7bdkySx5d4OxxHcKT0+hPdMpnTQsjFw?=
 =?us-ascii?Q?5Prkyr1O9HU4Nrc6hejY7rBy9XviHTAESiauzsjYfKfAX/F9iQnMm1aVNpNo?=
 =?us-ascii?Q?OdFH6ZSKXKZE3TlejqVsZtxgeKP63SFfrco9vaAO7M97efew52lLEnNXa+Qt?=
 =?us-ascii?Q?Blpev9ybLMq00zUNMMi60ZMMmibeR2P3BfxH7Mk1OtnvpgZTlI1qe6rKJPf1?=
 =?us-ascii?Q?3+jI7QbiU1baIA16/JS3TXS5mqWB8rPgu1kA0JetwdkOLesdrl0T+mRH612n?=
 =?us-ascii?Q?Zk0eTs0RqCsbWCQVq2MNhrcZ33N+TdMk0EgJKCIx7QjgbzQKqhu1fz6+AXtZ?=
 =?us-ascii?Q?CGl+R8sFyizH8CSl3N5xZb3uQWRQ3Aiw6oAWh1LJqGY+dLRSNPBHuWzxnkh9?=
 =?us-ascii?Q?g4bIvZkHjNJLwJQACSbCa/+F?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf4bef3-b98c-4c58-9388-08d92f9bef82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 01:21:43.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGo4XN1vQ/K28s1BnJkoN1w8W2X/JUcQAbFeUI1XjdHPBXemKfxNMzaAyhgNknIJuW4cNJQD1THVe1tdWXBPGHHJy2DnCDV4p2DWYCJlg/DvaBMtKORM6W3JuqA8b6Ha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3312
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 14, 2021 at 12:41:26PM +0200, Karel Zak wrote:
> 
> CC: Masayoshi and Jeffrey,
> 
> On Mon, Jun 14, 2021 at 09:48:45AM +0000, Huang Shijie wrote:
> > The patch :367c85c47286 ("lscpu: use SMBIOS tables on ARM for lscpu")
> > relies on the existence of "/sys/firmware/dmi/entries/4-0/raw",
> > which may not exist in standard linux kernel.
> > 
> > But "/sys/firmware/dmi/tables/DMI" should exist and can provide the required
> > processor information.
> 
> Good idea to add a fallback solution.
> 
> > This patch uses "/sys/firmware/dmi/tables/DMI"
> > to get the processor information:
> >   1.) Use the DMI to provide more accurate "Model name" information.
> 
> We've had a long discussion about data from DMI  and we had a few
> attempts to implement it ;-) The conclusion is to differentiate
> between information decoded from IDs and information from BIOS, so now
> we have two fields ct->bios_modelname and ct->modelname (and
> ct->bios_vendor).
Okay. 

I will the ct->bios_modelname/ct->modelname /ct->bios_vendor in  next version.

> 
> The reason is that in some cases the strings from DMI do not provide
> well-known CPU names and info by user.
> 
>         Vendor ID:           ARM
>         BIOS Vendor ID:      https://www.mellanox.com
>         Model:               0
>         Model name:          Cortex-A72
>         BIOS Model name:     Mellanox BlueField-2 [A0] A72(D08) r1p0
> 
> "Cortex-A72" is pretty well-known, Mellanox BlueField is some
> marketing name, another example:
> 
>         Vendor ID:           Cavium
>         BIOS Vendor ID:      CN8890-2000BG2601-AAP-PR-Y-G
>         Model:               0
>         Model name:          ThunderX 88XX
>         BIOS Model name:     2.0
> 
> > After this patch, we can get the lscpu output
> > in Ampere Altra platform:
> >    ---------------------------------------------
> > 	Architecture:                    aarch64
> > 	CPU op-mode(s):                  32-bit, 64-bit
> > 	Byte Order:                      Little Endian
> > 	CPU(s):                          160
> > 	On-line CPU(s) list:             0-159
> > 	Vendor ID:                       ARM
> > 	Model name:                      Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
> 
> Should be 
> 
>     Model name:          Neoverse-N1
okay..				      
>     BIOS Model name:     Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
> 
> >  static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
> >  {
> > +	/* dmi_decode_cputype may get more accurate information later */
> > +	arm_ids_decode(ct);
> > +
> >  	/* use SMBIOS Type 4 data if available */
> >  	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
> >  		arm_smbios_decode(ct);
> > +	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
> > +		dmi_decode_cputype(ct);
> >  
> > -	arm_ids_decode(ct);
> 
> Please, do not move arm_ids_decode().
no problem.
> 
> > +int dmi_decode_cputype(struct lscpu_cputype *ct)
> > +{
> > +	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
> > +	struct dmi_info di = { };
> > +	struct stat st;
> > +	uint8_t *data;
> > +	int rc = 0;
> > +	char buf[100] = { };
> > +
> > +	if (stat(sys_fw_dmi_tables, &st))
> > +		return rc;
> > +
> > +	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
> > +	if (!data)
> > +		return rc;
> > +
> > +	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
> > +	if (rc < 0) {
> > +		free(data);
> > +		return rc;
> > +	}
> > +
> > +	/* Get module name */
> > +	sprintf(buf, "%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
> > +			di.current_speed/1000, (di.current_speed % 1000) / 100);
> 
> So, it's not string from DMI, but it's composed from more information
> and it seems compatible to "model name:" from (x86) /proc/cpuinfo. I'm
> fine with it.
Thanks.

> 
> > +	free(ct->modelname);
> > +	ct->modelname = xstrdup(buf);
> 
> Please:
> 
>   ct->bios_modelname = xstrdup(buf);
okay.
> 
> 
> > +	/* Get CPU family */
> > +	memset(buf, 0, sizeof(buf));
> > +	sprintf(buf, "%d", di.processor_family);
> > +	free(ct->family);
> > +	ct->family = xstrdup(buf);
> 
> is there any difference between "cpu family" from /proc/cpuinfo and
> this DMI field? Do we need a new field ct->bios_family or overwrite 
> the ct->family good enough? I don't know ;-)
> 
In the arm platform, it seems it does not show the "cpu family" info in lscpu.
And I did not find the "cpu family" in the /proc/cpuinfo, only find "cpu architecture: 8".
Unfortunately, the "cpu architecture :8 " is hardcode, it will be changed for armv9 in future.

In the DMI, the "cpu family" shows 0x101 which means "arm v8".

Thanks
Huang Shijie
