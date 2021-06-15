Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDDC48BE5
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A00261417
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOJQw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:16:52 -0400
Received: from mail-dm6nam12on2093.outbound.protection.outlook.com ([40.107.243.93]:12384
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230454AbhFOJQw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 15 Jun 2021 05:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4v/58aRLuBvA6Ty2RPMlxAtHyWlswpEK8bqmVEWW120+BTewScE8MYBeAMoE7WD15iImfggz5INbzx5Y+nY/7H5FFqpIOd070/+nyI9SZ3g8fmF95u0wgoK31AcosWvoE0HrMVZkRCZy3H9+ukNXrw0C2aWxWPcWT81KfHq7KjrBaAtsujI+yiVxoYLwatbg3VDe961oVA8sIhi3DKJ5ovllkCXBLTj18MWfbO/V50dREq56vUrIobEpK+Fe7cZT0b/e+L1HEWfwtyyqzU58vcQwqaZvEZ+stiRGd7e2EBopqaFX1NSiYX/n73l7GiO40AMNMrxnVhlja9N7ojtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNrYA5G3v/1zWKrrujHFJsjENxQQHNsumoJcrOzualA=;
 b=MPEIw6FKx3lbtKig4h/hXZF+qthoJWzfbDoFXwS7Uf3ejIc/pqqINSUgP0wWnmSFNGVh1+4DeuwB4Or+OtqLLzfpBsj0xWgMmf3jQTI8iwQj5DagaymzO1GBwRt83prlsj8MxrnvN3mCJdw9+m2IPUayFjjSWxh6pWKA/6kA5bQrx3u/CDfB9uCa/WcCv5Lrr8Uu7vfUBmy5J9KQN39gbKMgYtR1kn4/wMQkXwZgGK07Uuq+gNlRpbGjEgRXfeOpzfypziMVShHhJ58GhmLWqVzx8CnwOWqHVq9WfFwA9GGOx+o6bIghb/wtCqECVJScgRm6tYYrjr0pAmyKjWfo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNrYA5G3v/1zWKrrujHFJsjENxQQHNsumoJcrOzualA=;
 b=QAbQUAwE1o/1/8DZqlo4mW+EBrde/0Jqw9PQHR/uMW3sohVVz+R/3CRASQUtTGRZOv8UoO78an37PHbHc95RWjM6xS/TtOGDVpWvTozNlBwh4Z0aYBcU5usufiSwMc2Qpl++pkDXRPYNBqmrufahK3KeVXaAdtJrhLJECBS7hCc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO2PR01MB2103.prod.exchangelabs.com (2603:10b6:102:17::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Tue, 15 Jun 2021 09:14:46 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:14:46 +0000
Date:   Tue, 15 Jun 2021 17:14:38 +0800
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <YMhvfp7oY+gVtHtL@hsj-NUC11PAHi7>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
 <YMhw94JMDieTpqLA@hsj>
 <20210615084821.s2mcvmpaetb7fbjq@ws.net.home>
 <20210615091314.3hrkztuvnqyff3ll@ws.net.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091314.3hrkztuvnqyff3ll@ws.net.home>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:903:18::13) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj-NUC11PAHi7 (180.167.209.74) by CY4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:903:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 09:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c9155c5-3e27-4326-84ac-08d92fde04d8
X-MS-TrafficTypeDiagnostic: CO2PR01MB2103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR01MB210373ACB2BFED13DB9562F9ED309@CO2PR01MB2103.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEDIBDlCSOQWFjVJL6JyCa/KuA2o5J/9o3LCzXmRMCoI/4u/Xtahy3EnVrAbD/qhqvFfbkYExVsI+GGJme2CTFOeGzMb2NM1USTuqZ1pMJsVUwkAOkkC3Hp65Z6XTeD4Ube4jgsG3XHxLsjGw3vO05vny3vQ2eLwdgOPhfczrv8Vl2aPnq1e44C8lkhz86CMTmR+Eyt0V9N6vJygXjzXUXzNx3MBkFm2uHZrbxvWG9gIK2gcI9QLWsKAknyqXTOuPTFZIUCZPGEQ53fOtWIkx/g4mYIHONI/yzvxbvVUsIKMfnSzmtwZzggFAhMTBW9jB4SXG5UjpC/WZkCDSuLtobfC7qDxLzJP6ZFh4RGx6kUsYYb20RGxadCrmKJAsvtF1WOwSQR7+BSN5l7Lx2rrq5CO6cv2jd7QKV4WcI7G+v0fkvrcneNh7H3c+iO8ftAn5/Eys+9V399pNGBez5k9lDbfgq98G66TWvtFWQtOGP4fmo3FJhIJNI8urnRsJ8wmxuSWUhjbZ19gSr1p69AmYWAt6WNbNknXjw+RFsQrtVU2Z91ChaJorIDMZgPIxmU8X2jTMIz+QVtLnfig8bOlDyAu2XWpoH0TMzkT4VNrxA4jpa2kqPs9cO8dCsPVmcCvAP+h+0GpCy4KyFtEC7vSWO9xTJJjai7c9HNkWfZExLbZtbVqxXmZLmpUN14ooqrnGoC4KhSf+KUcCwJdpMKOGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39840400004)(366004)(346002)(136003)(26005)(38350700002)(316002)(4326008)(2906002)(478600001)(9686003)(956004)(16526019)(86362001)(186003)(6916009)(8676002)(66946007)(55016002)(66476007)(66556008)(52116002)(38100700002)(5660300002)(33716001)(6496006)(6666004)(8936002)(15583001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmumMAcZAOQDQVZpinzva+9FKIM4aGqZe2S+sPGG1Fp+Hq/rKhHZP76ntiOP?=
 =?us-ascii?Q?5yPLPokTOvyE5OFIVg0Ez/Dl/Gs1d+IzI4IfEkWMwBXKYXR93oD0VHVB5kNL?=
 =?us-ascii?Q?lSPEVf43v9V5hd6UPxvUqCpWTMPki5KlfADHVC0wm+Wx3eMa3JVJ/PN529/c?=
 =?us-ascii?Q?3FqetsXSziFXXhbSRq6e/GMlUe4h3rGrdXy9mBdK9HpNd7nEIrLY6APeOedt?=
 =?us-ascii?Q?gk37+/rQ66SCpaI/UBAFi0c/6kwKQyBU62G3s5abT4bfDWtQv0zZ/8FECrDu?=
 =?us-ascii?Q?u/kEPsWrzlUtyVUo8kfM+mCTCIzmKMNzxTQ5rywFGBPN7DITcCDWv68yW4u0?=
 =?us-ascii?Q?CTe0XutpI3hTmxyocpfupqkRBQOEbzBbJcAZnI1pmV7nq8waeoonFNvDnVn6?=
 =?us-ascii?Q?NPKcceFrgvikP6Nfj38oP1FSSmsiOOCC/9BcBvN6qOq8yJnciPP8CKKy6Rdd?=
 =?us-ascii?Q?wtKTxbh7w3W8cas1H0SWD6XI+jkcCLkr/7+B28dBWAUCsey+14bMSWsdYxDf?=
 =?us-ascii?Q?PPjaDzedVRvWLfhF+G2vwshchaegh4gSJlWZRBVPnlFK09j95pFkxZSE0nir?=
 =?us-ascii?Q?HHBj4v6FoXpg4oaQJNOML81bobiEAlhilQlgJeQycvTsWEa/YOMfq06xgSId?=
 =?us-ascii?Q?wC/elpRYEfqCZTZN5MTLk+AAy7poF8WJTh+/uB0H8QqfZAzPWG3delBkU/cY?=
 =?us-ascii?Q?t6obnKDhXXrda84JgL6J/j03ixp0lXWRitU5b+71n0meoddjQxXM+HGu6ngU?=
 =?us-ascii?Q?q1htpU+A3JfJBFNFSx2bNiwvUNxKkKMWoP+ecjj2XrffWX+rDeTwsitCk+U3?=
 =?us-ascii?Q?Z2ub4/Zhh4JnsKTb0qR0ssrYmOay8gHw8XVKbtf0beNFxJs8yyftaZI3qo+N?=
 =?us-ascii?Q?t6VCtPG9ERrgXvyNbIxfa7f5SUsVYCchz34jKRYzbQt3u6ZsDa5dvOdji+nB?=
 =?us-ascii?Q?jw1XsjZ/UX2td5HMfGUjSPhTeybfXdaf3c5zwoHHsqrwYTY/13U/+XXaYt2Y?=
 =?us-ascii?Q?aZKQZU3miZW5ZACOaI+2WiH+AyObMQWRA16T8VplN+u++9ubQTXvb4UOBZ+s?=
 =?us-ascii?Q?3yX3gh10pSzxE5i1LMJN9Gl/maEzBg0TIZlgTelp3peFS+JPqHF6F1n3r2tY?=
 =?us-ascii?Q?HDYoi+NT2q/Z655cOry9L56L5D0V9F/EAiZisZLJHVXYRkRsIQjXGCTnOs21?=
 =?us-ascii?Q?JTbRkRRgbXB30JjODmicDbDIeX7LBk7T7kmYeaKwPm2ZOMxoiMvI5WfBeca2?=
 =?us-ascii?Q?qzJxWCfKA41dWDmFTYbnR+P03SBuT1K+Mye4DUinmI5n+yEfJZafTltP0gKU?=
 =?us-ascii?Q?Cb/cfCDKW1K4DNzFILdtr0MQ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9155c5-3e27-4326-84ac-08d92fde04d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:14:46.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vLYm4RvVuoUmwMFEZsMLQQ5vgSryiZ51aRRVTcMCKOsj1Ii15vj4nfHVrbPPL/qdbzLQY/QvTFWZaiuWvHTFOPUaGIPERZO2SOHjuR7vEjmP6m4/sAYZ0SQ+9KYIOnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2103
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 15, 2021 at 11:13:14AM +0200, Karel Zak wrote:
> On Tue, Jun 15, 2021 at 10:48:25AM +0200, Karel Zak wrote:
> > On Tue, Jun 15, 2021 at 09:20:55AM +0000, Huang Shijie wrote:
> > > > > +	/* Get CPU family */
> > > > > +	memset(buf, 0, sizeof(buf));
> > > > > +	sprintf(buf, "%d", di.processor_family);
> > > > > +	free(ct->family);
> > > > > +	ct->family = xstrdup(buf);
> > > > 
> > > > is there any difference between "cpu family" from /proc/cpuinfo and
> > > > this DMI field? Do we need a new field ct->bios_family or overwrite 
> > > > the ct->family good enough? I don't know ;-)
> > > > 
> > > In the arm platform, it seems it does not show the "cpu family" info in lscpu.
> > > And I did not find the "cpu family" in the /proc/cpuinfo, only find "cpu architecture: 8".
> > > Unfortunately, the "cpu architecture :8 " is hardcode, it will be changed for armv9 in future.
> > > 
> > > In the DMI, the "cpu family" shows 0x101 which means "arm v8".
> > 
> > So, re-use ct->family for now. We can change it later.
> 
> Ah, I see you already send patch with "BIOS CPU Family". OK, let's use
> it and ignore my previous email ;-)
:)
It seems there is no need to send out a new version..

Thanks
Huang Shije
> 
