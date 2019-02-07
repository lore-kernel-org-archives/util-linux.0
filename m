Return-Path: <SRS0=YqZj=QO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D192CC282C2
	for <util-linux@archiver.kernel.org>; Thu,  7 Feb 2019 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768D920863
	for <util-linux@archiver.kernel.org>; Thu,  7 Feb 2019 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="QliFbJ2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfBGQNN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:13:13 -0500
Received: from mail-eopbgr820123.outbound.protection.outlook.com ([40.107.82.123]:29083
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfBGQNM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 7 Feb 2019 11:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRS7eY3P5RSH8DR4sktCGz3/HXfxC1s+Kro2M9EuMsM=;
 b=QliFbJ2w+xRGIqRk2B65gODrxO3/UJLsBtFj6zVD/XYE9cqFlnCT8whr1kcV8SY0XAuy043lzIvXBaM4vMuhzH9caa/fZSb07AHALi9oguWVeqxhJvW4dRRFFykBv71FPe693nbwCHYBHns3HhwIyNMuz+gOAJMW1jqT2iFCkR0=
Received: from MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34) by
 SN6PR01MB4543.prod.exchangelabs.com (2603:10b6:805:e4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 16:13:07 +0000
Received: from CO1NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by MWHPR01CA0048.outlook.office365.com
 (2603:10b6:300:101::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Thu, 7 Feb 2019 16:13:07 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT025.mail.protection.outlook.com (10.152.80.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 16:13:06 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x17GD4O1031620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Feb 2019 11:13:05 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 67EF47A2DD4; Thu,  7 Feb 2019 11:13:04 -0500 (EST)
Date:   Thu, 7 Feb 2019 11:13:04 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Johannes Unglert <unglert@b1-systems.de>
CC:     <util-linux@vger.kernel.org>
Subject: Re: Improvement suggestion for mkfs.8 manpage
Message-ID: <20190207161304.GC7387@mit.edu>
References: <8cac72fd-8116-53e9-1a7f-5c22377dce04@b1-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cac72fd-8116-53e9-1a7f-5c22377dce04@b1-systems.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(1076003)(90966002)(75432002)(106466001)(4744005)(26826003)(86362001)(478600001)(52956003)(33656002)(2906002)(2870700001)(88552002)(8936002)(36756003)(305945005)(8676002)(229853002)(246002)(6246003)(6266002)(26005)(186003)(50466002)(103686004)(476003)(446003)(2616005)(126002)(11346002)(336012)(47776003)(36906005)(486006)(4326008)(356004)(76176011)(6916009)(786003)(106002)(58126008)(316002)(42186006)(23756003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR01MB4543;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT025;1:PpKgPc612qelwmYft92us88cySq7lysOm41XnEgTfV3Ge0VCHbXuBbajF2Bpeapb4AbYcS/Tudz4ecXrIXE0UuRWRkFnb3NOzVCY2PiO9DvnW/c0vWlwNcrsxCtbnDt6sSiIKHtP99g+1XKpERWo6mtqU2P2n4WMUBoWDb3ReWQ=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db71fa53-7456-45f3-068a-08d68d17255b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR01MB4543;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4543;3:iVk6yDcCqOIvIcGPo7vhVUQwL+Z5DWC2SfTGYMVMyDn+xE1f/kGJYws67RaZP4P9sm1Aym2vFkkPe+rWoZo+CuTkVVVfMoL5MnolwVkJR+rdP1Ei5H0R3aKPma+dwOJFZsMDMOVfOvT/f+MUMscAyAnBDpt+/WTmeQrTi0m+WfyyVqAX5sd5X9b3C+Xq4NA1BYKpgx7SRSQGZH5ft7DzI6d8lmOsAbsvpkCeBJL2WfDtOPUSh6IpAqhSdgt7yv+MVJYnbRwuGK0t6Pv/Q+YP/FqEvWP8IoQdk+OoqLuXY7kTa6z1ggJ49SPf+NARIlFFndUJOZRrSHKuJytolnEQ6SM39nctWV5bnSODwHcEIpCIaeC/tiy7+Kxl/Lb2onDG;25:zVlN16fKxfyODdNDDiVIJBZ/lkpmhwx/pP5kLGbk/PdHNNLYjFuySl1uttAz2pUUViJt3pwh5zmPgvn0xocTn1IQO0v79c3Qizcd7TV/2ezx017n+ffpeaH/YlFBLutws23y3ocAb1DiqYO6eo59gryV4BnzYKv9tF7pDvo2xDiMgQQLMNf5NBHryGT+vz+IfGengVC7Nei6Qaqm3cLb9zAFHXZnDqovZAbYAh8AWzPFvRVX1lYv4fTdr/83eg3Sxi3FMkO45OEHpSz7fHyjVFnnV5JEG19f1Ie0y6yeNHbZePBZWk7qJNDhNMaWM0MheFJfWufXCZKEdd+yT5br5w==
X-MS-TrafficTypeDiagnostic: SN6PR01MB4543:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4543;31:1eZGv6Qu6aGkKmvNcqY4onIcTbC8E3sLdi8P7HsfbAIn0OVLh8Ykxw28ORvJVj21CFriPg0vvKG1XO6DUZSnfNTaE7OGk4gRmAZwyWFrM16ic5YRF2vzsZ0Fb3eg9RfMV+ZdksxfgwgYGbyNVJDbpMm0sha+6hfNbUysEuwNXc+eXFIMUTdhXqut+sAgYKwgvwH1p8Yr7zrLHx7sW3atU/wpX4xtnuxk/V7JhgaCDpA=;20:jMqLBTblJkpjt6eVdThFYB1HVL9xShrjF+xlDuogs0zH9wO8JtJz16KnFO08PL5+/Ktp2IZ0pFVzin+EbcR8dR43B7Miq5hNdIjil40/JVeSc/nMg/tCEs+hL+ZhoTDdJZt1XO+sStYUHeF3w78v4uBPj6x7GRDZUDnTg7/yQBK7vVL40GSEADjq4GfXhvFbJKMU6pHlHfXp6ZWfkgfMvCSipEQybH1/7zvcialbY409tD/EVCfCB1PnNiUq/NkF2lz22RNpgG1UJvQIIIkDxq0Vt5+6AtXj0bDbNaQHELimRGGE1rX75AGcXm5+dyMWC+9/e2nNOCr/eP2vfPEiqXkpS4gI9vajM/HabTeS83Vg+rZ292oTjzRZEcKzT0FVIoXmb+8KUEARPcJchCdEOPZmpSwi9iZdzE37TA8nuYMOACh/sOjQnIkSBGNP/bEl6BNU7orDCuqJcBsD7JqnGDhuWiws2sbqfN4STrKvvl5/wZfxL37IoCVc4ib2543iWM/hhMggDfLe8JwOAAyNcVZWjbRf8n+8rk6dGRqnIGiJZpL1Tn5JgJzK6jl/aLCodfNhidXBN2u4Q12rAUNFQBhy088EVMvA+/jr8mqbQ/o=
X-Microsoft-Antispam-PRVS: <SN6PR01MB4543F0CDB82ACDBA240505F0B5680@SN6PR01MB4543.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4543;4:xXbeARgG6ZR9LJNBp6pwKyOOpASLm/3Oxk100ad/zOaen3K3QsEC9EYvJqJEG6SUnIaBbGPkHgQ348wLms2DAEzhYUOdnmWLNAgwFEiAe0/egMDw3AAG3dEle0CeXE+QRIdJMDI6t0jgBbS64TLNisbMVn7M6+Li5Lvla0JsGhudXiE8jCguiqZd7CXHM6Tct87FflYu85uG0HQxtNrZI5oRemw/qhuwMYqYAQx58xCgkAGkVAXhbkqvyM3WwGe4vUDlZwSgTImoNzNcGBghYl/TRJ1n1B+XYtManpUz2XE=
X-Forefront-PRVS: 0941B96580
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN6PR01MB4543;23:ccN0Sx8Fi4+HzEzwd3fuY7yFocjzK+6XF6Ghtki?=
 =?iso-8859-1?Q?NQ/ixGBG7uoG0fw63Aiwkw30XQEvlbkaRcxLJkbfYtPNyVoZwIAtPGRbTI?=
 =?iso-8859-1?Q?XAmW/xTBnP8MgdTrxfHzZwBYdaWMcq6OQULVu+eKBNuBek9hxsAK8tVpLs?=
 =?iso-8859-1?Q?0sK5qwBxLhHnqZr8FeJwC5Ui334Zm4YzjxjlFyN69MIlrJoUHyJpfHPdEU?=
 =?iso-8859-1?Q?NkSj8xC08E7g7WiQZwRYq4btp1er5cANZXanxpxsJFJFvlAB+GPSQUSFe0?=
 =?iso-8859-1?Q?l/wGoQxf+/Is9F1ztrNTrjp5I+WpdLm8GPsevJhv+B7aGs3Lcc6zGFg3yi?=
 =?iso-8859-1?Q?HWpCQVOkO6aocJzTn9L9Hz/Vxf8YI4FPWj7PnkrbR5M422bt/9hiH3yf0s?=
 =?iso-8859-1?Q?iKOY/HSf/Iba8z5abVFLR73DOMc44CItRoB3g7n17aSVnxnbh2NdO6bhr+?=
 =?iso-8859-1?Q?BBrhfH77xP4VDn4ij7+RdwDXf1832GkwmkKOdfj4zcmJeoufRjfM3hruQm?=
 =?iso-8859-1?Q?/KUb4co68oAluFptoqGBgNE1nCpKDFLLQx+4Sl+O72zm+n6kWQMqvzq7ZV?=
 =?iso-8859-1?Q?gtoFJOMGBk2STmmVeTsRlcAB/NiSmm7mW4svoVQVTjGrhUp9IN/YR6tHRd?=
 =?iso-8859-1?Q?eJi4fx+B3x6BV+88Y59Tl2G4isn7Q7d143w25RXnwkJN8uP5VKIdYNfdhK?=
 =?iso-8859-1?Q?gJwO5R/W4EU/3+btzezxP6oJTJjUJ0coT4ACbAYwK5VxW2fJEQSQXEamgJ?=
 =?iso-8859-1?Q?VQCaLlOoUrxzgZuVuU3fqZko5iQPbZ3e3q1annmtJ0xwCpToCvpnQEAcmp?=
 =?iso-8859-1?Q?DynzEsSjgnbly5FLDy6u2ZyLQ5Qmy/Bgs+nUY8wnXfnLJlnSMCAdFgp6pu?=
 =?iso-8859-1?Q?WcFzeBZ3DmH4Xeta5j942Du5qwp0Xdj6YN2MjffT5+6mGLjpIsbPmq+eNv?=
 =?iso-8859-1?Q?zwVcevAf1r7WRNn9ROlrdmM8HPb6OZkdyoaW3FyLjZGRN4YH7bY6eZUK+x?=
 =?iso-8859-1?Q?zjiCyGUB1cFfE/uNfGpWk6C/iprG2Oulhgg4BJTueD0ms67aGfPeHrrj/E?=
 =?iso-8859-1?Q?PXIlbQ6ZUXyhwfnLBOkdEhZjgujOszWbn6QDLLRr1fWYEK1wgJ84ZlOTcm?=
 =?iso-8859-1?Q?1osH7YuEG4+tqyNJrTwlCeTSIpWMCVcaKMRHOYbzVFn08q6bNm+vc/IniV?=
 =?iso-8859-1?Q?dFKAO5ybW3xaJNqDTiZKFKK4GBwfNH+iU7RvBsUGpqHlstIdo3VMXo=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GscfOLJjY/Vqgp1DtBNpvM5ExNCsmm+aYQWtxBQroHVUAheEXEn+uhyknIXVir1WIAR2W2ZiJ2BmBLgPruqBniv83iK7GuIPYGzFGBp9cMcxlhyI3K0Nax8DfHzT95aCx0f5SGWIlTsseEKQojXHZfGHBw5opDpZ3AiA643aW0V0nl6m6YYDxFyGyy5OlWo2RWRN+RFkuYOxmijrF5SOP0kQrqyL29yBfbJLvcktJd1SqbSjYRJWVTQnel8OJkNzGWXNrmc2pIe9VL/K8t+L3Bjr2KAXSLUUw0lWTcnUnAb+R2E5acnRCooHU0QO/Sdaoc1J2X9fsBn5d47jhPZo8e1NOiKjztcjQdZxNQ3wINqQRLUaHYvI9NCbQPwC9M/GETm9GOaACXSRiGKLKSvrBhivDmZI9mdxguyAx1ZCaYI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4543;6:wdeJo2Y/lL1uUrYEDqnQXlxlcfJ8nO7w32gtnTQnzZ3awX5lpfcvOaUc3txrgqWRKJoEtc8BEqEysGPU4THeJZb9IiJ1HfhcHslQjcF+oaIMCetrwJSY39wHHqiy07H1Uw1G9E+tsDUmMQkhi7j5Lh0Er2mCKKHeurWdbVIeBrsTpN+zV4YPa6sw1jB8ieM+FD5RuocT2yMK1lGQYTuJJVCuQvs9L6dBBkN/ID/lrtGldK+z8laRpfAOQps2ZZODjJlfZe4dcsh/dRdXOlnO4kGQ6+ASYH2iaLk9jmTFRqQ0zfxkJ7vuWyMuLisukWA6GBrMvbftk9ogR8nNJSI8iaxNbR+xzrj+AT/NeDHfZIwb1cWleVIbOl/0g4cenz2jCw2s7mr58KleOWRxJPhGCzuII9zBaXt+cvAE83ucI6A/ufK+X/rj4nZEzWV5X+LfbIaKWfNk/SdwG8mybOuIJw==;5:3DkjrWa1NQBul4PwCrxC2mVC58vgMS5I+YLlORPtnQO56cdhpvc1OSskplB4RLv597F+K6JFkZ8FwRh+w9c0KbYF608pGGkWHeHLupvPVw4jzOp9wT9MWpl5WIuOtPyYmLt/jzNgvndLXQ7HUd9NVAsASs4YGEyQ2qmqqVPF2jAOkOjkC56jXSYwRBqipjLsVM4kqBUJ65HB+jL9wJc5OA==;7:bCZ+M6gu9jmz8CPTNJx9ySOphwdDItGIKRknl0Zc/qJb8On5pwBYwKShD75T6TiMWt1XCVe/QOhrkkeHX2zD58havW5ZMH8Byk84hmQutd88Iql4wkSdWdfgpf+o0973UvskL1OqW5dtGc9r+gW29g==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2019 16:13:06.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db71fa53-7456-45f3-068a-08d68d17255b
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4543
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 06, 2019 at 04:43:14PM +0100, Johannes Unglert wrote:
> Hello,
> 
> i stumbled upon a minor spelling error in the mkfs.8 manpage.
> It´s an capitalization error for the verbose option.

The existing man page is correct, as near as I can determine; the -V
is the verbose option to the mkfs wrapper program.  For many file
system mkfs.FSTYP back ends -v is an option that will ask the
mkfs.FSTYP command to be verbose, but that's a different thing.

					- Ted
