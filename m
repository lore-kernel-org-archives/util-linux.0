Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B985FC4361B
	for <util-linux@archiver.kernel.org>; Wed, 16 Dec 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675362339F
	for <util-linux@archiver.kernel.org>; Wed, 16 Dec 2020 14:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLPOzn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:55:43 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:34874 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgLPOzm (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Dec 2020 09:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1608130474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JPSwUhCetSzWWL5KbZquDGFKfjswwGtFWva+4MyY+jE=;
        b=ilHeqPtBv9zTBXCHeNQIndQL/dQZz6ViVXE/33Br5KuvP90wC7va9VY/Bhl6Rfy6N/kB0D
        kVl5/xC+ATVN4vbFVuYTOTVnj+vZwx2i7GA4QjvXs1d+O3wam1mo6vnnXaLOUlyl6LXo2u
        LT+TPIJ0850y+6FWSXY/pB0ZiDn3T2U=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-2nDLBQVWNLuk-AEkaD6lqA-1; Wed, 16 Dec 2020 15:54:32 +0100
X-MC-Unique: 2nDLBQVWNLuk-AEkaD6lqA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9+W1rmMwgBa9j1dp8jjQ2ipxGyrOvFTCrnOi+MsT4FUrJduz8CS6UUbq4X7JpvdKB/acxdGkv4nHg3aRVYubPMUFcARijrAGAoLw7MRkKwFtKSYmg50bp0oKC6W9hy7V8usxyo6hup6KSnetKqF6dU8ZqtOJGbRj4147t+tyV6w8OnywEG8Br9IdSofRWDS8H2VwQOf/unOmLPpwzXSeUBi05bzzDPuylNK6CnW7tLeQDOeyqYh/vJeZpzBIoETTu4sw1Is82Hk3BtfRata6qLOZqsJHrQR4gRRuByOB/fZ0cKYkpKcIh0yqQPXqlm5ayhi2Ko/RrpReu26cgBVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPSwUhCetSzWWL5KbZquDGFKfjswwGtFWva+4MyY+jE=;
 b=NLTlX2/89L+7/myVvq1079QvHyhW8XsoWyEyE4LhrkvbR3LwbXz1jU2HEq9qOrJn0N1yJJsdV3SRds2RlejEZTgqIOBmDc6+g4DauDpGmpAnx9eUT1zZuv4KYHPgsvY17yFSUvwrVQ2iZvEZMB2tlkJYbVGUDbIiym1RGWXSOihDaWvRYKEaH8XaS5+oWms/BuawXYQ5KPsjFwqqW618l4p2iZhiw5EgRUGHaHDLGnJR4vNHwEGOEXTXXEm/2owK66Or7B4f8dHxFpzQ9GSsdlezJH/wKFlTRMqWWwexdNvqCxzLncg1r0rFua6DrolXJlszgTDiPwLs2T8jHC/ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20)
 by AM0PR04MB6451.eurprd04.prod.outlook.com (2603:10a6:208:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 14:54:31 +0000
Received: from AM9PR04MB7681.eurprd04.prod.outlook.com
 ([fe80::1826:7596:364e:e0d2]) by AM9PR04MB7681.eurprd04.prod.outlook.com
 ([fe80::1826:7596:364e:e0d2%6]) with mapi id 15.20.3654.026; Wed, 16 Dec 2020
 14:54:31 +0000
Message-ID: <aa7c757636594db8f122185293393e326652e53d.camel@suse.com>
Subject: [PATCH] ipcs: Avoid shmall overflows
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
To:     util-linux@vger.kernel.org
Cc:     ruediger.meier@ga-group.nl, sbrabec@suse.com
Date:   Wed, 16 Dec 2020 15:54:29 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.13.164.73]
X-ClientProxiedBy: AM4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::11) To AM9PR04MB7681.eurprd04.prod.outlook.com
 (2603:10a6:20b:286::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-nq5u (77.13.164.73) by AM4P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 14:54:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dfe7911-9fb4-49d5-4409-08d8a1d27ec9
X-MS-TrafficTypeDiagnostic: AM0PR04MB6451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6451E35DF30A374BD5B33793B1C50@AM0PR04MB6451.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ/0i9mtRFmbThT3FOJmtJL4bITqVqeIvrTDlfsOauT1a4Fp9/WEt9umZsHxE6p00ymunemuPsQqix5aNfijNlwXvzJIUaQLehSVWlauPT2h/c5kDxuvA1LQrXhuJFxPmUvH6drnNUkgysTdSw7A+B8E/LBOpKvyVYs3jENxks45XhlmlQ1dFq3tB3xhpy1es+L3dXmQ91JTeYw2IOdK/hoOc3kkRg/FuOcW0tS+gXnKE4HdBzSsHHWccsV5uJXalKdKqOcto7/zP9lTvhJN/RkWS5FQrF34oLtP/t7xa2q6LmBo4rcsxWtc9yMLaNPi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7681.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(346002)(136003)(366004)(8676002)(2616005)(66476007)(4326008)(86362001)(26005)(36756003)(956004)(316002)(5660300002)(6916009)(107886003)(2906002)(52116002)(8936002)(6486002)(478600001)(66946007)(186003)(83380400001)(6496006)(16526019)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M05yZUtpbUtQU2FBS0hsd1hVdEc3NkF2REpGb2tkU25VVXdXeEhsWVF3NndI?=
 =?utf-8?B?MVRvUTNDUGxMRENlTjBEKzZhbFRFRXNzbVNDc0IvWVFpdlZ6STVsSGVzeGt0?=
 =?utf-8?B?cVcxTkxrek5US0tRY1JuMS8ycklYdVQzMm9od1ZhdU9CT29MMjlFeWdJZ1J4?=
 =?utf-8?B?OHMvMTlDNkhwc1V3S1BIYVpUVzFZc2l6RjB2dDVOWVJNNUhhMGNqM2NOVnho?=
 =?utf-8?B?WEp3YUdZOHQzSU43ejNKcGFTYU5MM2ROOUdhWkFDVjc1djRIdG00bElaVm5O?=
 =?utf-8?B?enFqbllRWFZyZW9oa3ZsS2xzYXFyczRhd1RpZUxRazFNaGRtbElKdUQ3S2RI?=
 =?utf-8?B?WnNMdFlxYlRHcXNMbDFWdFJqQ05lMURoOXU0RkgvQjFrY1F4bEIvVC9ZVm12?=
 =?utf-8?B?clEvUHpVWTJvZEEybkNaU0RXdWR3OW1zTzZWNWp6YmxCMXJjeW1TYThIUi91?=
 =?utf-8?B?b2VBK2JLOGpRdjFBWVFpMm1TQXNrSEVzeWdyUnBlY2xsVWFiNmFhZW52c242?=
 =?utf-8?B?Z1VDUTM2bHkrRi9LeXJqSDdDWHg0Sm8zK09lMkQ0R1dWVGZwbnI5UzRvNFJn?=
 =?utf-8?B?V2xzWFg0RmptWUdJSk9wVnZnRDlrWTRrSWVubmx6dnFrK0FBVU1oY3FkbVR5?=
 =?utf-8?B?a3J4U203U1BGL3JpeXhXVktZRndFQzVjbGw3TS9VUDFvVWlvWFFMYVpOaHU3?=
 =?utf-8?B?M2xRdkw2YmFhblZkeWpBMnpGbDRSMjV3OHNydFN6UGtKZkJZZkUwcUhXN3Ri?=
 =?utf-8?B?SDdDVUhmR2c3Sm1pVjF2Zno2TDkrZHpwQW54Y09rL0gzWlYyWnFxTWtxV3Nl?=
 =?utf-8?B?YzZ5eWdhdzMvbVhvVG0rYnNrQWVKZlVONFhDUXBRR1hZV3NiSlUzR2hpdlBX?=
 =?utf-8?B?a2x1SldYdDRHelZaZEh5S3k2ck5MRElCYkJFV3YrcWVKSDh1UXBVd2NsTEVW?=
 =?utf-8?B?WTNvWnMvUjRpZHppNG5hS1V0QncrYTA4WGpmOVlHcGxNTHZqdnh6YnlaeHhN?=
 =?utf-8?B?WVhCamVaaTAwOUlQU3RRZTBWaEJ6cHBWckRrZVhDMnhzSllwNnBsVnVVMkUv?=
 =?utf-8?B?UGt5S3lFaG5RUHlkcVROMjdBT0dGVnNxQjZJOGhpTDFrVjlzenY5d045YzV3?=
 =?utf-8?B?UFpmblFJWDEyQ2FORysyWmJOa3JBcGs4TzU2WFRldWlHLzBGMkN1Mml4ZWxm?=
 =?utf-8?B?RDlOM2pleDBwUk4wVU80WUVEdXFGdGVMc3RybC9JdEcyZ2I5NE1NaVNteDVj?=
 =?utf-8?B?NjNTc2ttbGFDN3I2Zi9PdlN2QktGN2FlSnJXQjcvazBPaGdBKzhkbDY0Rk15?=
 =?utf-8?Q?h8QaYy9RM/tys=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7681.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 14:54:31.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe7911-9fb4-49d5-4409-08d8a1d27ec9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47OR9B7CT7vFPjcaRmPLfsaVNhyACOSxIsRMl9ReBEX27DnLiZuVA6fOY/FDgjK+YIHXO/RpsuUpoJHccXclUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6451
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Avoid computing the number of bytes in shmall, by only
computing the number of Kbytes. This improves some
overflows, e.g.

$ echo "4503599627370496" > /proc/sys/kernel/shmall
$ ipcs -l | grep 'max total shared memory'
Before:
max total shared memory (kbytes) = 18014398509481980
After:
max total shared memory (kbytes) = 18014398509481984

$ echo "99993599627370500" > /proc/sys/kernel/shmall
99993599627370500
$ ipcs -l | grep 'max total shared memory'
Before:
max total shared memory (kbytes) = 18014398509481980
After:
max total shared memory (kbytes) = 399974398509482000

Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 sys-utils/ipcs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index fc6fba4a6..544a3adcc 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -216,13 +216,9 @@ static void do_shm (char format, int unit)
                ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
unit,
                               _("max seg size"), lim.shmmax, "\n", 0);

-               tmp = (uint64_t) lim.shmall * pgsz;
-               /* overflow handling, at least we don't print
ridiculous small values */
-               if (lim.shmall != 0 && tmp / lim.shmall != pgsz) {
-                       tmp = UINT64_MAX - (UINT64_MAX % pgsz);
-               }
-               ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
unit,
-                              _("max total shared memory"), tmp, "\n",
0);
+               ipc_print_size(IPC_UNIT_DEFAULT,
+                              _("max total shared memory (kbytes)"),
(pgsz / 1024) *
+                              (uint64_t) lim.shmall, "\n", 0);
                ipc_print_size(unit == IPC_UNIT_DEFAULT ?
IPC_UNIT_BYTES : unit,
                               _("min seg size"), lim.shmmin, "\n", 0);
                return;
--
2.28.0

