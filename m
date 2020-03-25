Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A0C43331
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDBE20722
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="achal7Wp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z8FXFmEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYLh1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:37:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63791 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgCYLh0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 07:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585136246; x=1616672246;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1cXrKjVugwtAHZ7eq8n6KA3RpDcgcvpLjBfHGC5gECM=;
  b=achal7Wpo1jMi6cQWJKzNYaBjILXDadEeS78fhDghLLpE3XwKHq1xtGd
   UxN2mm5JwhMzGAIpGtTdXvGzBTx5LThBoI01umGKjUx3V3iIuJxh/AkG0
   GwraTGzl56xXhCMlRX04YBtYmd46UCceZc/JhMnv4sgQH/QTXSeEp7Tpq
   j6ue7ym6UI4lhhl0GqK2VjeYxOXjREJOQZuAZd8CrdChDz3mC3ndryTpY
   tQLLhJVtqKbyJoakd32oZZ0OZ/bACeVyEbeuMGKnD5nZT41jk0sdU+MBf
   JgGvqE0p7yxKXbDXRYspDi+DV+Tf0QO/8KiP+DQCPfnN/lTuW1jkfHW+i
   Q==;
IronPort-SDR: mxpfFsU9nLgw829fFqotXBSRWPp1QR2HJGcKxljgjizj06ITB/5r9t0lAu8V3HDPriB11Ei96U
 wlPAkZ22K7JMXPKTbSMFpWdX+SaN/hn0fGcpqi45Y1TvWTy8jMXQuiVHANT9IIMrMq82Ugo+Rh
 Gv2qXIi3FGjlgLc1smrDedFxFpVnvXv7MWFRJ/kTr/aTAVemddDb/kB0mINSzAWSeJ+4MtR7dX
 UrjXfEUPBQGsCrjGCj9rChGRlEyDIK20SMwPNOlt8ylOZdyr8qMlIUyubk0dcELPp3pWl+d4jU
 0Js=
X-IronPort-AV: E=Sophos;i="5.72,304,1580745600"; 
   d="scan'208";a="133460888"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 19:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBAdt6vsUZyzMJU1wwjFUREIR6MFJZfzk8a+6bThvt+NrNxj9ZVa4dADQWdtg38gXeykO9PovXL27K03GMttAcIRFAlm1LU0xG98odAG8uhhVHQF6OLf+jeTX9ZnGU8rZWmZwAr5XxfDZCs13KusGKZ3Ptl69e9p+N/hz6kAH/5qsfid3nQ374lUO4758dDANH/2WMEdlD40ovafYFKeYGtDezzJ3AjIrUoEPhWdOtPe/Q4BzvbUXUtjcZlOyROBKVX/yVclbNEO98DD8HOk3s434dkKpbnMBpx9P1zmgEFlSxpg1+j5i8UaplmBAIReRgM7+a9Wiw2lwseVL+6ePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xkj/jQU2jDpqUiXcDDzHtlVAXuY+9sHjdqtE3DoQqs=;
 b=jiOqHpQQIIKlGsU0Rm96nPuTGFLxtqUBiXQmdDWsHUDHB3aOogdIAT9b8QdJWOyIAF+k0Qp6+awtUJdxr8HIZfRZUmEibAqXug4g/uzD1dXproxJ5EcVUsdCElGOsKdinf1ssVqlKAtE5l+c8jkxjRVzeZrymOkFY0uYQCDttp9ZWRVa4GfOXZAItgxoRsxmALqowM1QPp7obMJP8AWplCK3k0qA1Sy4DBlnNYr2htlr2vKSVZolU6ND+mavoh+RXOEaFIY6hNnWOIpmF/uqkvZOBr+PAvrExbg7GBNbJBtKCkMd1DmAvbLmqcXcMVIMZUOn98NEKIijFSx5nvs0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xkj/jQU2jDpqUiXcDDzHtlVAXuY+9sHjdqtE3DoQqs=;
 b=Z8FXFmENv9C/riFGsxuNtv2h82j7pW1k+krlZRRuo++npwQ/70zRJ0RoF28ucNCEmTN0JtO2XkTog3ijKU5aGC3DyUAu90nN2kwLlt/d9QBqyhlDawCINR+F1+HW4O5H1fuw7hMZWaJutDCRV8LXLdbxFkePje5H+NJka9egHfg=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2264.namprd04.prod.outlook.com (2603:10b6:102:15::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 11:37:24 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:37:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v2] blkzone: add open/close/finish commands
Thread-Topic: [PATCH v2] blkzone: add open/close/finish commands
Thread-Index: AQHWApmXFtfF4AOO7kmjgWaMiOa+fA==
Date:   Wed, 25 Mar 2020 11:37:23 +0000
Message-ID: <CO2PR04MB2343305C46EBDB353267B363E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324100217.47549-1-damien.lemoal@wdc.com>
 <20200325113604.j7qlb7zdzm2azxjm@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8359755-ea78-4999-347b-08d7d0b0e325
x-ms-traffictypediagnostic: CO2PR04MB2264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB226435180F7EDE9DD28CAC69E7CE0@CO2PR04MB2264.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(8936002)(54906003)(5660300002)(7696005)(53546011)(8676002)(86362001)(26005)(81156014)(316002)(186003)(81166006)(6506007)(2906002)(9686003)(6916009)(55016002)(64756008)(33656002)(66556008)(91956017)(71200400001)(66446008)(4326008)(52536014)(76116006)(478600001)(66946007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2264;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tjuf9RpDAnlNg2yzIAHVFRYncxlVzN/Kqdl7j2Oeus3DlotHlmZ8U78HySSvmyH53bOeeASpI7oRwNzFfpGosZnmmAW4dPxAkrMqGfMLCkqXY24rEHGz4CCrZSGx1C+MnkkVcP7HmZZGUkChT3zlWiUFxG0NWtPbgYGIxCQxYOk9WMZamjtzk5ELohakYqeBkRLKIHOp1YkDAqnZTkxxriSnPlNjq9AXfiuZgYR22dQ2RpVVCXx8hjyYJgtRTaY8rDczrJ7Jx2ifrErtA/NfTgjn8sBezSdZ1wdpLmK00VCUBOgsXkUixtPA+fzBhC9oDkzyl+G/9CXWNj5VhxN9zqkAuGCC/Xf6CC24obShG20uYfKp2cvHBjH+bl6DREgY4TsGgdgq7ozofP3cUtmCQyS4TL+TxsR3MNuTqyYO4ELkDHmbNK7jSYRExY8Wn5g+
x-ms-exchange-antispam-messagedata: WNrQygD3G8eu3QZLmspdmXmXKL5gV6ZOxdBu6l2ZADH3z/m+etRXLZhHf6Ud64Qo+aJXP8gkpDZz2WhS7i+Jy9SyDz3lCeJbu8j4Ez7mC7Vj8y8pJzR24xaxHPvn/UsufsAhH/FpVGC/1XbO7YyKpQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8359755-ea78-4999-347b-08d7d0b0e325
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 11:37:23.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCFoMOosRJAC8S+jAbM/xYvAKZv3ubmq/Y37uGqRrWajk2SHn/Jw80w8CNR80MymXclJzd7mdWlcGfvM7BgAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2264
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020/03/25 20:36, Karel Zak wrote:=0A=
> On Tue, Mar 24, 2020 at 07:02:17PM +0900, Damien Le Moal wrote:=0A=
>>  sys-utils/blkzone.8 | 27 +++++++++++++++--=0A=
>>  sys-utils/blkzone.c | 74 ++++++++++++++++++++++++++++++++++++++++-----=
=0A=
>>  2 files changed, 91 insertions(+), 10 deletions(-)=0A=
> =0A=
> Applied, thanks.=0A=
> =0A=
>>  static const struct blkzone_command commands[] =3D {=0A=
>>  	{ "report",	blkzone_report, N_("Report zone information about the give=
n device") },=0A=
>> -	{ "reset",	blkzone_reset,  N_("Reset a range of zones.") }=0A=
>> +	{ "reset",	blkzone_action, N_("Reset a range of zones.") },=0A=
>> +	{ "open",	blkzone_action, N_("Open a range of zones.") },=0A=
>> +	{ "close",	blkzone_action, N_("Close a range of zones.") },=0A=
>> +	{ "finish",	blkzone_action, N_("Set a range of zones to Full.") }=0A=
>> +};=0A=
>> +=0A=
>> +/*=0A=
>> + * The action values must match the command index in the command array.=
=0A=
>> + */=0A=
>> +enum blkzone_action {=0A=
>> +	BLK_ZONE_NO_ACTION =3D 0,=0A=
>> +	BLK_ZONE_RESET,=0A=
>> +	BLK_ZONE_OPEN,=0A=
>> +	BLK_ZONE_CLOSE,=0A=
>> +	BLK_ZONE_FINISH,=0A=
>>  };=0A=
> =0A=
> If you add ioctl_cmd and ioctl_name to the struct blkzone_command,=0A=
> and you define commands[] as:=0A=
> =0A=
>  commands[] =3D {=0A=
>     { =0A=
>         .name =3D "report",=0A=
>         .handler =3D blkzone_report,=0A=
>         .help =3D N_("Report zone information about the given device") =
=0A=
>     },{=0A=
>         .name =3D "reset",=0A=
>         .handler =3D blkzone_action,=0A=
>         .help =3D N_("Reset a range of zones."),=0A=
>         .ioctl_cmd =3D BLKRESETZONE,=0A=
>         .ioctl_name =3D "BLKRESETZONE"=0A=
>     },=0A=
>     ...=0A=
>  };=0A=
> =0A=
> than you do not need this switch() and command_action()=0A=
> =0A=
>>  =0A=
>> +	switch (command_action(ctl->command)) {=0A=
>> +	case BLK_ZONE_RESET:=0A=
>> +		ioctl_cmd =3D BLKRESETZONE;=0A=
>> +		ioctl_name =3D "BLKRESETZONE";=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_OPEN:=0A=
>> +		ioctl_cmd =3D BLKOPENZONE;=0A=
>> +		ioctl_name =3D "BLKOPENZONE";=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_CLOSE:=0A=
>> +		ioctl_cmd =3D BLKCLOSEZONE;=0A=
>> +		ioctl_name =3D "BLKCLOSEZONE";=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_FINISH:=0A=
>> +		ioctl_cmd =3D BLKFINISHZONE;=0A=
>> +		ioctl_name =3D "BLKFINISHZONE";=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_NO_ACTION:=0A=
>> +		/* fallthrough */=0A=
>> +	default:=0A=
>> +		errx(EXIT_FAILURE, _("Invalid zone action"));=0A=
>   =0A=
> but you can use ctl->command.ioclt_cmd  etc.=0A=
> =0A=
> Just idea :-)=0A=
=0A=
OK. Sending a v3 !=0A=
=0A=
> =0A=
>  Karel=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
