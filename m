Return-Path: <SRS0=M7Df=5J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52424C41621
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1004A205ED
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gZdunKwP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EOatEqjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCXJG3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:06:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49091 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJG3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2020 05:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585040795; x=1616576795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a1f24bHcq5zpQZR0pFFxDsohSogLq1q1gVIFN1kly2A=;
  b=gZdunKwPzdVwgY9j4CNRfaOGUsJjZn7zFS5mnxNNSl/LKwK1G4g+IYBy
   tzKyTQzmlOtcvUWa9ViczXAtxo+35cW8LnpnybdiVNC/7dTqJ47QZaEqe
   8nJvtSScOhHEto14Lx010XpDd/vAF4Ds4XKV5Mb/a9lzVcez5zUD0lOId
   XkPA4rT0B4pzhXsOHgYM19JaaHxV82HLvcVgKHMD/in4793L+7nFbSA4/
   l2kr1NMVB789NYYQeY6mxtcFguN9UN//HoKNTi5OD3RNpXIVFo6NX9LPb
   9RqNsplzBgKHrQ2vGtMP2390xGmEF2ZDVXFuVSP2acIU8sy5O2/Km/bGg
   Q==;
IronPort-SDR: cganKq7ndczpvV6X9cf/A6icE6uicPuVDLef3cu2vjXIGQc1oihUW0/9DHoonmD0w2G5Je0iS5
 vh0OdeMzNMEqDOYG0yQvZ5292rqpBZfCaU69S0CAKtdcI0yaT32IHdE5rj7Xtc87ZlDb1WEISU
 21yyb8KXwTbETx58UoMaUbHtS9o/4Aw+Xn+EqvFLOsmmPxq0WOCb/SXC8bTi5vvmKHDPjfkljY
 qeqU180xdaqO7fPRojXaci1hTbvUxYS6EBRvde2I+59EAa+JmZTfzwkfh1opujiWfwsfZH4ZIq
 5tw=
X-IronPort-AV: E=Sophos;i="5.72,299,1580745600"; 
   d="scan'208";a="235550236"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 17:06:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5EV3vnZNKZIBEz7GHM6G1Rz5Fu6hr+dVmomuaM/W+PdAmPjAKFD52a+CUJ86k6cS6oC9q3PC+OVIwOdsgtdLMoGKs4t+pVLOabT4sD9GP3krSSYzAZXVqNKd8v9NxRhS84B3AF2sTI88gxWPnYFrrgtexgG0X2dY3ra151emgp0FV6lGu1aAVjJMv4YnqdDpYky6IaBDuO6k6YKe+e2fg/kV4SHbQ7X46YztcAN/mEaEKW8PNd+DZ+wHc5Y84R2VhEAnJMNaQ1mdbIiGzJvbBCIeRsme5yazpEkfbwTnT11HDxcwIfFgaaED/VouHe3pwwfIsE/LtrPMSQP1ekNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlAOAyPaiXq+5qOoaJMj4bAVomCWUGiu5R6bRYjS8/E=;
 b=S/2saQfHP8nNpQErzcqVTrQREqWGqlpl9obc0aVK1DOsBO2D2p+ZXzKnbB8eLx449cXzUkqylPKjdS8svcwxbFcWTmUAwwEtWQLvpvU7hEfYta2LoCrJYGdoG2oV7ZKFd6k91mQUOgJHyXW4vlgA12IjaKCK5cWl5bvKgg9/VFN7BuQZfFigCqgum8pZdqkCX9WcvLTBfYJKau2AT2jdG0g7Z+myWaIJTvXpzzFGAhDBPPbyVSbULDF7S9M7W7C8AmJhLQ81PmzIHt5UYm/xgekkCnkU6KPN2VEzy4b1vgFZNu7j0gAyyvfO0jUxud6mdvWQ6bsyao8RRa6+Ntbh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlAOAyPaiXq+5qOoaJMj4bAVomCWUGiu5R6bRYjS8/E=;
 b=EOatEqjTNpGx1Kf60VsHgDrBHOiicJsbbRNnslujNIuSkuaser0+6YLy+F2Hvvvi+frTbsD3sGmHFjVF4hFwIAFD0xZBZt1b87Q5y9o/3fIoDN8DqXJwjrHmLlyF0+TkE0hwXhhBFucGV8CR9K4f21kBvNEKoTejH312ePwpE7w=
Received: from MN2PR04MB5520.namprd04.prod.outlook.com (2603:10b6:208:d7::11)
 by MN2PR04MB5807.namprd04.prod.outlook.com (2603:10b6:208:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 09:06:26 +0000
Received: from MN2PR04MB5520.namprd04.prod.outlook.com
 ([fe80::4d5f:5bab:1291:28bd]) by MN2PR04MB5520.namprd04.prod.outlook.com
 ([fe80::4d5f:5bab:1291:28bd%3]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 09:06:26 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: Re: [PATCH] blkzone: add open/close/finish commands
Thread-Topic: [PATCH] blkzone: add open/close/finish commands
Thread-Index: AQHWAZ1WzCN/h8LMykOLuwJwjmoeY6hXc78A
Date:   Tue, 24 Mar 2020 09:06:26 +0000
Message-ID: <20200324090622.GA5373@gsv>
References: <20200324053018.18878-1-damien.lemoal@wdc.com>
In-Reply-To: <20200324053018.18878-1-damien.lemoal@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hans.Holmberg@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e8fbe46-9b90-4df2-eb3a-08d7cfd2a21d
x-ms-traffictypediagnostic: MN2PR04MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB580789D5912A997869030F03EBF10@MN2PR04MB5807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(478600001)(81166006)(86362001)(33656002)(91956017)(76116006)(6506007)(66476007)(66556008)(9686003)(6512007)(6486002)(66946007)(5660300002)(6636002)(8676002)(81156014)(4326008)(66446008)(8936002)(2906002)(64756008)(71200400001)(54906003)(316002)(1076003)(186003)(6862004)(33716001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5807;H:MN2PR04MB5520.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e88qM6LNdVZeyagTnysZYwNuW9usOEZexYulqzuZCfcpwW/xZvWQZZyBwN1Q3TFJJEb2xGWTtCehhVDXC/2XbHmIkZf2MPP8Ng3P5kBiwlOoRDS/if2PFXLjKEhwJz1nk6YpdfaoIAy0725T8KHQDgegleYxd7W9kBUzq/ZdXcIVYYXwnzrzYME8hBIdrIkENrKCINczk9yqOp+cTC9U+bQdLkJWNYaurrVdiwvymKN8wMjoKO9sl6gxUn4RtIFor9Hf3IFm6OhBCwRQIC4lCbXn9h1F5i1Nrcbc/FmXHJMi+RsMmvv0SQlozRFi1HB3fNFy2e5ApCchwpY/K+uTR0pE9B545MWClfvUgXroGpqp300oWKvsmDyVzXKcKSEavUg5sDC/pWlZLdsddzS76yQBxEMa3zV7Ihg+5Jxgl6j157iY79IuHiqJvbhq37FO
x-ms-exchange-antispam-messagedata: eAJw6ZNHTadBDOrNQlyStGbPXr8I7sb6s/9psgd7k2CJ708QDbaUikaJMxooRUmsW0u8hyF5m8oey6RhZzW64JvNgyO1yIylj8MyVkSicUGfNAMRXWfGHcZRjgi7RJipLFcpV+QdzShAednI+/G+EA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBA9ED85FE7793488A1C05E8A362191D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8fbe46-9b90-4df2-eb3a-08d7cfd2a21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 09:06:26.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enaPdb696vt9bxXyo524jjCU8Xhv3gpkerqnmuMW3sUzsATL0s9iNmdzpR9PxvhC2LC1HX2zkoHGPHKW3cAjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5807
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Mar 24, 2020 at 02:30:18PM +0900, Damien Le Moal wrote:
> From: Aravind Ramesh <Aravind.Ramesh@wdc.com>
>=20
> Introduce blkzone open, close and finish commands, issuing BLKOPENZONE,
> BLKCLOSEZONE and BLKFINISHZONE ioctl commands to open, close or finish
> a range of zones of a zoned block device.
>=20
> Since these three commands are similar to the existing zone reset
> command, the existing zone reset command implementation is changed into
> the generic blkzone_action() internal handler function for processing
> all zone actions.
>=20
> The BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl commands codes are
> defined in linux/blkzoned.h starting with kernel version 5.5. To ensure
> that the blkzone utility compiles even with older blkzoned.h kernel
> header versions, these ioctl commands are internally defined if the
> blkzoned.h header definition is not present. Execution of these commands
> on kernels older than 5.5 will result in a -ENOTTY error (missing
> ioctl).
>=20
> Signed-off-by: Aravind Ramesh <Aravind.Ramesh@wdc.com>
> Tested-by: Hans Holmnerg <Hans.Holmberg@wdc.com>

I should be old enough to spell my name right by now.

Tested-by: Hans Holmberg <Hans.Holmberg@wdc.com>



> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  sys-utils/blkzone.8 | 27 +++++++++++++++--
>  sys-utils/blkzone.c | 74 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 91 insertions(+), 10 deletions(-)
>=20
> diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
> index 83d3dd7ce..f50e3f5df 100644
> --- a/sys-utils/blkzone.8
> +++ b/sys-utils/blkzone.8
> @@ -55,10 +55,31 @@ x?:Reserved conditions (should not be reported)
>  The command \fBblkzone reset\fP is used to reset one or more zones. Unli=
ke
>  .BR sg_reset_wp (8),
>  this command operates from the block layer and can reset a range of zone=
s.
> +
> +.SS open
> +The command \fBblkzone open\fP is used to explicitly open one or more zo=
nes.
> +Unlike
> +.BR sg_zone (8),
> +open action, this command operates from the block layer and can open a r=
ange
> +of zones.
> +
> +.SS close
> +The command \fBblkzone close\fP is used to close one or more zones. Unli=
ke
> +.BR sg_zone (8),
> +close action, this command operates from the block layer and can close a=
 range
> +of zones.
> +
> +.SS finish
> +The command \fBblkzone finish\fP is used to finish (transition to full c=
ondition)
> +one or more zones. Unlike
> +.BR sg_zone (8),
> +finish action, this command operates from the block layer and can finish=
 a range
> +of zones.
> +
>  .PP
> -By default, the command will operate from the zone at device
> -sector 0 and reset all zones. Options may be used to modify this behavio=
r
> -as well as specify the operation to be performed on the zone, as explain=
ed below.
> +By default, the reset, open, close and finish commands will operate from=
 the zone
> +at device sector 0 and operate on all zones. Options may be used to modi=
fy this
> +behavior as explained below.
> =20
>  .SH OPTIONS
>  The
> diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
> index 715f03fef..b862aa67d 100644
> --- a/sys-utils/blkzone.c
> +++ b/sys-utils/blkzone.c
> @@ -44,10 +44,23 @@
>  #include "sysfs.h"
>  #include "optutils.h"
> =20
> +/*
> + * These ioctls are defined in linux/blkzoned.h starting with kernel 5.5=
.
> + */
> +#ifndef BLKOPENZONE
> +#define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
> +#endif
> +#ifndef BLKCLOSEZONE
> +#define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
> +#endif
> +#ifndef BLKFINISHZONE
> +#define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
> +#endif
> +
>  struct blkzone_control;
> =20
>  static int blkzone_report(struct blkzone_control *ctl);
> -static int blkzone_reset(struct blkzone_control *ctl);
> +static int blkzone_action(struct blkzone_control *ctl);
> =20
>  struct blkzone_command {
>  	const char *name;
> @@ -71,9 +84,28 @@ struct blkzone_control {
> =20
>  static const struct blkzone_command commands[] =3D {
>  	{ "report",	blkzone_report, N_("Report zone information about the given=
 device") },
> -	{ "reset",	blkzone_reset,  N_("Reset a range of zones.") }
> +	{ "reset",	blkzone_action, N_("Reset a range of zones.") },
> +	{ "open",	blkzone_action, N_("Open a range of zones.") },
> +	{ "close",	blkzone_action, N_("Close a range of zones.") },
> +	{ "finish",	blkzone_action, N_("Set a range of zones to Full.") }
> +};
> +
> +/*
> + * The action values must match the command index in the command array.
> + */
> +enum blkzone_action {
> +	BLK_ZONE_NO_ACTION =3D 0,
> +	BLK_ZONE_RESET,
> +	BLK_ZONE_OPEN,
> +	BLK_ZONE_CLOSE,
> +	BLK_ZONE_FINISH,
>  };
> =20
> +static enum blkzone_action command_action(const struct blkzone_command *=
command)
> +{
> +	return command - &commands[0];
> +}
> +
>  static const struct blkzone_command *name_to_command(const char *name)
>  {
>  	size_t i;
> @@ -246,15 +278,41 @@ static int blkzone_report(struct blkzone_control *c=
tl)
>  }
> =20
>  /*
> - * blkzone reset
> + * blkzone reset, open, close, and finish.
>   */
> -static int blkzone_reset(struct blkzone_control *ctl)
> +
> +static int blkzone_action(struct blkzone_control *ctl)
>  {
>  	struct blk_zone_range za =3D { .sector =3D 0 };
>  	unsigned long zonesize;
> +	unsigned long ioctl_cmd;
> +	const char *ioctl_name;
>  	uint64_t zlen;
>  	int fd;
> =20
> +	switch (command_action(ctl->command)) {
> +	case BLK_ZONE_RESET:
> +		ioctl_cmd =3D BLKRESETZONE;
> +		ioctl_name =3D "BLKRESETZONE";
> +		break;
> +	case BLK_ZONE_OPEN:
> +		ioctl_cmd =3D BLKOPENZONE;
> +		ioctl_name =3D "BLKOPENZONE";
> +		break;
> +	case BLK_ZONE_CLOSE:
> +		ioctl_cmd =3D BLKCLOSEZONE;
> +		ioctl_name =3D "BLKCLOSEZONE";
> +		break;
> +	case BLK_ZONE_FINISH:
> +		ioctl_cmd =3D BLKFINISHZONE;
> +		ioctl_name =3D "BLKFINISHZONE";
> +		break;
> +	case BLK_ZONE_NO_ACTION:
> +		/* fallthrough */
> +	default:
> +		errx(EXIT_FAILURE, _("Invalid zone action"));
> +	}
> +
>  	zonesize =3D blkdev_chunk_sectors(ctl->devname);
>  	if (!zonesize)
>  		errx(EXIT_FAILURE, _("%s: unable to determine zone size"), ctl->devnam=
e);
> @@ -288,11 +346,13 @@ static int blkzone_reset(struct blkzone_control *ct=
l)
>  	za.sector =3D ctl->offset;
>  	za.nr_sectors =3D zlen;
> =20
> -	if (ioctl(fd, BLKRESETZONE, &za) =3D=3D -1)
> -		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), ctl->devname);
> +	if (ioctl(fd, ioctl_cmd, &za) =3D=3D -1)
> +		err(EXIT_FAILURE, _("%s: %s ioctl failed"),
> +		    ctl->devname, ioctl_name);
>  	else if (ctl->verbose)
> -		printf(_("%s: successfully reset in range from %" PRIu64 ", to %" PRIu=
64),
> +		printf(_("%s: successfully %s zones in range from %" PRIu64 ", to %" P=
RIu64),
>  			ctl->devname,
> +			ctl->command->name,
>  			ctl->offset,
>  			ctl->offset + zlen);

Nice, but the verbose output looks wierd:

root@qemu:~/repos/util-linux# ./blkzone  close -v -o 0 -c 1 /dev/nvme0n1=20
/dev/nvme0n1: successfully close zones in range from 0, to 524288root@qemu:=
~/repos/util-linux#

Something like this instead?

		printf(_("%s: successfull %s of zones in range from %" PRIu64 ", to %" PR=
Iu64 "\n"),

Otherwise:

Reviewed-by: Hans Holmberg <Hans.Holmberg@wdc.com>

>  	close(fd);
> --=20
> 2.25.1
> =
