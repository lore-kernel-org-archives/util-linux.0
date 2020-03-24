Return-Path: <SRS0=M7Df=5J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281EC4332B
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A462051A
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 09:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HwDFxpvt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QcYHV9lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCXJp3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:45:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27485 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJp2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2020 05:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585043145; x=1616579145;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QcuU6ojLmtwfOAW8lFerEq2k+btqqaNg4ru8jDOZRRI=;
  b=HwDFxpvtvzjkkXlD0t5gmP6ZjTIQGw4Q4ZWDX/OzwNfXii0Pk9kExBbL
   XIF3oi6BljYdiqcgzimB9dQUATzVRH+BDZd39vBk7VJSUiZxBSbP05zWS
   ZSx+zI4w8N7uN7JsRty82YegHzniBSfdqNOfuZS3yop0GQ3qbQb7OX8tJ
   fvIdDuWju2JN6WE+gIDAnIpwr/LjCk8eBjnD8vLisUmtYDZ1v1sv1p3+D
   QAQ+40QdA+apYAAbdcj5ghuS6PhlzqiNQvWEfgl8sEPMkigCODHCVrN0I
   yHXivbxzTdqJituABzrdDUONUS74sJFqOJ4YP3W5j/kzsal9DjcB1M2La
   A==;
IronPort-SDR: Pfb2qLJFjE9KXGQOjhfyzosOx6v0a/Yvx0OdqDNUyd4G0d36uYMblEmXfwx38QGq6txEjVluTO
 8N9toskCXUrxNk6XdgXrtcAgNy49DVj3htHb7TQFzk9ghl6NaeiAsctEO5ABl1QSRPtcB3eNEx
 FQiahlYLYMctDR0MGbmM9+twld84F7KCnmpW5aACEhUFZctWDGGFfRWeiH9E8OmiM/6zI74jp2
 rOiAGvp8zin5tHVW9X+VX3WiZ0E1C226uOBwvGcsx6/qxdIOnA1W5wkhYXSMLWJkwvVMrSJja/
 ++k=
X-IronPort-AV: E=Sophos;i="5.72,299,1580745600"; 
   d="scan'208";a="235553062"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 17:45:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+htvgj8uKD44gbuP284sPB+XyB2iasXwahYqPsMGo65TMOPl4Efq8olWkleHnvW00j9kNOnqxTnZv3eSyA5JRoL8Wj0GjDWCwHUseRUWyKhj/nBqtVPX0op7HKwcyH3tfUTDAGo8EJoyYrC9im0S3Hq9xspdVmF15IL7AePz9Vgcg1P5zIpq9LLSQ04WjmiFPRdvyEQ5pqH+kkacMh9cAFQMsUd3OtbfTwz/X4JaU94vU4ldFqHvNlk1efPQap+CWAgilKJ26FKphQqD9eED0HLF4GVi9jQQa6CsIEVTkLF7BGTZmrktZ4a9xuqO0fyO9ybcWCfECdQeKFrVSamVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYzyouBhvSkLd/0cveHWYurgjTNwb58ZV0Dxcsp0kf4=;
 b=CObGXOKY8i9WgWYnZANS7Bao1Tja5yx3rr5PSLj6t4OUvZzqzlphISADd/xfFqhv7f+2GpPQdhvxb0XQxb/Plk4Fe5D0GO65XeM+1F9T3KohXfusHmYXrojuor6l4rDMRX7zLZ2QKjMl7IJDMm0yxHK+4ltVy95RdVzEa3gnVyiUpZRaui23UHIqf1Mq+RqtsexX1BPhGQurkTmxBQANxoWp6p8u94+kbKN+hyE8JYFkC6UTxRNC9OigIW/Xl8XBLSKERY6JckfYm4lbmm7iRnUNcH95Fst9+7GjrFcCnsDtHJx1zxHhILBz4IXcWaOXoHz1UUXfzLG6/Qy+viTWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYzyouBhvSkLd/0cveHWYurgjTNwb58ZV0Dxcsp0kf4=;
 b=QcYHV9ljij7SCp4elXmosms5aMnqs9JVBC3GWYLy+kLMrhmJjioyd2HRq6FlbXjGZvgH1x8BypNegKlookYVSpLgkN6DutZJ7vQ5EBsX0o4pw+o8nSVBwnJ6cg74NA7qeZQZytf7OsQhhyeSDJwE2u02q7aXs0CngCygWzfFeew=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2344.namprd04.prod.outlook.com (2603:10b6:100:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 09:45:25 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 09:45:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: Re: [PATCH] blkzone: add open/close/finish commands
Thread-Topic: [PATCH] blkzone: add open/close/finish commands
Thread-Index: AQHWAZ1WzCN/h8LMykOLuwJwjmoeYw==
Date:   Tue, 24 Mar 2020 09:45:25 +0000
Message-ID: <CO2PR04MB23435FDC9F9E3689CB663CB3E7F10@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324053018.18878-1-damien.lemoal@wdc.com>
 <20200324090622.GA5373@gsv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd4ca7ef-38a6-498e-2381-08d7cfd8140c
x-ms-traffictypediagnostic: CO2PR04MB2344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB234427E35CBA7318B9C5106BE7F10@CO2PR04MB2344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(66946007)(6506007)(66556008)(91956017)(5660300002)(33656002)(478600001)(52536014)(76116006)(81166006)(64756008)(186003)(66476007)(71200400001)(66446008)(26005)(53546011)(81156014)(8676002)(8936002)(6636002)(316002)(2906002)(54906003)(9686003)(55016002)(6862004)(4326008)(86362001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2344;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27Ea9a3ypQgSGqQbDGy0C3k9qxGbhjbmz3JfF5iQN9FVqyCvMvV0bb+ubjTd3zH6JVFCI2+T5tqPQajAr2b65Ra8FDaPhlNCHNg9BSzxTOKaU5dK8f/9OMfjjmyipBe0PwIwQjp5A8mWQ6XT4TffETqL5K7D82lTZMnkr25TFOEztp8u6d9TJWVZKA/TV5VB+TpSEUkyRZgs1UdZ/p6c1h+uldxXUozqvt/wev2tlhVsVVWNg6wi3y0dcBzpBTzgRU0QPAjKbRvRBCDv+DzLBR7/4vXRQr7DF3glcjjfrEv8TkrS5jdHT7GlO6zPeulYOalkYCIEAIrrgL8ZQr8xO1J5avO6IoRaJNeU++O62MDr3eyeMKsQ1XNPMdeKRkidWatst4zpBCeB8Dg9FaVWUNnzN9G3KJWR2PFih5zG3sQjGMd5T7JXh457A04ZjR7R
x-ms-exchange-antispam-messagedata: WhuS4f25SoIQ7MMqT3egEa3mLZfV074uJk89/fB6ex3IcAjXOGx9rH3armtTq9mw22qAJPBJ0tLS7tG0Izsj5m238irxw1HCqS455NSWM/NKRvAD85I56nck1WsVm/V5wbsBxY0A6k6bjUMaG/xQrg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ca7ef-38a6-498e-2381-08d7cfd8140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 09:45:25.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mrWV6pwWFOZtFLoSiJx9h3bQ5Mzs5qU71G9bYWRNvBLKWqA5qg8IEmNrAEK58U61z4nvtggNfY64o3Qef0hag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2344
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020/03/24 18:06, Hans Holmberg wrote:=0A=
> On Tue, Mar 24, 2020 at 02:30:18PM +0900, Damien Le Moal wrote:=0A=
>> From: Aravind Ramesh <Aravind.Ramesh@wdc.com>=0A=
>>=0A=
>> Introduce blkzone open, close and finish commands, issuing BLKOPENZONE,=
=0A=
>> BLKCLOSEZONE and BLKFINISHZONE ioctl commands to open, close or finish=
=0A=
>> a range of zones of a zoned block device.=0A=
>>=0A=
>> Since these three commands are similar to the existing zone reset=0A=
>> command, the existing zone reset command implementation is changed into=
=0A=
>> the generic blkzone_action() internal handler function for processing=0A=
>> all zone actions.=0A=
>>=0A=
>> The BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl commands codes are=
=0A=
>> defined in linux/blkzoned.h starting with kernel version 5.5. To ensure=
=0A=
>> that the blkzone utility compiles even with older blkzoned.h kernel=0A=
>> header versions, these ioctl commands are internally defined if the=0A=
>> blkzoned.h header definition is not present. Execution of these commands=
=0A=
>> on kernels older than 5.5 will result in a -ENOTTY error (missing=0A=
>> ioctl).=0A=
>>=0A=
>> Signed-off-by: Aravind Ramesh <Aravind.Ramesh@wdc.com>=0A=
>> Tested-by: Hans Holmnerg <Hans.Holmberg@wdc.com>=0A=
> =0A=
> I should be old enough to spell my name right by now.=0A=
> =0A=
> Tested-by: Hans Holmberg <Hans.Holmberg@wdc.com>=0A=
=0A=
Oops. I copy pasted and did not notice your typo :)=0A=
=0A=
> =0A=
> =0A=
> =0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  sys-utils/blkzone.8 | 27 +++++++++++++++--=0A=
>>  sys-utils/blkzone.c | 74 ++++++++++++++++++++++++++++++++++++++++-----=
=0A=
>>  2 files changed, 91 insertions(+), 10 deletions(-)=0A=
>>=0A=
>> diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8=0A=
>> index 83d3dd7ce..f50e3f5df 100644=0A=
>> --- a/sys-utils/blkzone.8=0A=
>> +++ b/sys-utils/blkzone.8=0A=
>> @@ -55,10 +55,31 @@ x?:Reserved conditions (should not be reported)=0A=
>>  The command \fBblkzone reset\fP is used to reset one or more zones. Unl=
ike=0A=
>>  .BR sg_reset_wp (8),=0A=
>>  this command operates from the block layer and can reset a range of zon=
es.=0A=
>> +=0A=
>> +.SS open=0A=
>> +The command \fBblkzone open\fP is used to explicitly open one or more z=
ones.=0A=
>> +Unlike=0A=
>> +.BR sg_zone (8),=0A=
>> +open action, this command operates from the block layer and can open a =
range=0A=
>> +of zones.=0A=
>> +=0A=
>> +.SS close=0A=
>> +The command \fBblkzone close\fP is used to close one or more zones. Unl=
ike=0A=
>> +.BR sg_zone (8),=0A=
>> +close action, this command operates from the block layer and can close =
a range=0A=
>> +of zones.=0A=
>> +=0A=
>> +.SS finish=0A=
>> +The command \fBblkzone finish\fP is used to finish (transition to full =
condition)=0A=
>> +one or more zones. Unlike=0A=
>> +.BR sg_zone (8),=0A=
>> +finish action, this command operates from the block layer and can finis=
h a range=0A=
>> +of zones.=0A=
>> +=0A=
>>  .PP=0A=
>> -By default, the command will operate from the zone at device=0A=
>> -sector 0 and reset all zones. Options may be used to modify this behavi=
or=0A=
>> -as well as specify the operation to be performed on the zone, as explai=
ned below.=0A=
>> +By default, the reset, open, close and finish commands will operate fro=
m the zone=0A=
>> +at device sector 0 and operate on all zones. Options may be used to mod=
ify this=0A=
>> +behavior as explained below.=0A=
>>  =0A=
>>  .SH OPTIONS=0A=
>>  The=0A=
>> diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c=0A=
>> index 715f03fef..b862aa67d 100644=0A=
>> --- a/sys-utils/blkzone.c=0A=
>> +++ b/sys-utils/blkzone.c=0A=
>> @@ -44,10 +44,23 @@=0A=
>>  #include "sysfs.h"=0A=
>>  #include "optutils.h"=0A=
>>  =0A=
>> +/*=0A=
>> + * These ioctls are defined in linux/blkzoned.h starting with kernel 5.=
5.=0A=
>> + */=0A=
>> +#ifndef BLKOPENZONE=0A=
>> +#define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>> +#endif=0A=
>> +#ifndef BLKCLOSEZONE=0A=
>> +#define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>> +#endif=0A=
>> +#ifndef BLKFINISHZONE=0A=
>> +#define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>> +#endif=0A=
>> +=0A=
>>  struct blkzone_control;=0A=
>>  =0A=
>>  static int blkzone_report(struct blkzone_control *ctl);=0A=
>> -static int blkzone_reset(struct blkzone_control *ctl);=0A=
>> +static int blkzone_action(struct blkzone_control *ctl);=0A=
>>  =0A=
>>  struct blkzone_command {=0A=
>>  	const char *name;=0A=
>> @@ -71,9 +84,28 @@ struct blkzone_control {=0A=
>>  =0A=
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
>>  =0A=
>> +static enum blkzone_action command_action(const struct blkzone_command =
*command)=0A=
>> +{=0A=
>> +	return command - &commands[0];=0A=
>> +}=0A=
>> +=0A=
>>  static const struct blkzone_command *name_to_command(const char *name)=
=0A=
>>  {=0A=
>>  	size_t i;=0A=
>> @@ -246,15 +278,41 @@ static int blkzone_report(struct blkzone_control *=
ctl)=0A=
>>  }=0A=
>>  =0A=
>>  /*=0A=
>> - * blkzone reset=0A=
>> + * blkzone reset, open, close, and finish.=0A=
>>   */=0A=
>> -static int blkzone_reset(struct blkzone_control *ctl)=0A=
>> +=0A=
>> +static int blkzone_action(struct blkzone_control *ctl)=0A=
>>  {=0A=
>>  	struct blk_zone_range za =3D { .sector =3D 0 };=0A=
>>  	unsigned long zonesize;=0A=
>> +	unsigned long ioctl_cmd;=0A=
>> +	const char *ioctl_name;=0A=
>>  	uint64_t zlen;=0A=
>>  	int fd;=0A=
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
>> +	}=0A=
>> +=0A=
>>  	zonesize =3D blkdev_chunk_sectors(ctl->devname);=0A=
>>  	if (!zonesize)=0A=
>>  		errx(EXIT_FAILURE, _("%s: unable to determine zone size"), ctl->devna=
me);=0A=
>> @@ -288,11 +346,13 @@ static int blkzone_reset(struct blkzone_control *c=
tl)=0A=
>>  	za.sector =3D ctl->offset;=0A=
>>  	za.nr_sectors =3D zlen;=0A=
>>  =0A=
>> -	if (ioctl(fd, BLKRESETZONE, &za) =3D=3D -1)=0A=
>> -		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), ctl->devname);=
=0A=
>> +	if (ioctl(fd, ioctl_cmd, &za) =3D=3D -1)=0A=
>> +		err(EXIT_FAILURE, _("%s: %s ioctl failed"),=0A=
>> +		    ctl->devname, ioctl_name);=0A=
>>  	else if (ctl->verbose)=0A=
>> -		printf(_("%s: successfully reset in range from %" PRIu64 ", to %" PRI=
u64),=0A=
>> +		printf(_("%s: successfully %s zones in range from %" PRIu64 ", to %" =
PRIu64),=0A=
>>  			ctl->devname,=0A=
>> +			ctl->command->name,=0A=
>>  			ctl->offset,=0A=
>>  			ctl->offset + zlen);=0A=
> =0A=
> Nice, but the verbose output looks wierd:=0A=
> =0A=
> root@qemu:~/repos/util-linux# ./blkzone  close -v -o 0 -c 1 /dev/nvme0n1 =
=0A=
> /dev/nvme0n1: successfully close zones in range from 0, to 524288root@qem=
u:~/repos/util-linux#=0A=
> =0A=
> Something like this instead?=0A=
> =0A=
> 		printf(_("%s: successfull %s of zones in range from %" PRIu64 ", to %" =
PRIu64 "\n"),=0A=
=0A=
OK. Will send a v2.=0A=
=0A=
> =0A=
> Otherwise:=0A=
> =0A=
> Reviewed-by: Hans Holmberg <Hans.Holmberg@wdc.com>=0A=
> =0A=
>>  	close(fd);=0A=
>> -- =0A=
>> 2.25.1=0A=
>>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
