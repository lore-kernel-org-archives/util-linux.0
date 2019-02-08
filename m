Return-Path: <SRS0=kQKg=QP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05947C169C4
	for <util-linux@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DA320855
	for <util-linux@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="Gklrk7jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBHPWF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:22:05 -0500
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:54192
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727993AbfBHPWE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 8 Feb 2019 10:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7jNuut34N7CcOcOPg0oq7yzI4T6MXkXXbcaQDk0444=;
 b=Gklrk7joiXsYLg5yqX5s5qIkERAaJSVrXqqKOpm6UmFHFa2tTzNmTFr+2IRU0VpTCLrVrSFLEPsLENNsebe3PXjmmrNwDDuO4O1ktGYbdx06jtuhE2bbqp4pK4WvFYYAU/WBgbJlGkt0wachXwjCXG/ZN9FaVrWX99l+2uVqfpU=
Received: from BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16) by
 BYAPR01MB4486.prod.exchangelabs.com (2603:10b6:a03:98::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:20:05 +0000
Received: from DM3NAM03FT004.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by BYAPR01CA0039.outlook.office365.com
 (2603:10b6:a03:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 15:20:05 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT004.mail.protection.outlook.com (10.152.82.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 15:20:04 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x18FK3Et011206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Feb 2019 10:20:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DFB237A47F5; Fri,  8 Feb 2019 10:20:02 -0500 (EST)
Date:   Fri, 8 Feb 2019 10:20:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Johannes Unglert <unglert@b1-systems.de>
CC:     util-linux <util-linux@vger.kernel.org>
Subject: Re: Improvement suggestion for mkfs.8 manpage
Message-ID: <20190208152002.GA23000@mit.edu>
References: <8cac72fd-8116-53e9-1a7f-5c22377dce04@b1-systems.de>
 <20190207161304.GC7387@mit.edu>
 <3ee93fe9-e024-ef49-92d0-0167318bba36@b1-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ee93fe9-e024-ef49-92d0-0167318bba36@b1-systems.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(50466002)(26005)(186003)(76176011)(446003)(47776003)(246002)(2906002)(336012)(52956003)(1076003)(356004)(229853002)(14444005)(2486003)(36756003)(23676004)(106002)(786003)(316002)(58126008)(42186006)(8676002)(6246003)(33656002)(75432002)(36906005)(90966002)(305945005)(476003)(86362001)(6916009)(106466001)(4326008)(2870700001)(126002)(486006)(88552002)(11346002)(26826003)(6266002)(478600001)(103686004)(8936002)(2616005)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4486;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT004;1:ccAjhEHjeCO9MNXBmLuOnGMKE2hS3+3Q1X3omekVwi8cSSjUydJBIh28QiakTr5nGCYJ49i7Y8OzdMB0Ugwbi9LqUai8MRTAJArb7moQ9JFUJqmeI9wwSjAMd4Se25Ch0rQcbdpAO49LuSl4KTZO/A7EhooHgMKWPvY883IS8QM=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b384a32-934e-43b5-b412-08d68dd8e728
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR01MB4486;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4486;3:NcdvOT2O5sGWEgH4ygyFIhKBD6livOxc9PBiib7Q/Fk3bCkQBJxc8+pLesASg7c1Pct0oC8l4tsa5ArPUaP8a0DJiPGuGjSTAj6Vp4z+0cc75PY2Crk26oXjypU4HFMO4GUjV4aAf7w7oipjoQX2BK3u8wqL+rccqXo6VCebiCaPBE3+tGeeszSiPKidlAaMfqU7e9ss38D3IRog3nKsi1iv6kvCYQiM80wm3GI53xiIVKd1JPuEpkWPiJdnveq0iMQx41alOZH8j1jI2RuUdq1BBxJ+aX0jeGLGpwtFdkojFkEHKhIEJSbGxphgKKMXELyQ/vStTkHijdapg9aB01kMJKBL4BAldiv07ZvN1bfnMaLG3SBZOssFcdErmdl/;25:jQEMn6+ihzFhbWAWr5djblog4jBIW8UXTCBxz6bbQBP88YESk5LR0uniTsHHIxPo8LoF/VEns97IcPKmKuZbI6CyaJ4Wxnpsa3fWydwSpLLu/+zHo9J/XxJU1L8FNAuadmtSR4S1UkUPoaos/eV0iJSeB+eQB/lGurcB0zSZiqo8TKlyU736i3wmNQiwpyQDicVO6NA0QvCgkDKT5r9zVJIOtIMODey9fau+YX9hNdcIsdCH14N/lTVqqHQ0p9K0lww9Wqx2LBZZUBv3LwLOxQ8VKDpm40vZp+QeJXoDWllt8QY58+nrC8q9TvEFVp9LSVsOuB0C+kE/TXrod4shFA==
X-MS-TrafficTypeDiagnostic: BYAPR01MB4486:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4486;31:k9r96NbpNq0rJ6R1Jzai9n6tU6vLikTmszuDZ8oQZjmV7vmiwt9ORdExdaDbNvNyun1bSJxsFKhZBcRDIyU6FdEbj6DzuOfN76eHoK2VtvZcquN7C21NtP+q4a/mEOLekz/okt07/LQCJg8VjvSA9Cw604ff8Lv424oT449LhbrHWKIadsT5P7mTbS07q3IrWJa5YZdhdeQGieGB9JrRqoBt9oV5wFOLQKwblRWRdvE=;20:G0HnjOsEmWopUzzft9GdkYdSEDjj3OcON1hP72M2UTubGr7y8DyRp03O7O8kMB9Y1up8/OxczB5tj7KLtXQ+cLmd3csgy7QoT0sFg6WTo0vxpnWu+jYaEQcecgST3d3wB4gSKWKpiynBqEWOerVtaFJriXYFEgoDBDG/6e+2gtrzNuiyMQ8JxSe5N0zNw472BgeKW2C8aP/agObWkiveLPydDmbc1VwBmKolffkV3wNLQIMhK4UT6J8XBlbuECAVCAiSCOnkfcldpO9I61FL7Pevtm4ILGkQucK4qDgKBcCsLGrvM1XaHr6NZ6bCRwZZLCXhGB9NB6ZL2NH67CewPRcn4uZg6F6DI0h2rhsBEkih0gMMW8seZAb9H52I1U18FhAqcYBVqXRGFmXgMiFzffPZE7eLldIyNViHYozWZ5F30zdCa2C0TqOcSdpkiMh+jjIq4c/l80boH4fsLO3Ew2idxSz5J9nNhvtOCHdU5ckuhE3wqqA9VOGP2SuQPFX8VcGh1dCluUdAFXyzKwnbuwz0XT83UvVcHzGTy6emX3bVWmZdS1gdntyjJJdO/MPAViKR7pYID2EFaRPuDgffgjsq5ZalkJX6oZqkCDtX/hg=
X-Microsoft-Antispam-PRVS: <BYAPR01MB448653FEDA7076119F6DC80CB5690@BYAPR01MB4486.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4486;4:dg+4s7M7I5it0yyTG+PWjWY/BncKATFrZuUc4/uko/qp+QGAU8fLsn+hKn0Z74NjRiT2vxtZcANpdo9lnrzi1bdw5JIr7KCCXl2LCI9FzcJQdEoYDGATvBJN5kYT2W2py4PRAayZh7Bve4sd2G+J6WWkFLt9lk5SI+NOpKXh2qAamDxqWRQlY//uIVZnaAqHfIrVhI8Bd90P3qB8B5ZVb4vArzWuM07YyKfmimsIhcCAbyfd0v6mPvWUh9nsKWHL98CAHqp90Cf2bJheJ6ggQvBYwzH7MvFJPvsdEQX4gNJidzWkhQORupacZprxXG9D
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAxTUI0NDg2OzIzOlZ0Z2pKeDF0NXJ3RXBMSlJxNE5ybWoySllS?=
 =?utf-8?B?anNHNFlQaEw0OENCVVVLci9nVklFb3lQbEsxOXhWdktheG9Ja1lIeUMwQnlO?=
 =?utf-8?B?aVJjanJ2NUUzV3Nmam5IRXVPNWNsMVZzMmc3d05ZcGZnNlFLK0RNb05ZSjBT?=
 =?utf-8?B?d1lMbHdjN3Vnc25QbldFU0JNK3BkZ2VJS3VCY0ZxZjJza0gwdlY4MG5WUlgw?=
 =?utf-8?B?K3U4TXpTdDJ0NzBONFlrQ01PenkwL2xudU9VZjRpTnRtcFRSQzZuZmx5bmpu?=
 =?utf-8?B?WGsyU1N0Tkc4ZFozdnRKRjhQNU5tUXpzeis0MkR3akZzbTVPR0tHUnlRNUU1?=
 =?utf-8?B?clo3WW1TNE1JNWh0MHNDS25heGNKK1RMcnZZMGVVRXpqamFhMjEyQ1RpNCt4?=
 =?utf-8?B?NVlTcDJXSjZSa0JqaTM5SE1Pc1kxZ01aRHdGRzloa2tMN2NPVHVCaTVkM0x0?=
 =?utf-8?B?Y1R5WjJNaVltaUhuK3JmYmlFN1BwTlVjRWovYTY1cjlINEdXOGFzNzd2aU11?=
 =?utf-8?B?eG1wRTVqcUc4Umg2eWJ0c0t3MGpjSlE4UUF3Z3BMTWJRMjJ0UkRhUy9tcDJS?=
 =?utf-8?B?ZDh6cEJ0MktFTjFwWm5XRG5nNklDOHU4bnJGZHUrYjNoTEhzdXliNmRmS2U2?=
 =?utf-8?B?d0puSThVNnVDb2R2bWM3eitHNks3a3dNMDBVTDU4U1MzYWsxY01xZTZLNlFD?=
 =?utf-8?B?THNPU0ptK2ZEdjBLVlp4SmxobzI2TThHNXJUcTMydTNJZStuSWFJcHRteVhi?=
 =?utf-8?B?bFltUm84aTUzWUtRZmRSeU52UjkxUEk2MDlrK2Z2VTFPdCtIVk1sYkMxdmFN?=
 =?utf-8?B?Mk52NjZaUDNjTTQ1dmk5L1d0eFgxMXJYR091N1UxOUFWWE10dzJ4ZnRUWkEy?=
 =?utf-8?B?TTlIVnhqR2t6ZFdLc282dzMzemNEVnl2MmhFSzBYeFQ5VXZYc2NtcElBTkZS?=
 =?utf-8?B?Z3JCRHc0TFhDUkVoeEFjZy9GZDZzeW1zbDYzSnZuZGszTEhSSkpQMDlVQVdU?=
 =?utf-8?B?NW9TSTVWUlVTU2oraDlMT2NXOHFieDJiUkpHeDNSSXNHSHNZYzBzdld0VzN0?=
 =?utf-8?B?YmJTSXB5V01qOGhwTmsyNkZkMUd4NkI4dEFDeFYxckVnaWUyUnJYNms2Z2Rx?=
 =?utf-8?B?L2RQMkd3dzRESjhXakUyWWdxMzA4ZUhFWHA0RGQ2dUNFcHlEcVIvOFdXS3lq?=
 =?utf-8?B?SDVmOW1kVm9SazlQMjltK3ZUTmRHbFd0blBVUytWOXpRZnYvWmFCRDdlWUll?=
 =?utf-8?B?c1E0T0Z1bjhHTFdoS0VmWXg2UVJLMlVPQ215NXJNakY0ZDluL0xhZGFpMExs?=
 =?utf-8?B?blMvR0luNENEc240OWVLSEVtbldzT3ViWVVwRVJNVXFQNE9rSDdCZStLc1pI?=
 =?utf-8?B?UndwMis2VnVEb25pVTlER0tEMVZSZnpVL1dna1NuRVpRUDU3STEyRWdFODBR?=
 =?utf-8?B?ZjhKb010UE0rMkprOTBpemZWejIrR3pCdWhDWm1FM1VDcG1Xa005SWZpMHZn?=
 =?utf-8?B?VC9ZRGhZV3htaVlpZ0JkbWx5Q3NvRDN5US9UWU9YMkdRRDJsdHhTMjJ6Um5o?=
 =?utf-8?B?enRTR1owcWFqdFg4S1RSdk1GWmY2N3hSdnJKVzl1T1VkVjAraE9wWnR4L2JJ?=
 =?utf-8?Q?GKWcIx+MP0g2id+4r7Ex?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sgoQdw+PooKqX0fCeo1ksjBcSjw5vhiGHRSs4VTf5zSF2lg/qyoLKwt+Gq6N9C4mDUnDRr5Q9ogNUi9Jnr81XFseBWzdLbkSp7xYToDch9PH0ToVjd4wukeAKUU8WQlPFtJuoBNMwHAms0cuPn/RKYdtu2aHT1ImKFcFFIzE5TwXRaXqIcxLZ/mpoFGUuBFubsX1ggRPd3vU6Hk0Fs/0gM6jTqe2LnN/dmpZZU01vZWwkcduIzSldvj8v7SM7NVNv7RWoVd4i9+28/KLgTFQFn4JxfQMkEeuhxOU1HHLkV4OltKV1CbBYRzdYe+UUmVv0JqiSKE5aUoVVjcRJzjj6gof6eFo/BxtIp0p4amT0BxLAOZrAWnYg2gPV7VR8jjisqwN/SIOl/uq/dIa4mRL+SFPyHMAkPECNy9m65cVAWk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4486;6:XMLrodGACY6e8kdoP1YH+oIULk7BIVq7Ta5NoMpQGmbjh7+QjS0dn7ePSKMg+oP3mzcc04A9sWPDZXkcd0D1eMCWzv6oEoxxtUVLL6UeUYnBQrjqnltr/0iQWHs37hOX8xd4JuW4FoUmnjofghVTCjKXuzgPgt1UQ5E1HzMUdid8m6CWDBIG6JiqoISC0MS+7OQfgwIbh2fh5uxT4By+0kVKUgGA6Vha+/SINQkhOk7JX3WwWGiMh8pn9fGX7paTQ4mDs7/OQA1pysW46iuZZCWTd/F3M3SCfqc66Cv5gGVW8QxiUvlZ7GdeN1Ka+s4sAfS4r0SACrdf561xDFEuZYZexRSYYWtSjn7ciyvvbLGbwGsaL+gMZshEGWHqtPw+lgoL9OteEP9poMwVana/Ff06rU1rvgkY2HJ3+7LX6Z/uGD6qwaxuOSbgRH64U85PDqLTq+ag7qY84eW4XgQNow==;5:Nyg/ixOQUSqUwIrKsZambhQxtlQW/2d/bnJwjSUBsJkoLrRrC0q/Ws327djLoCUDHQB9lwj7zveakZKY99m0MA2+C7b6MGR++WNxc3p/1WgZxaSyt8Z44SupLM7OHZUUCUXrupPGQUW9FkDyZ1miDJJZokVWb93923Vk+IDRS/1e1QWg7BVViQdL+QBS7EEruNa7y3FYh8nE8DQtnORXyQ==;7:v9R8PU8vZW5Gt8mWSn9yIfkPWitlYh6+hijaXK6u3mgBtnPYzv0fV37a7RQI5Q7LZ+oSoKyBAEtnvdhIQAJONMOcJTCu22kGpK2YQ/nDeNncWcRArg/LdRCBIIssxbrHHED5Hn2ogebuA3+elYBoIw==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 15:20:04.7028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b384a32-934e-43b5-b412-08d68dd8e728
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4486
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 08, 2019 at 10:47:47AM +0100, Johannes Unglert wrote:
> 
> I think I described the error the wrong way.
> In the mkfs manpage there are two -V options:
> One for 'verbose' and one for 'version'.
> 
> The two -V options are both written with a capital letter.
> It is ambiguous and I think this should not be intentional.
> 
> Please correct me if I'm missing anything here.

I noticed this, and it's weird, but what's there is technically
correct in that it accurately described how mkfs works:

       -V, --verbose
              Produce  verbose  output, including all filesystem-specific com‐
              mands that are executed.  Specifying this option more than  once
              inhibits execution of any filesystem-specific commands.  This is
              really only useful for testing.

       -V, --version
              Display version information and exit.  (Option -V  will  display
              version  information  only when it is the only parameter, other‐
              wise it will work as --verbose.)

That is, "mkfs -V" == "mkfs --version".

However "mkfs --verbose -- -Fq -t ext4 /tmp/foo.img 4M" is the same as:
"mkfs -V -- -Fq -t ext4 /tmp/foo.img 4M"

I don't think most people notice this because most people they tend
not to use the mkfs wrapper in this mode.  In general, they will use
"mkfs.ext4" instead of "mkfs -t ext4".  Which is good because it's
actually a bit buggy:

% mkfs -V -t ext4 -Fq /tmp/foo.img 4M
mkfs from util-linux 2.33.1
mkfs.ext4 ext4 -Fq /tmp/foo.img 4M 
mkfs.ext4: invalid blocks '/tmp/foo.img' on device 'ext4'

In general, I generally recommend that people use /sbin/mkfs.ext4 or
/sbin/mke2fs -t ext4, because the mkfs wrapper doesn't add much value,
and it gets confusing which options are parameters are grabbed by
mkfs, and which will get passed to the back-end mkfs program.

Cheers,

					- Ted
