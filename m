Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC908EB64D7
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjFTJaU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjFTJaR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 05:30:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2124.outbound.protection.outlook.com [40.107.8.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61380118
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 02:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN0YWW5CFIvC+MfF+oddLvP1Wsk232iv0TVWrBcR7VR4wg78gfwD4rOCbWrTboVivXUFXuVkU7XVlhbt0JpegxSmJfDZLXJHlVhl+fKyQYVCMxhBUKjtstC0BsxH+w3w6RZfK9RxGc5oCXWc54o9jpcpJxEVtv9R8xz42G8L0Xh+LtZ4yF1TSlAcb1GFwSxFuEWYmX8ylJyun4//VzBcNJXIqpfeeCh2GeALegVfOotC/wJrA6PezrrvWAl1Bip/5clz4AaH0ef3E+AqzGKUEP7vRJPn2JX+79uQHJd6EF+TmOuumQmSicLwXKPXXqdqA5xnHmxB6KhEt0Z7PvxIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD0uKYcGrJHU16Mpmw2m2mz8961tYkXyEHbJb/mZfoA=;
 b=ItrFEgYLu4zqhOmFyGB6w1Du42vmuKURZsNXjjnOFdO1LF1w2cRNoQVa5C2n5IpEsTw/fbQx2V62rjSnxuRdLTwCKTCdxxnJ6SMN3z68NPrTV4adJGramGGMq6FYrq9aH1KYaQypUqxAf3CzEMlu0n8SwoZUMMrFV9ZsX4+R2ZssNca8pU5kz/lmCaohDklQLlKchfSHb5EEuh1jiHSgvEJza24HGHIP533VLB0wGusdX+J1VPwAy5EAOODq8aObZwnHAtkaalosBeBBe+Ihmg2khK36HBLpl5FwFVDmPj+hE/yTvfSBIkWiisLI33Njqmt9Ujd448fh/P8FtjE/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD0uKYcGrJHU16Mpmw2m2mz8961tYkXyEHbJb/mZfoA=;
 b=AJf+V+KD4TnasRyyg4lHnujT0vAetVmKNgjuIBNBkv/hqc11refdSKKg9aHGdZbhfF3lw72SL/LMW121RxtgY07tg5mVNNLywtwR7chB5nIoq+EE2SZK/i50lo5o1WPfawmWYP1vtpgSlp+9+2e/AKpHCKbwV8F+o7jyjLNgGCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 09:30:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:30:10 +0000
Message-ID: <e5407336-9330-01f6-1f40-f70c92a256ad@prevas.dk>
Date:   Tue, 20 Jun 2023 11:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Content-Language: en-US, da
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
 <20230620092628.klpqbr5qw2rdysqh@ws.net.home>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230620092628.klpqbr5qw2rdysqh@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0006.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: ab75e807-f752-4820-a4eb-08db7170f129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ6QYKSdSBkz4wG0yhlIrhY/9L7CQdyKMJFiQ9239dYVS8j6dHa2DapRgHs3Iwbs03f2wkk29ffetd8p3TwkZAk0BcPo7uv3a1+dCUrCrXIDY4OKjIxQO64eoUg8mZUDL+rkedcBNiLrhh3V/6biaoL1LW8n9Vh79Z7XYaOx+QGawwhqczJzWZbzTeEb/E5Hh+27vBCuzrPiG+4pctU99tJwNACDykznjnIdYWzZphrqEvu4y6gARbrMyNGVvlW+AgHu0VQz0zrwnL6bfvdmDv7nSb6DxDGDGltlMKdL+hDbTLwAqfbAdKAr4NS5FgVEikR6fEz+eJGPbSF6SaofszPgTx6Swlv8F2MypL90ULLdOt2CoRFG2zT71w0KpUp8OQQLGEDbR8QuEuH1/Or5eAjCCnmdguQaDS3b+3MwN5Vdz1zXZqfFhJRk7enNz9jSsrnc43FBzBMt2ApPZF15HTSfcJn2kE4qqpb6X5b3k5ltW6cMV7C4uJGA84E+SIEpgGqH6b22S+aIlr5jxcanfd07B7R1X+JEvLu0tc0Z5HBXLc15ydziPq6o0rehvYK1x2GQH0tGPiRM99qt81kke/bj+ALRMik5RF8WjlAKCJwYkb7oNlHm/omSJgdexmk1AQhOVx4wFWom26oT9XorNelU+zpBMxeSzGPKYACR37kRTJL35VjzrIKc/TGE/x8N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(451199021)(478600001)(4744005)(2906002)(6666004)(6486002)(38100700002)(316002)(38350700002)(52116002)(31696002)(83380400001)(31686004)(5660300002)(41300700001)(66946007)(44832011)(66476007)(66556008)(6916009)(36756003)(6506007)(26005)(86362001)(8976002)(8676002)(8936002)(2616005)(6512007)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFkrTS92bTRzRUM4YnZwL0tYQlFIWnRSeTZ5THU2RVhkVGhwaDh3VFN1N3JL?=
 =?utf-8?B?MnBpUEh5ZWd4Zk9VNlRQV3hKQ1hIUXdYRGQ5U3cyMWxmY3dhU0lHZ1JJeTAy?=
 =?utf-8?B?em1iNTN2ZUxGN01wWXFMWTVUSStzM1VtdjhUWTJyYzRmdWtaejNlbVFwdVNu?=
 =?utf-8?B?aGUxc2FOYitPTFVoV0RmbkZESXNUZjVCbW05VU14T09qYnVFWTUrMXpIckZS?=
 =?utf-8?B?WmRrd3RHN0VBL0o4L0FXVjJpSEFyUXdaSWZ3V0dUdjlVTjk2SVVzTXY2ZEJE?=
 =?utf-8?B?THFnUUxYdHRGYkJjMTdqeElGS0k0bjNGaVFoMWgwK3lTdEE2QmNrSkVuSzFu?=
 =?utf-8?B?VU9QVENmT3EwUlRjZ3ZUeTk0K0hMZkRFVmZaMUp6K0dyMlFmS0thd0EwS1hQ?=
 =?utf-8?B?aFJiL0djVE0yWTdwLzhnVFlXMlo2ZWtFejZ5OFBIc1FIbzRPQjZJWWR4Zklv?=
 =?utf-8?B?d1JNeXY1TjhOYlAyamJPdW4zZmpYREh2OGRsamljQUdUcCtjaG5vOXlYRGwx?=
 =?utf-8?B?elRXRGhJbzJGdUZNVlpHZCt5U0tycTRHZTROb3Fmc2RBWXZtVEtreUJIVWVQ?=
 =?utf-8?B?aFVCQWFXYkhHd1ZFQ05BWUUrTVQ4M1F5TmFpZkRHWGwxRVdIQ3BHeTYwV0JK?=
 =?utf-8?B?aUt5NEM0bVF1d1A0SEdnYWgzOVdyZDhNcnB2Z2duZ0kxdFBzbjJ2cXMrM1Yy?=
 =?utf-8?B?RFN2WHg3LzB6ZmltRWNiaWlWZVRrb0tjTnNNN1lBWGdDVGpSTTVpQlovNmlO?=
 =?utf-8?B?aVJOejR3MmpuWmRlU1R2QkR6WVlBRmpnaFMxUTlyTVg4VnFCTGo2TklwNjE0?=
 =?utf-8?B?WDdKaHRLNE94OTl6OFpDeVRKRStEMlZENm1aelRmOGtCWkRlOG5GZXJ2M21P?=
 =?utf-8?B?YTNiQVU5WWFmU1N6N0VKVjdSVXRrVFhuTTVrMHZnaWZNL0VYY3BOdFVCeU9n?=
 =?utf-8?B?Vi9xS1ZZNlpndUIyRmtjUXh4SzdCOFBQWE5XRGlnNjAvYXlZM1dleENadW9C?=
 =?utf-8?B?dHFvOUorQ0FoaXRIWmxKRlZxRU81cDBocWNTYWtNR0ZPWlRwUlVQTlZ5Q2hj?=
 =?utf-8?B?L3V4V3ZOU3VXamloNkJhcFU3bGJHVU53dnhsVWQ4Y2lwZy9Fbm5RZ0FBZVNt?=
 =?utf-8?B?RkJBbnBuQmhKS3VZUUdKc0xjN292K3RPYWNzTkt1YkhTUTBpdFVFNkt6S0Z4?=
 =?utf-8?B?bVVyVG9MMWZoVjM4a3dkdjZTQ3duc1NtWUFHU2wyNU5hbzdDcWtSMFJpVS9h?=
 =?utf-8?B?Qk1UeFNjRkx0UkRxK0djU3R5dXhyYnRJNk1TdnF0YW41clFtVG9QSGw5VTVF?=
 =?utf-8?B?UUtydERjZXFTb1JoYlJMei9OMGpJdGJWSkRrcjlxNGE2QURMeGJRZXJxUUFS?=
 =?utf-8?B?WENHTFpFZGVxdWFtRXNieklRRzdBelMvcmY1KythL2UzMmMrT2RHVUFFSHlH?=
 =?utf-8?B?d2kzeUZOWTJTTlFCcy96ZXNrR3lUUWQ1OVVid2VCc0N3Y09tTjZMbERIQ0RK?=
 =?utf-8?B?SjY1QUZYQkFrbE03UWtnaWdHWkVZNy8yaGVsQkxkcnBiTTlzbEVRaVBYdk0y?=
 =?utf-8?B?SjZFeW5kdkxENFRKSmNYWTZ2eUlkaE9pa2FoOS9XRVVhbnF3VmhIanliNjY5?=
 =?utf-8?B?THdrY0FwRmVpZlAwb2ErU2JPb0FUSVZURDM0TWp2eFZUcXcwOTlqS1ZwMjNy?=
 =?utf-8?B?a0pjZytubGlBNXlCRWVLTWxhR1BsK0I1U3RaQTZmUzFkclh0L2U0QUQ2MjRv?=
 =?utf-8?B?S3dsdnRWV2ZQTEdUMjVhbmhPcnBBbVZxNnI4L3M5eDhPRmhTODRqaGErZUZl?=
 =?utf-8?B?d0x0NEp2NDhnWHNCcVNnZFZ5ODI2UnJ5b0N0VUN0RHJ2ZVBaMzNoemFXSzR6?=
 =?utf-8?B?aVlBR0h2L29STGZQdjQ2dW1DdU1xOEk1UE9vTDZJbFRTczlpZmhWZk8rTGtw?=
 =?utf-8?B?dGM3V2NDQzB4WVdTS21vR0t0dVdoa09iMTE2bHZwbTlVaURVdklaaVZUSFJH?=
 =?utf-8?B?eEgwS25NcGU2bnRiTGJ2QzBHUEpPSDlpdXpWY01wUmFqSlhYcHpDWWlNS3lZ?=
 =?utf-8?B?TFZNMk5Tc1pFVU1jejhTcXNyc29TT3VEYmZaRng2SlcrZzNIcytTV2Zsd09t?=
 =?utf-8?B?c3dNUEc5M3BuQmZ4NEI3UStLd095b0RDUm0xUHJIemNlYTVLYWRhYmJDcTBN?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ab75e807-f752-4820-a4eb-08db7170f129
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:30:10.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYpLQeium+Wp1sDXFSHTreNoFo0O9JFuhHyMScBXfJqJjOuWOwRHqK9ncNt8oai/qiI4BVcACP9DcXtgqt26F9Wg6WSXSbvCN5wWrdMQM4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6270
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 20/06/2023 11.26, Karel Zak wrote:
> On Tue, Jun 13, 2023 at 12:14:28PM +0200, Rasmus Villemoes wrote:
>>  sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
>>  sys-utils/hwclock.c     | 35 +++++++++++++++++
>>  sys-utils/hwclock.h     |  5 +++
>>  3 files changed, 126 insertions(+)
> 
> The patch looks good. Can we also get something for sys-utils/hwclock.8.adoc
> (man page) and bash-completion/hwclock? ;-)

Absolutely. I just didn't want to spend too much time on docs if the
feature was deemed out-of-scope or if significant changes to e.g. the
option names or other API was required.

Can I send the docs as a separate follow-up patch, or should I send a v2
with all changes in one?

Thanks,
Rasmus

