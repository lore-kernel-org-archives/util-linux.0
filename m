Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E3C2B9F4
	for <util-linux@archiver.kernel.org>; Fri, 25 Jun 2021 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A9761409
	for <util-linux@archiver.kernel.org>; Fri, 25 Jun 2021 09:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFYJfq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:35:46 -0400
Received: from mail-mw2nam10on2127.outbound.protection.outlook.com ([40.107.94.127]:32997
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231447AbhFYJfm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 25 Jun 2021 05:35:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdabx9ksOWBZRLZUonturcHt3mAstDuhUrNMJ5XIhZ6soDFb2xKQfQ6oqnBqMsXdXSnAVs7rVEEL9YlLzF7FhWtrhUnU+znin9AfPSVHj9OAJbBRmvFgokf9d7DfX7w58cbF2W/H/1W+vRoc8bY+E/QUqxr/5kpuaQ/qUfOdj8k2bpeHnGInNO7a9AjgRUSt6mg6s/3tSbVtcVs4VJlkR5vBdZ1quooHs4nzEYVdveWSWGonFCeK1tMByjnXDGKO9flmkPyFRHVRhT/cXzGljyAV75mEdJe7mIdGqvPoUk/viIOM54g6I11oXEEaqtyUv6brVQAzoJGsSKTSuafr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I5rXsCIfYrMqmZ30O6pJm677AVzjgSOwMR4HKin6cs=;
 b=C1tAwRuF9pzTQFowlMxJaUOEiK76wxH/cUKn3Zyf2Y3IgdIwxjYLf1WZYOOXQR5Ry2EqKswd0rvJazRmP4Cd4mKt3YC3HRS1LmKEcYFmJ+ejTE3HoeNwJdKWGjoL9aueaeCWTuq+81U3K/h1R3AcrK8pCEjvdzBXobgAZltj2ngar6uFe+If1SS2qvBcFljDwkg5lVVs2ZJBhre48uUOy96DPqqdkq8eCO93XLnDXvTzWZ027OvQxq8FC/nCfO1iStoribGeLrwLk1OI3LV5y33SamssuUoS9XTh4d6JEM6puVE83xnI6+wM1/fyZoqSpg0SfsGECzxtC5I1Ve6QiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I5rXsCIfYrMqmZ30O6pJm677AVzjgSOwMR4HKin6cs=;
 b=Jv2oQQLz1OmWFWYsX4muNbxaTZovL6Htx535i+dY2+KzyQ5/+AXrpP8RAmIXgfYKwry8PZf95GkfR60bgDvygSRnzbhKzLgjkH1bNmXThwvUP872foCnAHV+I/AqU3BGnZnKJAoC7vzkTmj/MrNpwnXMxgcxgQCRVSHw1YrSc9A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW4PR01MB6132.prod.exchangelabs.com (2603:10b6:303:7f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Fri, 25 Jun 2021 09:33:20 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b%6]) with mapi id 15.20.4242.027; Fri, 25 Jun 2021
 09:33:20 +0000
Date:   Fri, 25 Jun 2021 17:33:11 +0800
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com
Subject: Re: [RFC PATCH] lscpu: get more infomation when using
 "/sys/firmware/dmi/entries/4-0/raw"
Message-ID: <YNWi14N4DToDMlUa@hsj-NUC11PAHi7>
References: <20210621110900.41043-1-shijie@os.amperecomputing.com>
 <20210625092301.6zlyufiwjkta7rf7@ws.net.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625092301.6zlyufiwjkta7rf7@ws.net.home>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: DM6PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::29) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj-NUC11PAHi7 (180.167.209.74) by DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 09:33:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d18b47d-998a-4c13-8a7a-08d937bc4474
X-MS-TrafficTypeDiagnostic: MW4PR01MB6132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB61321CDD7CF48057054D5C5DED069@MW4PR01MB6132.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMftk6l5Xy9yZL7PhqGBV+faKSzGHeCaX8pom9jRJHRppVJ4FRsqjHzypuN+N0IFG9qj+J4TquzIE29WGLsJeOrNsOAM5/7DAYP+lLx10UF6IVOqMDGJlpvAGWFyB0SuuOcRhjazq0FZjmE1RR+hFQrzCXvn+6TEzkPUf/j+Yg+iNq3MYVGaA08iJVyHnOXxm/CihD2K2kSB3O9lBO3GqKchedEWI4MSYw1vpnUfNDW8b+18BgEv3lX2MJ5hTK+UbHwuPygGT8ZZqbW2JuNWSsfRN+1VdNRFfPXkFi19LpzkZbELlADPfnsrkWcn20cbaxWUk+bYLKQB6iYWinzDdKAZeRA5FTOTB4oYoT1ZvuT5rxU7BByXALcX7KgQ+J0d9FS3XMKFkFSrBl5mGlp5zrXLGuMscANZkxtWjEb3EhvXmy7Dm//pqkWtreg+S0fEo3fBWyrbmrUeCPP9BFe/OXkZqAYtGdO6ZnhDp7rMVDTiXaTXjPTYV1zITGIcQHBxt7mDI6N0KL8I9AO9wE/VaPy/4ZfM5UbJFbbQ69XDUhUFsNgYvRbCnyImTi1i7+HlOn4Bd5pJEIq3TQQMtut34tXjRdW7TRFGHBBdytnF+fLAw7xnWCDv68xE0bs8DqCsa0tmExpU8CnDqOXPb21zNMqB2CQcLCdrVNxGK81CmM4PFpdZCLXM2IJ0fBxaNqspaFq5NdWkHQ1qirm0ICSBnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(136003)(366004)(346002)(316002)(9686003)(66476007)(66556008)(8676002)(66946007)(55016002)(26005)(107886003)(4326008)(4744005)(6496006)(8936002)(52116002)(6916009)(16526019)(186003)(33716001)(6666004)(2906002)(478600001)(5660300002)(956004)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?boZI9yUYJwEAiSS6GWb1rWtPq4EiRYHdzQDi6F51M3GCKqupJyWT6PpMx6uI?=
 =?us-ascii?Q?K+k6yuF7R6AJehZWPq+lKgkrGRcHH9UbJ2w/qqsfjk885BBheyo0FFgjVFDv?=
 =?us-ascii?Q?zohQSq9A2C9MM75j6amx/9Vu2HrGiO4VQkEc9UPlAbULTbiw6HMQ5UGzxQ4h?=
 =?us-ascii?Q?+32rPaEZQxdKb6Aohg49yUnGu6MIhvAcVEjFqdC0cxhJUzKyQlXEQqoMObA5?=
 =?us-ascii?Q?0FRCHWZAXMRvqFy3veizJOHeaX7+WsO6xNhM7jznjXTG3x43nOlzwg5I+xTe?=
 =?us-ascii?Q?fNCosCc0CXJeXCNwCyhcd4CQ1JErRQEcOYHkiSx0E1B+Z8pCi1RiME3DU4PM?=
 =?us-ascii?Q?ylJ9T4yJg4vCfMDhQl9WvfQhq2mgspUj5BKxrT0e/yH6Gb7nUBwSnGsXUsvj?=
 =?us-ascii?Q?Ez2SuWq8EJK2TqcI7vR2QXvdue3gZh/uMO31jyQ4gV+KFSynHbgGYbiVZmws?=
 =?us-ascii?Q?lQ5mJpFrUzL7F2BzxJvyIm2kj5dvj/OmKj5kvI8VmLAsfspTnzd/h7ONMcOQ?=
 =?us-ascii?Q?Cq9SrWlODzqJrKGJqaQp45Xnn/AsWLZDcH1fYt1DUyCGGLvlnfq3PWmpZ/Gz?=
 =?us-ascii?Q?yZ4h0tPOccbSaaXyUY+eaDlVV7jDqAU1O05ntVvXVHqrx2mpQnBKXcOzVKXV?=
 =?us-ascii?Q?LrGE2+76HcCvUiW6/r8BDqXJkS0DP0C8pL58Ww41qV+EZdPAa5qMhFiXTRf/?=
 =?us-ascii?Q?yFOCdMQ6wqLqB6tWu5crczLnXiBut3KLSIMnOsExiu0q41fNYfLQGBh5mN34?=
 =?us-ascii?Q?dIIQpj7Rnjuxf+Lv+49TBzdNGyPZO/IQzIEnN/fmbfQ1evCuUakKar/J16Op?=
 =?us-ascii?Q?QlJZMcs6qcBoPJ9H9wYN/mnvXEXxJOOmKZ/YM5fuOL4NM6wwmB5TWg4A5tvf?=
 =?us-ascii?Q?1od7m3b1TYP6d8LBBtW1mT/ZI8eIWdKBYYG6tZq3UdyPhYr+II+0av9KS4iT?=
 =?us-ascii?Q?G7BrA5Sa3ksOKQqKZp2InBPZ7ZOstC1J0l/0zSbf2TXApJMDa4UF6DY/jcjv?=
 =?us-ascii?Q?TiZ6cz8KYlywyIcirOsmacUENieGkHHB+nIaI1s3zTrwON4axyvVeXU7Rz28?=
 =?us-ascii?Q?6207OJJ2ApHuP2tFpAEdwvpIrLLcCBZEjDuLfwSnqzG3ekaYnVzf5YIwJqrJ?=
 =?us-ascii?Q?Sbx8kgZWzB9AhgzlDCu/9Do0g6TK6itY9RcYA8QvPmAHDd/Zyx3KC5Csze/M?=
 =?us-ascii?Q?MypppBpgsu38WThVwcM/yagUNsMLfdqcuEUsdKDzhikA+AIF1T9R495Jv/WS?=
 =?us-ascii?Q?3o+j0EXy+52ZsRW0whBXb+/6v9QxCXIDGtPOFRMWi2n9aaGdxpMZVuEwCpxi?=
 =?us-ascii?Q?m+0KCyOuGJ8OpNSzOpSJdQy+?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d18b47d-998a-4c13-8a7a-08d937bc4474
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 09:33:19.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chAqLtuZjKuXZ/y6r1KiUyn9COsUff0IZi3sgYTe6AIZSB/u8jTxAGi9w0lnKUrlUOsnqM0o9OtQ7YRgfNDzzl2br+6a8W4BAw7NvRFrartxBHqoiNni9s1QeYCkOIub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6132
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,
On Fri, Jun 25, 2021 at 11:23:01AM +0200, Karel Zak wrote:
> 
> I've lost in your patches :-) 
> 
> Your previous patch "[PATCH] lscpu: remove the old code" removes all
> arm_smbios_decode() as it's unnecessary. This next patch tries to
> extend arm_smbios_decode().
I thought you do not like the patch "[PATCH] lscpu: remove the old code".
So I sent the second patch... 

It is okay that any patch of the two is merged. :)

Thanks
Huang Shijie
