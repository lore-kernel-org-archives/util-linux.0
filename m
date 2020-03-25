Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD5C1975A
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C28B20719
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="otRgFaVa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vVU8ymtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYPMQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:12:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16573 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYPMQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 11:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585149136; x=1616685136;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gIF0vaN8y9Mg/6Aase3Y7/gr5F2AltCFMRqW2pKdLKA=;
  b=otRgFaVaMYXwujswCW4af/WJQhAe+976mBfIHpeKhPaMseYemJMDhSgE
   Qurl1jK2ltzLuS5NaHz3ufP1mgOh/gYNhzuG8eUqFnWtpGdwXUr0wuvSd
   mRsN88He2bjGiRphAWR6OEjIQ/n+iAO16NDVdkKBN2AjGfs1zN/91UXDK
   YMn30YwlBEV4R1I6jf+onfaukxjwAAqgqElJW+fVQCO2XZG9S+VmQFHOO
   8lDtNfYS5WUoB2MrKMNtvJiXiyQ7J7flYd+PMA0aYsptk2JVnwSo8wZS/
   p5qum7EUCQiZ4x2VmMin4qf8vRE4b3JwNWmilbgaZBGuGOD0npl/EoFPZ
   w==;
IronPort-SDR: AtK7qTaqv/4eM9OrrHnUhxiSqK+vQrtvBRARlnRb1QmyTCwx8rx/ILWcZy+cQENHUPtT8xlN/x
 c14gyJl+iFKvlhVaQh/XMosXbuKaPe/dchdV5hRWTCCW/hXFMfZDyAjwG8/3+4ekEIJbSG9QQ2
 NL8GU35X6WtjlsNbZ6XMdCBF4fMK5192AJund6cQaIHZbjdNanS16c+QfWLHD490ixbdon5o4X
 expSNpDuyt49EjMwtw5jYH/kyVd/bQKu8uXSceU9J6ILkMPj4+g2YZg4RkfEAcUnKIcwGYilBq
 S7E=
X-IronPort-AV: E=Sophos;i="5.72,304,1580745600"; 
   d="scan'208";a="134922503"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 23:12:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW++Mbz0Dxb5dpxSc6R42lQPDt7bEKpggwfiz4g0CNLncFk7gvMVzFOzVmvIJsvDZ0SHDOD+DdxOWlks9llBdqK34T3wIWidT2HLI7fjMUcdu7rJsbyGqJIGY95219+HGl01dfsd0krAbUVC1cPdqyyNva98nLcXudXMhCqOJ4IcmwKx4MbMkUWp4OeeYxDklySIukrzXbPqNcKrqum6iXEk7C/OIaD6aakmD2xypWB8GE6pApf6CnTdLK+xqPjpDygkCpsXZBYhACIDUybb+2t3BZEJp1MR1Qaj7acsMAR2jVa1QXzKCqnFAYqXAf65szDu7skqaJixIlS604LpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijeRK0+QCFeICxebmXnqQ34vTXA+c2Ewrq/VF7Pf1c=;
 b=Fd6GZMI0eoGnfFfW4xKPwp6cH2PDE/BrlC1VAfhsspmD83QoF8fz1R/+oXp82G74ES4tiTwjwoCuhSc92Od99QYTasHMkWFScyfxlF6v51aHiMxCbEkeAoaSosl1iv8cmYqeP2EzIB5cz0MQp0Il9wVS9ix1D1mKjR16USGrlGXKqI2Ci8r2iSVGVfWizM+77j2BPZZ7h/ASYBbuOsHg1AlY2FfIOQaFUX/u1OmaLR1yERU3vETiOh6FSFYuXfZLI4Iqrvp3eBNSaxDc388QgP6Kxkl56ZZwr0DqqCaVPFpt0Mm0zlxgoT0BiJDs+Z6JNrz6zpSVULupt4CQP5Pd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijeRK0+QCFeICxebmXnqQ34vTXA+c2Ewrq/VF7Pf1c=;
 b=vVU8ymtABD4LuiqcgK9ckkON+K4a781qeaGpBnBQJeUN5z1oStHHG+H0xu2XSNjF37jZ56q7wd1ejSX+n8JjVXbAkBTQDbQgbAJSGlRfOAf62yZgR4VECfwUSdBIxhYc979zjonJKaJoTiiwA0dITMkdSp/A8TNT12BqgwcW/cY=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2134.namprd04.prod.outlook.com (2603:10b6:102:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 15:12:04 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 15:12:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v2] blkzone: add open/close/finish commands
Thread-Topic: [PATCH v2] blkzone: add open/close/finish commands
Thread-Index: AQHWApmXFtfF4AOO7kmjgWaMiOa+fA==
Date:   Wed, 25 Mar 2020 15:12:04 +0000
Message-ID: <CO2PR04MB2343A0A15DAB638F4989CA22E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 0ba6b3a7-bbdd-406a-7d36-08d7d0cee0b9
x-ms-traffictypediagnostic: CO2PR04MB2134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2134746A284E8489B775DE2CE7CE0@CO2PR04MB2134.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(2906002)(81156014)(33656002)(6916009)(66446008)(64756008)(54906003)(66476007)(8936002)(52536014)(316002)(66556008)(81166006)(7696005)(53546011)(86362001)(66946007)(8676002)(478600001)(5660300002)(6506007)(186003)(9686003)(55016002)(71200400001)(4326008)(26005)(91956017)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2134;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBcIqrwjfOZPRtPWtfy4BShVuvCeL1LI+eJ5ajKiGNqtM5XZb7gF9xn1jyzq9iO6/7dIoCB8reU+xo/c4q8ZNkQz+pQP8ys3lliIbl0y1EnEpeypI0TCXcxqX1A2vFx0WiBpQj/2SIyJjGIG0t1ErU55iATIF2A7NNrk4EL3zF0mX2esTjBERc5ZHQINf8gOywVRvGSMHV8VYA+Hou/ECbLIUZrGK8WPf9h00wKkHrraTTlccTHRKHRozG3cUpjtODKPWkpb3Jow8mUnl8h/kL4CCOiE4Vr+/AQwuuZjAiF9SxiBZ2OCKSSu9wynunce420GF56u04vzJQEDrX3/jmoi8et3gn64W9nU9iUaGGmBwFviUPWcqSCQd5DIC6VQsEd1DLd7bW2k62OoJedNgxVCxYq1jwyNkNabdfwIZl5QPqQTPy9MyAK8BDgmSLUm
x-ms-exchange-antispam-messagedata: JmtPQxvtUbt19UItvBaL0+/ZqclHlTo9Yykr6+M0GWXkDdoaY2vWZR+Ye1XwsO97+OjpQrpB46DtbF2eUgWemNF+eAmVwIqyRGVLT8jrm5cTPet0L8oqMzL2aMnNaPfdhJExRwZMdcrA8a/b3+MXeg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba6b3a7-bbdd-406a-7d36-08d7d0cee0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 15:12:04.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gPihFp8FZR2wTF8EMcVPBZ+RXXW86gLj/ziGK4ASVbK0P24Pg/RZJDB7i2xYFZ/3iymvINTD7xnTX8PGu6yMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2134
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
I just sent a V3 of the full patch with this cleanup.=0A=
Did you prefer an incremental change ?=0A=
(I did not see that you said you applied v2 above... Thanks !)=0A=
=0A=
=0A=
> =0A=
>  Karel=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
