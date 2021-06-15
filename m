Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79312C48BDF
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F6161417
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOJPj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:15:39 -0400
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:5376
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230502AbhFOJPi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 15 Jun 2021 05:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV2g0jqHy+5xoO5pZXmULxtymLEEH6iTSwkcLWBXBrcdDL7DkHBoS4dP/QLc7PmtX3yHCd50cZqjuuk69c9btDDD+fQfuWuUSO8d0DMwaCW8VL5zXt87DrM4dT4rBEhDQI+586D90UR7KFRCCm04gWKe3aKl4DnHJLMj8XihjT/SUQmy9xtslZuNLdLRC3RtGq/Fj2nc/n38vf14QstQNqWCjzNz5fzXgtwMW2KcYpYUQF68rI/URpntnvmpohmuulUpWyizj86EgaT3cpP1oYPKhN1FDUOyE5et0JuabmrEQxI6CEBU7fE7faD156sbPy25O1upD17oUjYIsD3uWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaAfFwkUTdlixOK6qzj6hx9n1TYSlF0fMaDBXsrqO54=;
 b=MhxkMSLHaFGC96yamA4rGUFXJsJjt2roOgrHip68TKUdK0QB43WDRadb5gPygmBrpjOA4NDedmJOJpbcn6gTynLh5EG/OWEshElLkyHMLn69VrJK3O4uSO+08OWnZjyphtIwhZp/BtbzEcD6NqPpZ+kIvtkm+tddlgQqWUAsQNrNapd3PUlKn+WHP0Bf3a+Ux84NadlSsVI1TsyiJiyulLqY1aYpzxDrTlRIbPID+GqNEDN7cVZV6QM7l5BZWM74qZ49PuSQXAGMSzdV3vkVMF7Z8IPSzipi8j0++oe7SFJC8nHtMKOymcUMNUDe6sq18kfkU1aVzbgJEQpWL9uxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaAfFwkUTdlixOK6qzj6hx9n1TYSlF0fMaDBXsrqO54=;
 b=BLyUeBQcTc45YEiwSXU6fo2CZb4Y2cz3CCkKytqBFy0ndyxP2M5hlG5H5D4nSO/Sjsdd7KCya8oyDwoquCxzAEa++khLA/RLwElSlJhV2/oD33kYWkPtZ3NAXGLHaDqz3k/mIdUjLCIurEdEfB4qW38M1G5kxn8YxO6P0bFyi2w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO2PR01MB2103.prod.exchangelabs.com (2603:10b6:102:17::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Tue, 15 Jun 2021 09:13:31 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:13:31 +0000
Date:   Tue, 15 Jun 2021 17:13:23 +0800
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <YMhvM+GKYGpm8n4+@hsj-NUC11PAHi7>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
 <YMhw94JMDieTpqLA@hsj>
 <20210615084821.s2mcvmpaetb7fbjq@ws.net.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615084821.s2mcvmpaetb7fbjq@ws.net.home>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:903:98::14) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj-NUC11PAHi7 (180.167.209.74) by CY4PR20CA0004.namprd20.prod.outlook.com (2603:10b6:903:98::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 09:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1a774c-6495-4329-5606-08d92fddd7d8
X-MS-TrafficTypeDiagnostic: CO2PR01MB2103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR01MB2103935B8A4E5BDE46715274ED309@CO2PR01MB2103.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25wBhoEJMulpVKRuDUgSQtDdIJtjsaym9oNOzAr8bULiQv7ki9Mq0ML34muyEtUXJAgbkNMGgoIuauH9M9ankzY7YiPJ0nzvZ2XPQcV6sAkNf6C17B9SsCljJwO+iw3TnBm5Nwt6sOc3aEAYeWymSTJxCWVQX6j2J0R5Oh3LtbHvMQjv8ZvfVhaUci1qJ3qRjPAvKePlPBgDoaRtuJh4O78IanlwI7/Qhd+wpeYOqilrTKYmxb0hSJt7oQC/PR80QZlKq2z8UFPZqqPVkWQezf3TQNZe88OQ/t9Z/RgasZ+cBfawr9QIux+hkx1L0Hw5111TvPGHcqzgfVYo1D1EYjCsLlEamiapMdGKyJT8AY8Dw3bwQLgM/lzJP2KEPr4yUKrG3+nMpQ3yKAVTawJbDATYyBnRBfPtYPx+ra+RK6pAX+ADENyP0qfZj5vKfQ+okpHTJWkz1yjC94B8TdPZi9vBn4fQvTAqI2IMBpm0iiCwzBxZU1JB4+KxM3XXqRuuoeeMQFR57HcMrgDqbY4w0M36qTJ3BeBD5BfGQ5KCNGkGROmIlmQfBWNXWFX8QAk3vbT+F2Jqlj4YqR5x42ywyovI2X1gZ2p/GO2fcI8p5jTXKSr5L4o0Yi5AX+OMhvh+3bIUazR1TpZwEhjYbhh7yfIXTi4hkvXlc1SvxUWC1SqrUpA32ke0SotUtWsreqNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39840400004)(366004)(346002)(136003)(26005)(38350700002)(316002)(4326008)(2906002)(478600001)(9686003)(956004)(16526019)(86362001)(186003)(6916009)(8676002)(66946007)(55016002)(66476007)(66556008)(52116002)(38100700002)(5660300002)(33716001)(6496006)(6666004)(4744005)(8936002)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/y3vxnBhZgIxLZRuG/Ty8CGeaQQj90M/tpCHLDPuwiizTtIE0DOxD++eg8Mv?=
 =?us-ascii?Q?EBpwHvukrvHA37xY5IlQSunWzzE8SDRTxQFVjzpp/WLN1GO9dZ06PBX5R6mK?=
 =?us-ascii?Q?BshnQvYbMgL2wINMh2hbS/fVUq20Kowk74JhAYbQP3Rg46AkYoTAChLU2+CP?=
 =?us-ascii?Q?yxgBetspUdfpveAA3WglhEeLVOgpl36cQBKJpMxjqiQBSDg10AhFIvzXB5Un?=
 =?us-ascii?Q?9E3Nk9Y7pP/4hOH9XPaLqvk7zkb5xmyku0bRfy5e5jWOmd+DbZSuCP2zwAwV?=
 =?us-ascii?Q?mOKxeNBO/MaV2++v8l9+pBU1r24rTSoJczWFFzOlCXNcMB4GYRT333y63YhL?=
 =?us-ascii?Q?25GqdOnC49j8Hm6qrNDvcs3E70UgytFGOCFe47jQ9klEFEYJA/0wBsW8X9Jr?=
 =?us-ascii?Q?p1+43qox24GMqiu0xmktX4PTJ0ys11dDEWZTmd87kbDLAc1W0JXbZgqd0Of+?=
 =?us-ascii?Q?JgOURltfP54l90C/ye0DTaXPtMEiLmfskjit3aQDipkFEiR9crrADc52IUAf?=
 =?us-ascii?Q?hWYQ8RVwNb0VywGOfBiRb/LOmJ3ZsjG0ZmDvPqmwRgKMzH1LB4wPwKlJ/Njn?=
 =?us-ascii?Q?ihJzH51Ff1kiNZaPiCHtMD+Ofhmk2f6Lcd0p7eXjpVuJiP0YUxfsFLwU01pU?=
 =?us-ascii?Q?JeokujoSeZkBwvMk8plnFNhguPGVdv7vs9Ayl3eJag1IO2iaAMgWv2XDc2mU?=
 =?us-ascii?Q?kGD4D3sJJFKpvkGBH/rnW1cQqyH9FV4suqBbyQHfT1GWGgegzrQ7Wi3GqY7R?=
 =?us-ascii?Q?qYGe30Ey8vHOm+gwcY6Or1uO+qaunNy9D39f5BfYbosrKAHOVWQzKg2/6Xbn?=
 =?us-ascii?Q?zbBxX3LTwbsXr1c1eozEpDPnJzqk48S2GLYgfqKuRERUMEOSuzqKpmISl3N2?=
 =?us-ascii?Q?kbPs4dDWGQmBYZbWuP+Wvx3kUckd0hTmPlF2EXalIhRw6PWs2W83LV03W4EC?=
 =?us-ascii?Q?D95gDwM/KRv6HpxZraBtdFYHmyZKFYn853+LHd5jruPbcRlZOdfM/AOxrVEB?=
 =?us-ascii?Q?Q+HVBLaA+34B10JkplJO/mNI0fw4nPOSvPdd572gqrhApbSevXf5wfrFv1Qg?=
 =?us-ascii?Q?+fkjXTEdWOpddCjPqYi5WPOHb0FwU2u11Jyp5ONziFm8NtZ5F+KPRd5pJufC?=
 =?us-ascii?Q?OgDnk3vLSj/dt5J6MGxvYYMmJ/xlJps/DwxOG7FFISpYvRolCn8KrNebfUdK?=
 =?us-ascii?Q?d9lUBqNI7iILjdWTmccXINLa1/SL4c7nU+rfn8LVExEOl/VVJKf4zdZIUlOE?=
 =?us-ascii?Q?501zMwnoJB1BifhYN0T7UZha1K+hlPuaq3b2lyERY4QaRoHfUupghE7pv81X?=
 =?us-ascii?Q?H8WsEVEeMz7NkQYERqrgxNfn?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a774c-6495-4329-5606-08d92fddd7d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:13:30.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaCsLjKjtiQNbL/733wsF6rWq6pxKAIMs+Z42rxdO0v+eGahKOr6G5TRfy6OYrcn33nEeNLpP9VleRvEfftskwtdtP0dHN9QnF1E9el3CHRTfRrHCAq6GR+94JaPmz/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2103
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,
On Tue, Jun 15, 2021 at 10:48:21AM +0200, Karel Zak wrote:
> On Tue, Jun 15, 2021 at 09:20:55AM +0000, Huang Shijie wrote:
> > > > +	/* Get CPU family */
> > > > +	memset(buf, 0, sizeof(buf));
> > > > +	sprintf(buf, "%d", di.processor_family);
> > > > +	free(ct->family);
> > > > +	ct->family = xstrdup(buf);
> > > 
> > > is there any difference between "cpu family" from /proc/cpuinfo and
> > > this DMI field? Do we need a new field ct->bios_family or overwrite 
> > > the ct->family good enough? I don't know ;-)
> > > 
> > In the arm platform, it seems it does not show the "cpu family" info in lscpu.
> > And I did not find the "cpu family" in the /proc/cpuinfo, only find "cpu architecture: 8".
> > Unfortunately, the "cpu architecture :8 " is hardcode, it will be changed for armv9 in future.
> > 
> > In the DMI, the "cpu family" shows 0x101 which means "arm v8".
> 
> So, re-use ct->family for now. We can change it later.
Okay. I will re-use it in next version.

Thanks
Huang Shijie
