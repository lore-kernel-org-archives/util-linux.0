Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3326CDB47E
	for <util-linux@archiver.kernel.org>; Wed, 18 Oct 2023 03:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJRD25 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Oct 2023 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRD24 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 17 Oct 2023 23:28:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE46F9
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 20:28:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJx8lb013029;
        Wed, 18 Oct 2023 03:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PnbXoywJi0oU0OSFGM24dW05KWRK8bvPBoCvBZLty60=;
 b=WIAakc9AlZs9QMyWORh5pdZ1qdBZPKOqruqw3/6gdHEs+1LpzzymyS4Hj9kWShhOn8vt
 ARShj40hZgJsNes0SpLMEy+3svQMnAj+4kn/fqUnesB9oZekncMFkmTXz9AjOGtDt5mS
 FzevCrCrwIwC9xHmtvmKDdB0sTMjUrIH0X7+ho/gKkj6FTOWRCi5IMT10gVPs1skyF1k
 Ey17/wNebmP/dBuw+6fkw2dQ3eW8t4wvIb4E9kPZSg69gNHbiM6qL9lL43SXdw0dLBFs
 AoG7Y3984cDyH8xxGxfQiyM0+e8KG4qiK9L5cKalTWFGwuMgVaUCBPG3NEobeXwmuVO0 Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jpkh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 03:28:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I1iMND028736;
        Wed, 18 Oct 2023 03:28:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy4ev9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 03:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJXzSgso4i8bece6QObHhuAnwCn1SWcFjYl9UTwbij4Ecu3BmgnR+wwcAjtNh2ZbKHvy+pcstCZbt7YcIJDENk3eMcEj+4y6bHco4DZrc9LS9eloy1g8rj9BMQRA4b0qkBmySCqhfgAbchYQw4mGMD1M2wopeBlQoEAsaVogoLeao2dc96E7Zs5KVMUtzZlxeuOrN9sHW2JsAnT6fAF93rYfCpBGO2QddChPfg50oObwEOqA+mXN+QWJFI+w43bJ1JbgLosHtd5bHNsgzDhan8kSuWoY22/YVbFeIFZJe+2qqdGAjIgxUIuZKm40hXiCgRhN45ZpNqIYuW8/617Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnbXoywJi0oU0OSFGM24dW05KWRK8bvPBoCvBZLty60=;
 b=NI3dgxAACuw5xXSe1lZbjKvA/vHPGxAPmVkQsnUwY0AMw+8DcYB253RN3LD8HaNfV8pBbgbs437CB/bj7uywJZQr/31CIuUYm+9LCIOEh+03v3JROozv7LbTdd6VKE59Cjk0sx7khOImJMIkjQ6+Ca3xYubZGirdqMsTL81I2qAciJ7t4/SqEAHZHV80c9lKBGosJ10cO0wTl69OqPig8fVx01SPTO+YVV7oeLuy8bpeN/Shfe1QwS4CaYWeFwi7xElL8yh01Q5zRWc9Y1eJz00uFqpnmI0Oj/i/3FavdKqrudoHMWhI7nrPTyoF2/TrruHYj8HHwejwzyZUMbqtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnbXoywJi0oU0OSFGM24dW05KWRK8bvPBoCvBZLty60=;
 b=CpR9ChU692HIELhzkaQJeDaA22/LtjRJPF28WBMXU/58F1g/duXZDMwSxkjWbpK4oFmyic3IPEhnkdfNvHIE3U1YWFZI2jUfGnL1kvmPHNpzroMP/+j1jH01W61xrUepFoa1jzCzcnFNLj1z6HHqgXhxQHcdO9tsUq6QUh6xaeo=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Wed, 18 Oct
 2023 03:28:18 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 03:28:17 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Dragan Simic <dsimic@manjaro.org>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
Thread-Topic: [PATCH] loopdev: fix losetup failure with a lost device file
Thread-Index: AQHZ/VbPEFBoQiGzrUWkwWlmGBwfyLBOomyAgAAfAYCAACoqzA==
Date:   Wed, 18 Oct 2023 03:28:17 +0000
Message-ID: <8608566E-F8DC-4202-9375-E245ADE5AAD1@oracle.com>
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
 <1457484d-5d28-47c2-b5b5-94f8b016023d@oracle.com>
 <d6455a28d6b82bb1a1cafb2af101c7c8@manjaro.org>
In-Reply-To: <d6455a28d6b82bb1a1cafb2af101c7c8@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4752:EE_|MN6PR10MB7443:EE_
x-ms-office365-filtering-correlation-id: 50aeb8f6-4f13-45bb-cbe8-08dbcf8a4523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LANX8BaYvZ/bw+W3V4vo6w85E+BQycw3Q6o0rsnGuHCEWTACEOgiO4/yvd9NVDWCT/Ze9bFdHUOjLi+SIbH31jEnxwFCsFXLVQg6ZdyLNO7ugrCy1SzvwesvZYgD0sZwqCkNe79RR2U46881rIdXhDNGiCsfjrtpT1gt0Cc1m9TgttS+xtTLCmsB9RqYVzACXSrsWVdfTgPfGmskslXC3kGMKI+6ft0BWoF/mA+SS2bhOtaHS/6kyuTTImcsazEiQGVVoXatWduwOruW3Q1nKUANH07tTVsWv+JunRGzmWjhDWkf/tLtaV2L19fYgAk5+k/DESD1NndOr0Fkan55Ybwq4gJ51QhOoVlCl0H6/bznLFlL5deT3vU+w45V56tastkkRogr/1lh78yXIwWJIkyfBjSSpv3dRj4yNwOrRjhI/TDLGQY12ceSrNCRLur/jBJQEeb+W5cu0siUHrPKoOCVmGLHKMrAvXP4ehhYkeG6pwwTVVKGyfbrEwxZBh3bZv/RAF1ueZrqMjBLYoBCxXVA2mSI3Vj0LHAJ434ZD4FuwBkeEHPT+cgHSvm++huPaNtGi+wnoGXHX11BagHbQNIrpiaHLgV9akChaxrW0gzA+9U8gWKtccYxcLTP0JkTiDfSMIhOTbOsZ+WkISV3kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(6506007)(38100700002)(71200400001)(6512007)(38070700005)(53546011)(33656002)(2616005)(122000001)(478600001)(316002)(66556008)(66476007)(8936002)(66446008)(76116006)(64756008)(6916009)(41300700001)(4326008)(66946007)(8676002)(6486002)(2906002)(86362001)(4001150100001)(5660300002)(44832011)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFNab0EzNkJnT3V1OVB3SDhzZzVHYzBzeGtXTXRhbDFod3hDYnZNUkpzcUo1?=
 =?utf-8?B?WnE2T2NnbkpmZU5yR0VFV01YcEdkbncrbGZveFRudzQ0Nmk4NnlId2gyNTZP?=
 =?utf-8?B?S2FtcDNBR3J3aVpucDNmM0RKSzIyY2lwSWZUc2lVOWprQTkwVWY1U01jMm9Z?=
 =?utf-8?B?VEEyb2lFNVZ4aExpTVlIbXZaeEJWejZtZk5uS1dPU1UvWVJmZmZlMy91dmtp?=
 =?utf-8?B?cXdQUUFhSVBEQ1FwT3NKN3grZnlJRFRhSkl6V1ROa0JGajgvN2lOL2N6TTVL?=
 =?utf-8?B?d0NSRU43RU1zdW52WVNjQXhMcUJDWm55Q3ZMQXlwalg4RU5FdENoMzJHTEFI?=
 =?utf-8?B?S2RxdXVib3Rxa1NnNGwvOVFZeE1hbFBDQUlBaXdMcVhaajZuNlZXZWJMZlpn?=
 =?utf-8?B?YXE1cExXdkFBY25Xd1pmOGlDMHFyV2hTVlROemZXTXEvYWQ4M1dLVElXZWpa?=
 =?utf-8?B?RHlHMGdQUi9VZ0h3T08ySWUvaGYwbGo2eVlJNWV1Rlp2S3JDUVp4MFZtRkdE?=
 =?utf-8?B?UnJ5NTJkZzNPdExYYUgveDZ6YmxSM213eWI4RHIraUt0NXB3U1g2cUdTVEFP?=
 =?utf-8?B?RFJUZ0ticVhpVFhXSVd6QVJsUmtQRkVsRFVLR1BvRU9YaFVCVHNCWFRZaWxU?=
 =?utf-8?B?UTEvVnlEMDNtajg2Q2NERVhySUhUOEp3VkFUcERIT2R6MnVDaCs1c1doczlN?=
 =?utf-8?B?OHFxaHBLVEZiU2lZb1BDbSs3RzlHd1ZCZjdSamxCN29IZXpYR3hLYXZIZWV2?=
 =?utf-8?B?WmNuY1pvV3FYNzU0SlJob0dHdFJYdmNWRW5NQUdMNVpHdGlpU0tsZXJhbkp5?=
 =?utf-8?B?VjFQd3A0UDgyMGxrOFpHbFdPK2txRENFZmVibEt6MHB0b2pES1IxTTgzLzhV?=
 =?utf-8?B?eW1WcXRHellxTWFYU2pvM1crWmV2Sm04S28rblhkZXB4d0RZMGNkaW56MHF5?=
 =?utf-8?B?TkQ5ZHArcHhMQ3NEWmpaNG5vWXhrTGZkUkNnQ2FuSUJKZlRLQWo0NG1uZnNx?=
 =?utf-8?B?c1F0L1FWanFnVzF1NmxGUkd5V1F5cTRZTmVjUHAzOVV3VFV0d3lHYWlSTVJr?=
 =?utf-8?B?d29MWmhFeXZWRWxMT29vcytZd1h6c2gwc2NsWUJWelNERmxDbHJqOUM1dDRM?=
 =?utf-8?B?MHRudXAxeUJydDIvelZmU1Y0d3ZUNmtZbGpYRFphTUpZT3lpSDBZMjRGMC9v?=
 =?utf-8?B?dmRkVlU0c29OV3lkY3diK3VZamJwaHRQT0hEdDFRQTFLY013WGNBWUhETjVo?=
 =?utf-8?B?bDg3UnhBeEFSWHR4VTdHTnZLVURucjhFelFydnBkb0lBTUtlUTZvTVR2SWJ5?=
 =?utf-8?B?bGRtMmJGaFJvdlRNOTNaSUt5WjRMMU1rRkVxTXVhZGFDTzg4Z2hrRmN6d1hF?=
 =?utf-8?B?MjFGaURZbGUzdDdRS0p3eFc2c3Jqbkt3UElDMXJTZFlXTEhoaVg5L0ZBaDNo?=
 =?utf-8?B?UmNMdS9HMDRTUFM5NVNKM1lFQlBUc25UczB2Z0xlL3ZRVjN2ZlFxTy9Ua3pS?=
 =?utf-8?B?OXpRR29OdGdHMTV0MVgzY3RpUUV3Y0pZWndmNHhhN1N6R08yNDZJWXFCRitk?=
 =?utf-8?B?OVg3SzYxWU9yaXZZWEhBQXhwNmxvMnFEMW5CdHQ2blhjeldpdG5WdE1JRE0z?=
 =?utf-8?B?ZUpqeDdYKzd3c2hqbEp6cHRIMEN6U0QyY3RJNDhUR1RISFcvcW5abzQ0TnpX?=
 =?utf-8?B?ZmthTitjQi9oWXJWSmU2dDVJN1hEMDZEM1hIdmtTaHZQbXBkNm9RQ2Era2xu?=
 =?utf-8?B?YXVNWmlzTUk4d25aZm5tYWYrU1JScWp6a0hhbDM3NWh4TDlxQTFGbDNsTVNH?=
 =?utf-8?B?Y3NJdmRrdWRmQ2R4SWpmZXc4cm53OTBERi9ZODdibm9uSkg2dmRDbXA5NGI5?=
 =?utf-8?B?cTZ6V3RZVVBjbU1FWUViWi90R3c3TzdsSmR2bGhSOFlXMStkeEo1WmhZNU1U?=
 =?utf-8?B?Q2hlWjZFQURReGVJcUYrWU5tNE1uWTRYd2JxbE1FRDFVZzFiYkJMM2xSS0Vy?=
 =?utf-8?B?WkRmK2loRGw4dWIrQ0lsa3lUb280TDdPUFZGMWdabXRHbkZZZy85MkpUSnkw?=
 =?utf-8?B?QjU2dUZ2UEFmQThldUg4MDhITHh4d21qc041elY0Vk40Ky9hWGw4RzNyalBN?=
 =?utf-8?B?VUpMUzZhNlU4NDVSUFBlQndaUkdLNUltWGZvTWNPZWkwc29zTVpET3EvOTVW?=
 =?utf-8?Q?exho5cZQxG0hrRn02CahVxnQq1ERnoMjeZDEWA5I/3FU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L7gxKwqTAmr/UeILU4Km8OM8pU9+xYXd0GeMAQsuBVA47Hb663nGH6NH6a6O/cZxdjQz9wEWMOLdRAHy3+uJvj3MFa0u5eekrwgQjlLFKHYiWRMVZj8lvbLsN/ntwa/lo1pRDHFkt7inOvpmmgEa8/YAg/RAtYfCuPOhcosLNcl5TAfehDE6HzLUqSIEhhUr94bPNV7vT1lSwDwDidwVjdInd4Llo+ONhVfqmPHDGazDaDx+WeCDaeZBCs3BnYpdd+veWQl+Im/QgGr7+R9WAxgN8u0F1bHnG9m16Uc+cgZrFfP2g8rAFis/JrPe5LezbJi7dnuVGchlkH63Ub4ohYQA5nilw/u9NGTPctD8Vu3i85NBFXleu8mLNzz4yQDsdMqisVL7YAlGrO9z5avuqDnryCEjovXP3yZq6k6q0SFpiiWpdQXA8vF41PXi/iu5A+Br+b2OYyisJkhYeGhkZhc0cr2GZq+txLNf6fx9WDqJXY/YCGacE5WIZ168pmojbrBm5mLAAVg7tBpEflIXq4PcBSFNQL+2ghNB1L1buwU2DpEua5zpqIiqLj0A3X0Apn4sSCLu+LwrobpXbsb7GqIawQ475qRaZHlDRMsnTAmdZW7EYTxMy1ZY8EAKFKdu/+aXnHQQVAl/Oo5EsQCQKA/ccKjGtsUG5Yis6B7BFGlLY3waCydXdqrLRIbeScN2lRVl05LuBG6m/g+65eISsw3m6xGahDbldzTl0Dv96vCnxIsXjXEx0vBzNILYhKPld7CoQwrLLUcpdQt9eKtgCTZ8p972YzqJHsHZWACc668=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aeb8f6-4f13-45bb-cbe8-08dbcf8a4523
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 03:28:17.5086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaFVUunHKeaGiuyUJobNs5jxMOu5VsacaPcSP5DHVRzLC49ResZN8/W8r40elly0QHVUONv75lY8jogVpdWQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180029
X-Proofpoint-GUID: 2Qipo86CWN1gJDK9lgKCHKta-d1iuZea
X-Proofpoint-ORIG-GUID: 2Qipo86CWN1gJDK9lgKCHKta-d1iuZea
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCA1OjU3IFBNLCBEcmFnYW4gU2ltaWMgPGRzaW1pY0Bt
YW5qYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiAyMDIzLTEwLTE4IDAxOjA2LCBqdW54aWFv
LmJpQG9yYWNsZS5jb20gd3JvdGU6DQo+PiBBbnlib2R5IGNhbiBoZWxwIHRha2UgYSBsb29rIGF0
IHRoaXMgcGF0Y2g/DQo+IA0KPiBBcyBhIG5vdGUsIEFGQUlLIGl0IHVzdWFsbHkgdGFrZXMgNyB0
byAxMCBkYXlzIGZvciB0aGUgc3VibWl0dGVkIHBhdGNoZXMgdG8gYmUgcmV2aWV3ZWQuDQogQWgs
IEkgc2VlLiBUaGFuayB5b3UuDQoNCj4gDQo+IA0KPj4+IE9uIDEwLzEyLzIzIDI6NTUgUE0sIEp1
bnhpYW8gQmkgd3JvdGU6DQo+Pj4gSWYgYSAvZGV2L2xvb3BYIGlzIGxvc3QgYmVjYXVzZSBzb21l
b25lIG1pZ2h0IGhhdmUgcmVtb3ZlZCBpdCBieSBtaXN0YWtlLA0KPj4+IGZ1dHVyZSBsb3NldHVw
IG9wZXJhdGlvbnMgb24gdGhhdCBsb29wIGRldmljZSB3aWxsIGZhaWwuDQo+Pj4gRm9yIGV4YW1w
bGVzLCBmb2xsb3dpbmcgY21kcyB3aWxsIGZhaWwgd2hlbiBsb29wIGRldmljZSBmaWxlIGlzIGxv
c3QuDQo+Pj4gLSAibG9zZXR1cCAtZCAkbG9vcF9kZXZpY2UiDQo+Pj4gLSAibG9zZXR1cCAtZiAk
ZmlsZSIgb3IgIm1vdW50ICRmaWxlICRkZXYiDQo+Pj4gVXNlcnMgY2FuIHJlc3VycmVjdCB0aGUg
bG9vcCBkZXZpY2UgYnkgcmVjcmVhdGluZyB0aGUgZGV2aWNlIHVzaW5nIG1rbm9kLA0KPj4+IGJ1
dCByZWd1bGFyIHVzZXJzIG1pZ2h0IG5vdCBiZSBhd2FyZS4gU2luY2UgL3N5c2ZzIHN0aWxsIGhh
dmUgdGhlIGxvb3ANCj4+PiBkZXZpY2UgaW50YWN0LCB0aGlzIGNvbW1pdCB3aWxsIGRldGVjdCB0
aGF0IGNhc2UgYnkgc2Nhbm5pbmcgc3lzZnMgYW5kDQo+Pj4gcmVjcmVhdGUgdGhlIGxvc3QgZGV2
aWNlIGZpbGUuDQo+Pj4gU2lnbmVkLW9mZi1ieTogSnVueGlhbyBCaSA8anVueGlhby5iaUBvcmFj
bGUuY29tPg0KPj4+IC0tLQ0KPj4+ICBsaWIvbG9vcGRldi5jICAgICAgIHwgMTAwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+Pj4gIHN5cy11dGlscy9sb3Nl
dHVwLmMgfCAgMTQgKysrLS0tLQ0KPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMo
KyksIDE3IGRlbGV0aW9ucygtKQ0KPj4+IGRpZmYgLS1naXQgYS9saWIvbG9vcGRldi5jIGIvbGli
L2xvb3BkZXYuYw0KPj4+IGluZGV4IGRhZTQ5OWYyNTZmYS4uNGZjNjE3ODMwYmFlIDEwMDY0NA0K
Pj4+IC0tLSBhL2xpYi9sb29wZGV2LmMNCj4+PiArKysgYi9saWIvbG9vcGRldi5jDQo+Pj4gQEAg
LTI3OSw2ICsyNzksODcgQEAgc3RhdGljIHN0cnVjdCBwYXRoX2N4dCAqbG9vcGN4dF9nZXRfc3lz
ZnMoc3RydWN0IGxvb3BkZXZfY3h0ICpsYykNCj4+PiAgICAgIHJldHVybiBsYy0+c3lzZnM7DQo+
Pj4gIH0NCj4+PiAgK3N0YXRpYyBpbnQgbG9vcGN4dF9nZXRfZGV2aWQoc3RydWN0IGxvb3BkZXZf
Y3h0ICpsYykNCj4+PiArew0KPj4+ICsgICAgaW50IGRldmlkID0gLTE7DQo+Pj4gKyAgICBjb25z
dCBjaGFyICpwLCAqZGV2ID0gbG9vcGN4dF9nZXRfZGV2aWNlKGxjKTsNCj4+PiArDQo+Pj4gKyAg
ICBpZiAoIWRldikNCj4+PiArICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiArDQo+Pj4gKyAg
ICBwID0gc3RycmNocihkZXYsICcvJyk7DQo+Pj4gKyAgICBpZiAoIXAgfHwgKHNzY2FuZihwLCAi
L2xvb3AlZCIsICZkZXZpZCkgIT0gMQ0KPj4+ICsgICAgICAgICAgICAgICAgJiYgc3NjYW5mKHAs
ICIvJWQiLCAmZGV2aWQpICE9IDEpKQ0KPj4+ICsgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+
ICsNCj4+PiArICAgIHJldHVybiBkZXZpZDsNCj4+PiArfQ0KPj4+ICsNCj4+PiArLyogc2NhbiBz
eXNmcyBlbnRyeSBmb3IgbG9vcCBkZXZpY2UuICovDQo+Pj4gK3N0YXRpYyBpbnQgbG9vcGN4dF9z
Y2FuX3N5c2ZzKHN0cnVjdCBsb29wZGV2X2N4dCAqbGMpDQo+Pj4gK3sNCj4+PiArICAgIHN0cnVj
dCBkaXJlbnQgKmQ7DQo+Pj4gKyAgICBESVIgKnN5c2Jsb2NrOw0KPj4+ICsgICAgaW50IG5yOw0K
Pj4+ICsgICAgY2hhciBuYW1lWzI1Nl07DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFsb29wY3h0X3N5
c2ZzX2F2YWlsYWJsZShsYykpDQo+Pj4gKyAgICAgICAgcmV0dXJuIDA7DQo+Pj4gKw0KPj4+ICsg
ICAgc3lzYmxvY2sgPSBvcGVuZGlyKF9QQVRIX1NZU19CTE9DSyk7DQo+Pj4gKyAgICBpZiAoIXN5
c2Jsb2NrKQ0KPj4+ICsgICAgICAgIHJldHVybiAwOw0KPj4+ICsNCj4+PiArICAgIG5yID0gbG9v
cGN4dF9nZXRfZGV2aWQobGMpOw0KPj4+ICsgICAgc3ByaW50ZihuYW1lLCAibG9vcCVkIiwgbnIp
Ow0KPj4+ICsNCj4+PiArICAgIHdoaWxlICgoZCA9IHJlYWRkaXIoc3lzYmxvY2spKSkgew0KPj4+
ICsgICAgICAgIGlmICghc3RyY21wKGQtPmRfbmFtZSwgbmFtZSkpDQo+Pj4gKyAgICAgICAgICAg
IHJldHVybiAxOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIHJldHVybiAwOw0KPj4+ICt9
DQo+Pj4gKw0KPj4+ICsvKg0KPj4+ICsgKiBsb3NldHVwIGNtZHMgY291bGQgZmFpbCBpZiAvZGV2
L2xvb3BYIGlzIHJlbW92ZWQgYnkgbWlzdGFrZS4NCj4+PiArICogVGhpcyBmdW5jdGlvbiB3aWxs
IHRyeSB0byBkZXRlY3Qgd2hldGhlciB0aGF0IGlzIGNhc2UsDQo+Pj4gKyAqIGlmIHNvLCBpdCB3
aWxsIHJlY3JlYXRlIHRoZSBkZXZpY2UgZmlsZSBhbmQgb3BlbiBpdC4NCj4+PiArICogUmV0dXJu
IGZkIGlmIHN1Y2NlZWQsIG90aGVyd2lzZSBuZWdhdGl2ZSBlcnJvciBjb2RlLg0KPj4+ICsgKi8N
Cj4+PiArc3RhdGljIGludCBsb29wY3h0X2ZpeF9sb3N0X2RldmljZV9maWxlKHN0cnVjdCBsb29w
ZGV2X2N4dCAqbGMpDQo+Pj4gK3sNCj4+PiArICAgIGNoYXIgcGF0aFtQQVRIX01BWF07DQo+Pj4g
KyAgICBpbnQgbnIsIHJldDsNCj4+PiArICAgIEZJTEUgKmZwOw0KPj4+ICsgICAgdW5zaWduZWQg
aW50IG1ham9yLCBtaW5vcjsNCj4+PiArDQo+Pj4gKyAgICBpZiAoIWxvb3BjeHRfc2Nhbl9zeXNm
cyhsYykpDQo+Pj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4+ICsNCj4+PiArICAgIG5yID0gbG9v
cGN4dF9nZXRfZGV2aWQobGMpOw0KPj4+ICsgICAgaWYgKG5yIDwgMCkNCj4+PiArICAgICAgICBy
ZXR1cm4gLTE7DQo+Pj4gKyAgICByZXQgPSBzbnByaW50ZihwYXRoLCBQQVRIX01BWCwgIiVzL2xv
b3AlZC9kZXYiLA0KPj4+ICsgICAgICAgICAgICBfUEFUSF9TWVNfQkxPQ0ssIG5yKTsNCj4+PiAr
ICAgIGlmIChyZXQgPD0gMCB8fCByZXQgPj0gUEFUSF9NQVgpDQo+Pj4gKyAgICAgICAgcmV0dXJu
IC0xOw0KPj4+ICsgICAgZnAgPSBmb3BlbihwYXRoLCAiciIpOw0KPj4+ICsgICAgaWYgKCFmcCkN
Cj4+PiArICAgICAgICByZXR1cm4gLTE7DQo+Pj4gKyAgICByZXQgPSBmc2NhbmYoZnAsICIlZDol
ZCIsICZtYWpvciwgJm1pbm9yKTsNCj4+PiArICAgIGZjbG9zZShmcCk7DQo+Pj4gKyAgICBpZiAo
cmV0ICE9IDIpDQo+Pj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4+ICsgICAgc3ByaW50ZihwYXRo
LCAiL2Rldi9sb29wJWQiLCBucik7DQo+Pj4gKyAgICAvKiBkZWZhdWx0IGxvb3AgZGV2aWNlIHBl
cm1pc3Npb24gaXMgImJydy1ydy0tLS0iICovDQo+Pj4gKyAgICB1bWFzaygwMDAzKTsNCj4+PiAr
ICAgIHJldCA9IG1rbm9kKHBhdGgsIFNfSUZCTEt8MDY2MCwgbWFrZWRldihtYWpvciwgbWlub3Ip
KTsNCj4+PiArICAgIGlmIChyZXQpDQo+Pj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4+ICsgICAg
cmV0dXJuIG9wZW4ocGF0aCwgbGMtPm1vZGUgfCBPX0NMT0VYRUMpOw0KPj4+ICt9DQo+Pj4gKw0K
Pj4+ICBzdGF0aWMgaW50IF9fbG9vcGN4dF9nZXRfZmQoc3RydWN0IGxvb3BkZXZfY3h0ICpsYywg
bW9kZV90IG1vZGUpDQo+Pj4gIHsNCj4+PiAgICAgIGludCBvbGQgPSAtMTsNCj4+PiBAQCAtMzAz
LDcgKzM4NCwxNyBAQCBzdGF0aWMgaW50IF9fbG9vcGN4dF9nZXRfZmQoc3RydWN0IGxvb3BkZXZf
Y3h0ICpsYywgbW9kZV90IG1vZGUpDQo+Pj4gICAgICAgICAgREJHKENYVCwgdWxfZGVidWdvYmoo
bGMsICJvcGVuICVzIFslc106ICVtIiwgbGMtPmRldmljZSwNCj4+PiAgICAgICAgICAgICAgICAg
IG1vZGUgPT0gT19SRE9OTFkgPyAicm8iIDoNCj4+PiAgICAgICAgICAgICAgICAgICAgICBtb2Rl
ID09IE9fUkRXUiA/ICJydyIgOiAiPz8iKSk7DQo+Pj4gLQ0KPj4+ICsgICAgICAgIC8qIGxvb3Ag
ZGV2aWNlIGZpbGUgbm90IGV4aXN0LiAqLw0KPj4+ICsgICAgICAgIGlmIChsYy0+ZmQgPCAwICYm
IGVycm5vID09IEVOT0VOVCkgew0KPj4+ICsgICAgICAgICAgICBsYy0+ZmQgPSBsb29wY3h0X2Zp
eF9sb3N0X2RldmljZV9maWxlKGxjKTsNCj4+PiArICAgICAgICAgICAgREJHKENYVCwgdWxfZGVi
dWdvYmoobGMsICJyZWNyZWF0ZSAlcyBmZCAlZCIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIGxjLT5kZXZpY2UsIGxjLT5mZCkpOw0KPj4+ICsgICAgICAgICAgICAvKiBsb29wIGZpbGUg
aXMgbm90IGxvc3QgYnV0IGRvZXNuJ3QgZXhpc3QsDQo+Pj4gKyAgICAgICAgICAgICAqIHJlc2V0
IGVycm5vIHRvIGhhdmUgdXNlciBrbm93Lg0KPj4+ICsgICAgICAgICAgICAgKi8NCj4+PiArICAg
ICAgICAgICAgaWYgKGxjLT5mZCA8IDApDQo+Pj4gKyAgICAgICAgICAgICAgICBlcnJubyA9IEVO
T0VOVDsNCj4+PiArICAgICAgICB9DQo+Pj4gICAgICAgICAgaWYgKGxjLT5mZCA8IDAgJiYgb2xk
ID49IDApIHsNCj4+PiAgICAgICAgICAgICAgLyogcmVzdG9yZSBvcmlnaW5hbCBvbiBlcnJvciAq
Lw0KPj4+ICAgICAgICAgICAgICBsYy0+ZmQgPSBvbGQ7DQo+Pj4gQEAgLTQxNiwxMyArNTA3LDYg
QEAgc3RhdGljIGludCBsb29waXRlcl9zZXRfZGV2aWNlKHN0cnVjdCBsb29wZGV2X2N4dCAqbGMs
IGNvbnN0IGNoYXIgKmRldmljZSkNCj4+PiAgICAgICAgICAhKGxjLT5pdGVyLmZsYWdzICYgTE9P
UElURVJfRkxfRlJFRSkpDQo+Pj4gICAgICAgICAgcmV0dXJuIDA7ICAgIC8qIGNhbGxlciBkb2Vz
IG5vdCBjYXJlIGFib3V0IGRldmljZSBzdGF0dXMgKi8NCj4+PiAgLSAgICBpZiAoIWlzX2xvb3Bk
ZXYobGMtPmRldmljZSkpIHsNCj4+PiAtICAgICAgICBEQkcoSVRFUiwgdWxfZGVidWdvYmooJmxj
LT5pdGVyLCAiJXMgZG9lcyBub3QgZXhpc3QiLCBsYy0+ZGV2aWNlKSk7DQo+Pj4gLSAgICAgICAg
cmV0dXJuIC1lcnJubzsNCj4+PiAtICAgIH0NCj4+PiAtDQo+Pj4gLSAgICBEQkcoSVRFUiwgdWxf
ZGVidWdvYmooJmxjLT5pdGVyLCAiJXMgZXhpc3QiLCBsYy0+ZGV2aWNlKSk7DQo+Pj4gLQ0KPj4+
ICAgICAgdXNlZCA9IGxvb3BjeHRfZ2V0X29mZnNldChsYywgTlVMTCkgPT0gMDsNCj4+PiAgICAg
ICAgaWYgKChsYy0+aXRlci5mbGFncyAmIExPT1BJVEVSX0ZMX1VTRUQpICYmIHVzZWQpDQo+Pj4g
ZGlmZiAtLWdpdCBhL3N5cy11dGlscy9sb3NldHVwLmMgYi9zeXMtdXRpbHMvbG9zZXR1cC5jDQo+
Pj4gaW5kZXggMGNhOTEwYWUzMzQ3Li5iNDVjYzJlZThmM2MgMTAwNjQ0DQo+Pj4gLS0tIGEvc3lz
LXV0aWxzL2xvc2V0dXAuYw0KPj4+ICsrKyBiL3N5cy11dGlscy9sb3NldHVwLmMNCj4+PiBAQCAt
NjUzLDcgKzY1Myw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2xvb3Aoc3RydWN0IGxvb3BkZXZfY3h0
ICpsYywNCj4+PiAgICAgICAgICB9DQo+Pj4gICAgICAgICAgICAvKiBlcnJvcnMgKi8NCj4+PiAt
ICAgICAgICBlcnJwcmUgPSBoYXNkZXYgJiYgbG9vcGN4dF9nZXRfZmQobGMpIDwgMCA/DQo+Pj4g
KyAgICAgICAgZXJycHJlID0gaGFzZGV2ICYmIGxjLT5mZCA8IDAgPw0KPj4+ICAgICAgICAgICAg
ICAgICAgIGxvb3BjeHRfZ2V0X2RldmljZShsYykgOiBmaWxlOw0KPj4+ICAgICAgICAgIHdhcm4o
XygiJXM6IGZhaWxlZCB0byBzZXQgdXAgbG9vcCBkZXZpY2UiKSwgZXJycHJlKTsNCj4+PiAgICAg
ICAgICBicmVhazsNCj4+PiBAQCAtNzQxLDggKzc0MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndikNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICAgICAgY2FzZSAn
Yyc6DQo+Pj4gICAgICAgICAgICAgIGFjdCA9IEFfU0VUX0NBUEFDSVRZOw0KPj4+IC0gICAgICAg
ICAgICBpZiAoIWlzX2xvb3BkZXYob3B0YXJnKSB8fA0KPj4+IC0gICAgICAgICAgICAgICAgbG9v
cGN4dF9zZXRfZGV2aWNlKCZsYywgb3B0YXJnKSkNCj4+PiArICAgICAgICAgICAgaWYgKGxvb3Bj
eHRfc2V0X2RldmljZSgmbGMsIG9wdGFyZykpDQo+Pj4gICAgICAgICAgICAgICAgICBlcnIoRVhJ
VF9GQUlMVVJFLCBfKCIlczogZmFpbGVkIHRvIHVzZSBkZXZpY2UiKSwNCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgb3B0YXJnKTsNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gQEAg
LTc1NCw4ICs3NTMsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+Pj4gICAg
ICAgICAgICAgIGJyZWFrOw0KPj4+ICAgICAgICAgIGNhc2UgJ2QnOg0KPj4+ICAgICAgICAgICAg
ICBhY3QgPSBBX0RFTEVURTsNCj4+PiAtICAgICAgICAgICAgaWYgKCFpc19sb29wZGV2KG9wdGFy
ZykgfHwNCj4+PiAtICAgICAgICAgICAgICAgIGxvb3BjeHRfc2V0X2RldmljZSgmbGMsIG9wdGFy
ZykpDQo+Pj4gKyAgICAgICAgICAgIGlmIChsb29wY3h0X3NldF9kZXZpY2UoJmxjLCBvcHRhcmcp
KQ0KPj4+ICAgICAgICAgICAgICAgICAgZXJyKEVYSVRfRkFJTFVSRSwgXygiJXM6IGZhaWxlZCB0
byB1c2UgZGV2aWNlIiksDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIG9wdGFyZyk7DQo+
Pj4gICAgICAgICAgICAgIGJyZWFrOw0KPj4+IEBAIC04ODMsOCArODgxLDcgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4+ICAgICAgICAgIGVsc2UNCj4+PiAgICAgICAgICAg
ICAgYWN0ID0gQV9TSE9XX09ORTsNCj4+PiAgLSAgICAgICAgaWYgKCFpc19sb29wZGV2KGFyZ3Zb
b3B0aW5kXSkgfHwNCj4+PiAtICAgICAgICAgICAgbG9vcGN4dF9zZXRfZGV2aWNlKCZsYywgYXJn
dltvcHRpbmRdKSkNCj4+PiArICAgICAgICBpZiAobG9vcGN4dF9zZXRfZGV2aWNlKCZsYywgYXJn
dltvcHRpbmRdKSkNCj4+PiAgICAgICAgICAgICAgZXJyKEVYSVRfRkFJTFVSRSwgXygiJXM6IGZh
aWxlZCB0byB1c2UgZGV2aWNlIiksDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgYXJndltvcHRp
bmRdKTsNCj4+PiAgICAgICAgICBvcHRpbmQrKzsNCj4+PiBAQCAtOTM1LDggKzkzMiw3IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+PiAgICAgIGNhc2UgQV9ERUxFVEU6DQo+
Pj4gICAgICAgICAgcmVzID0gZGVsZXRlX2xvb3AoJmxjKTsNCj4+PiAgICAgICAgICB3aGlsZSAo
b3B0aW5kIDwgYXJnYykgew0KPj4+IC0gICAgICAgICAgICBpZiAoIWlzX2xvb3BkZXYoYXJndltv
cHRpbmRdKSB8fA0KPj4+IC0gICAgICAgICAgICAgICAgbG9vcGN4dF9zZXRfZGV2aWNlKCZsYywg
YXJndltvcHRpbmRdKSkNCj4+PiArICAgICAgICAgICAgaWYgKGxvb3BjeHRfc2V0X2RldmljZSgm
bGMsIGFyZ3Zbb3B0aW5kXSkpDQo+Pj4gICAgICAgICAgICAgICAgICB3YXJuKF8oIiVzOiBmYWls
ZWQgdG8gdXNlIGRldmljZSIpLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBhcmd2W29w
dGluZF0pOw0KPj4+ICAgICAgICAgICAgICBvcHRpbmQrKzsNCg==
