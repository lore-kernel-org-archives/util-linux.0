Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D29C2B9F4
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85E661153
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFOCZ1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:25:27 -0400
Received: from mail-bn8nam08on2125.outbound.protection.outlook.com ([40.107.100.125]:27130
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231483AbhFOCZY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 22:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOEoFwG/1Xar3IITlmXnbVI1F3B0j1/6NDGz3KRr9cp6FPzm/BSxBRMbPgpftp0Lv3BVw2CavKgrBzyUszBs1/0mTCj7pFZos3wNh3g4aXe2AioNh9hje9m4yGVydu9Qd469GAH/Pkm/B9DQnLihf1/bqY89htVXatYpOUt1w4XcIje2m3wBa5hbtRS4hX4M5Zbpxb03ZZtSaPg6h5pk+0k6zOuZF+A/L1jK5ud2zBs9TjZsYIQCpWAO5SpVEjDxRSUjfmGYl94R8FR6H0PLrSPB/lJ4ksWiAjGjxFbIYnmRd078UrvJG8N3cmscC+1/LLa9Fsma51drkxEQt0bObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgWihsYhUD0kab7XpMJySIfLnq4Gy18686BI/u4S4Uk=;
 b=ob9DkL5kZbySj7JhdBJD2KYdzRjX9gDQ9sZrJj/f7GXzwQNRQ1005IjimkpIIHSAA37yxj4LsHuLFcePLC1tsLbVCX7CQmRtcKQOpQ6Pkd4nSdcQON2BHzKCIHqAHlzXXZthmnm70N/hz9Tu55uM4/6dNggNho9UZY3osHFwI2JOxFzBrdmHK9WgU/soEXZflUV5qo3fkaw3t9rZKKyTFkRuQy9iAPYFUxopTgPfL+yZR0HbAu8zyc8dc1SGxWpOuH41yF8krfPcc539FCpLkW7JCEaUTr47krZH5Qb9M46p5qpQrwpeq/x9ruXbmVy+xCsKjWENOKW00oRS8M+oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgWihsYhUD0kab7XpMJySIfLnq4Gy18686BI/u4S4Uk=;
 b=s+fBScmCt8drT+uXWZ8DRlMR2mtIvxn5rOD/ZU9ap19BmrFPsO1wDWsiExbua4FNdJsqJGS4rt7NVBFT7jDCqxd5/gMGs4M3V3LeZgIWYy0Wth7wUuaPIUfQ+yp0vFV2Vw7YS4QRwI450f2IQVZn5FNr1VwaJ+6Qv+f0KZ04mTs=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO1PR01MB6631.prod.exchangelabs.com (2603:10b6:303:fb::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 15 Jun 2021 01:23:50 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 01:23:50 +0000
Date:   Tue, 15 Jun 2021 09:23:01 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        patches@amperecomputing.com, zwang@amperecomputing.com,
        mas@amperecomputing.com, ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <YMhxdX+e2Kkx/++w@hsj>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
 <ec45d3f7-6c6f-08c7-3d0d-9f38723c1d97@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec45d3f7-6c6f-08c7-3d0d-9f38723c1d97@arm.com>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:903:ae::32) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CY4PR22CA0070.namprd22.prod.outlook.com (2603:10b6:903:ae::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 01:23:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9119052c-b21d-461e-a777-08d92f9c3b19
X-MS-TrafficTypeDiagnostic: CO1PR01MB6631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB66310AFF784CFA5EC9C67D26ED309@CO1PR01MB6631.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSm/PhCvgDEMxPaGruIzAe2jx5Hay5RdTf0TUmn3aZuOf11HDcT/iwee7XlaTM/iVRvGNWOt1fB4+r5bBnzjppG3Q/6L7Zs+xUoRAtPLLiyoWQgeHwAlBcz08elGesAductSQMg6qaNb9M5LkgucJ5J95uP9zB8CDWEYEqsMZSB8a+Zn8W32nsRiCbuaqWx5DNLVZOdWGig9AqbM1Ow4yyPVYkaRDF/cXqANcN7t+1ohOnJAI6J89NUmP7tGHCqrSyABFhYHrEtF85HbdTg2qbnPKFQqSXEblDoPHSs9MVxLQIaB3uCj30NiW9GH3N2hHXx3JPLIT75G3WBkvPFHtfMqja4UTKG2u9QcCD6elEJgNm6eEFGHSrmksXIyAiBJhAGdKgvL57VdH+thg9DsmwU0nCGEZJKq2XPQYRdBcj4YHQxXW81TEMoPrg09Qhgpu/E0DlycEuR+O6GxNbzCxGxJ/cMgMN+VpwyU/sjqHxUBAFpGu0Xc26ouyY0X8KizvGieVBwtYetfUuSotDNjD6tRVvRkBAV/nzffkAzTdpre7rEpHu6O9PqN77QvXak3OoWbwM/comnZYsCbap1zLyBvMF4pIGSVq56XOR8DM/41v+QyV57w6pkzhUPAqtpff7NKLHLFbG4kfnM71vSXQo3gx5o7elEmTmJaxXhghFPn0tICHTnT1luR+wJn6YQv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(6496006)(956004)(6916009)(8676002)(478600001)(33716001)(86362001)(52116002)(4744005)(316002)(8936002)(6666004)(2906002)(5660300002)(16526019)(9576002)(66556008)(66476007)(83380400001)(54906003)(4326008)(66946007)(186003)(26005)(38350700002)(55016002)(38100700002)(9686003)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IyJskAYn5dF+I4nLbHcE9fSoLEA+qje6D4huKawKBQ3zBXz2j28CCNSXqoS1?=
 =?us-ascii?Q?n+PmwPBk9NOMfq3szatZQo3M0evyufGFVC0FmlN+l+xV6lKOhDSxqriMiIba?=
 =?us-ascii?Q?0xmTVCrqk2oB/33RsLCB5Nw0ogNT4jQ3x7i0eFUVmbkUEaXZnfMjZcPj3Cyh?=
 =?us-ascii?Q?fo2czNwoyCdyK0+WlQV5Q7xM+6C4lofySCZscgZUn9zdfum+BC3AxdaQh/LC?=
 =?us-ascii?Q?5l8BA20ifuBjTq98SNTeOvEuLwN+0NqSGXRnIv0uohgCE3iwIq+6hdQxHW06?=
 =?us-ascii?Q?FFwXuQgySliYIoScSfTnPYizIiGHbPQ3L0STO5TCQj7lpsmaZmxonjcesrlh?=
 =?us-ascii?Q?/PfN10duPuvlGEv6m4vpOc4Rlq1VqTS9fcnvAyoB0Q6RQbT/9NSZIpGWex3n?=
 =?us-ascii?Q?pVJQ+t8XCPIU3SX3ElaT66V7Q/bHb9rX/GadUIQJQLGnYd1dYSgAyCJToEjr?=
 =?us-ascii?Q?YPcZVqQ1trurAJmGjbpoccfPnYZo463dv4QzZsc3lSdyQtkNZFoK5pNNf4IW?=
 =?us-ascii?Q?v4t6PPw5Bt9TKu9za/gKjTVCdLMPBXq4L0EqPDzxm+UxtX/twLXNpiE236f8?=
 =?us-ascii?Q?2e0DOQl/ymm1WycgJGEFVU15Scvm8Dmd0JaEDqZfSy93+vjLzEw2vqQEnaIV?=
 =?us-ascii?Q?XBn9UQiCnwhNoABjHE/WZUtFgpHjOlntgMD/3p5tiHMarp5nAVN7OTZjkglF?=
 =?us-ascii?Q?rMaXnu2z9783Izf0lhinwPd/4OdExJCwrF6tgekeTX9eT8yiH79yCzXF/NRb?=
 =?us-ascii?Q?LFdipJQdju80b2mif0I4EqVaIs3ReinYhINPs/OiZZqD6ldpvZyPTVxnDOPW?=
 =?us-ascii?Q?+J0eOVDiNEYzCwyM7GOyVaZ1PqjT4OIvb99C5j7mY40Z+v/bGbWDkltgxBQU?=
 =?us-ascii?Q?7MQ7Su+fEjFtCGbuk3+jh4y+edlW85TK8nZRqa+PjCsjcvtUN8sIlL5YikZu?=
 =?us-ascii?Q?YbLGk/zBY+U83PzpFTT5LQS6FKjn87Sb7VstAu+iKHmHkyhA8OrnX0/D59z2?=
 =?us-ascii?Q?GP3YGXPNTQVDwwm9gUk2Jr5dOEUk9wxuDjUwIXYCvv+xJP/0KF/tjqLrW1lC?=
 =?us-ascii?Q?zZoX5eDQV10gdEUf/PEVs0X2MCqyfzEcUihXoJF784nmsEWflAGWM76hV3n2?=
 =?us-ascii?Q?vOxBMGnmTAbM8h/Xz1L6WPUZCnw4/4tJFehMuYCnwctTQ9Ft7wlQFwoFB2zP?=
 =?us-ascii?Q?CnW106OAlEceNbZaN7fSk0RVYO2/0jBHfv6b37XTyj8ckaF0nF9s86rf2S6p?=
 =?us-ascii?Q?CECcvXoFEzgXOAUONPj0POirPQpJckbZFPe1caCT6zrVxTn5Z5ZwBlw7+gI0?=
 =?us-ascii?Q?sGeCcDNIK1dax9mvLZDZQoM6?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9119052c-b21d-461e-a777-08d92f9c3b19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 01:23:50.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCRHezZI15QnZVUMv1gCQKiJJtwJif25tFqB25tZ64G341Ykm/eRHDx41nXPtPpSlFNo9dl43NylayZZbimE29VXHJ7A02kYGCzYr0tevh0k73CdzfVj4N7lChbfTCIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6631
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 14, 2021 at 03:00:16PM -0500, Jeremy Linton wrote:
Hi Jeremy,
> > > After this patch, we can get the lscpu output
> > > in Ampere Altra platform:
> > >     ---------------------------------------------
> > > 	Architecture:                    aarch64
> > > 	CPU op-mode(s):                  32-bit, 64-bit
> > > 	Byte Order:                      Little Endian
> > > 	CPU(s):                          160
> > > 	On-line CPU(s) list:             0-159
> > > 	Vendor ID:                       ARM
> > > 	Model name:                      Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
> 
> > 
> > Should be
> > 
> >      Model name:          Neoverse-N1
> >      BIOS Model name:     Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
> 
> Right, another example :
> 
> 
> Vendor ID:              ARM
>   BIOS Vendor ID:       Broadcom
>   Model name:           Cortex-A72
>     BIOS Model name:    BCM2711 (ARM Cortex-A72)
> 
> 
> Which is helpful when comparing with various other utilities, like gcc,
> which take cortex-a72 as -mtune parameters.
okay. thanks. I will change it in next version.

Thanks	     
Huang Shijie	     
