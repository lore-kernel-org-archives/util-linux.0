Return-Path: <SRS0=vUEm=DJ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A9C4363D
	for <util-linux@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F5420665
	for <util-linux@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="YirR8pS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbgJBMXS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:23:18 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:15182 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387918AbgJBMXC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 2 Oct 2020 08:23:02 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 08:22:59 EDT
IronPort-SDR: 0BgaEGo1CuQr7Xm/q1AW/OnWWXyRPO6CM1Rld+Vm416FPCGZ1AepcEtJnpSZ9DoUMqbC7PiHDu
 v4jXaOYXDoD8vLGXlN8o0ON1Ce1qdNdEbJjnD3R1AmQawOTw+y7DsUzDnfc51YzCIw/7+g7kXn
 edeL4OsDY3hTNfNoPgz8IbS8euDpLJIg6y3B1BdyECSY+Z/V4r1/psiY12xxV5ru5i62MSmBKx
 +2QeATMej294L/oC3s0nwAjUe50fFGWiNpV/yPk5HgH1a8QfXnSGLYBdb1Whyy6er+1PtFlZjH
 0gE=
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="18986416"
X-IronPort-AV: E=Sophos;i="5.77,327,1596466800"; 
   d="scan'208";a="18986416"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 21:15:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc/qHexw2Kfn/miU77HqX4i58AGHhzCDOtgQvXoGqG+lkpkQhyBiYqQFmGHKU1DjAYBgqy6WQhloq6z8BBHC34WEIisKnjcqJPDyr5sHe1FqSfBVPSuM8C3GuMTn8edFNONHDoqWMyqrk7E/fg5Gg/09++SBjkh66zU+gZDg6/MZM1oAhlbtsxEke3nOKJIbPO9DKtRHWGcLP6XHbkcKww7wGm97YcaoA/falqsAWfYtziquwjPMCdydgUKZ9lsGzmEATLFgSEQJ8FIiZvtHOalZHwYZnnGN6+QRqH1jpmA9k2gmxNGoIRE4HJzobhuDNQsES/10J2soQXRiSGVvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siCEKySCzaQFpSGio12lm47JXXbrodJB2YgnVufB9pM=;
 b=Js//VQ+YpbBR2HqNBaYOKdwY0dq0e42FoF4hmHoBPdDeq0s8FXz/QDYq13Ua/RYJgrWZEDJnvjB+Xse9B2M3YgZVniXqqYxpiDi1aBdFQWWJLO7tDU6Jr4IxL7cgjjZRzz37ksEIOis0xPo6E/lOPYt358TiPVBdLWLBgyNEr/bKBl5339RAqtRMD3XtVWhDwhCjFazMDpYqGs8R/9KGOPvnscCtgyhcgMbynCr9tnVJupEU3zzRJjo0MFLm/0eMkwGKMJpK92mxGS0XL1gmkkPlRjiUFiAhqWPYfB3Qvqy2cJ+Q6yFH7frAb+T5CS8TmG8I6I3P/IQGYTICQWbQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siCEKySCzaQFpSGio12lm47JXXbrodJB2YgnVufB9pM=;
 b=YirR8pS7LP9x/DovUG0xAC17iprOcrc35j9AdNwtvrqijkw8VSFbKQr/aHbbeOARd7T6tVnr/iYZeAGhyHaLHC13biAhYkwCGHv7Ki31Z4Beo3yO8BufKzTz6o3P59qXSqZirzt3VX6bmsEpaIT/j2G1e7uIeboVYr1C4fFrUGI=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB4198.jpnprd01.prod.outlook.com (2603:1096:604:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Fri, 2 Oct
 2020 12:15:39 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::b999:bd99:62d6:b991]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::b999:bd99:62d6:b991%5]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 12:15:39 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Karel Zak <kzak@redhat.com>, Jeffrey Bastian <jbastian@redhat.com>,
        'Masayoshi Mizuma' <msys.mizuma@gmail.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: RE: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Thread-Topic: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Thread-Index: AQHWlXxzMr9CUhkGLEWKe3Exv+F8t6l/cJeAgAHUv4CAADFBgIAAEzyAgAAzfQCAAFcagIACKZ4g
Date:   Fri, 2 Oct 2020 12:15:39 +0000
Message-ID: <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
 <20201001030519.6d65sqhd54oxmlic@gabell>
In-Reply-To: <20201001030519.6d65sqhd54oxmlic@gabell>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 7fb49ac1ddb642ef8c349042e229d6ae
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64da4d2f-8cb5-44b8-14e5-08d866cce01c
x-ms-traffictypediagnostic: OSBPR01MB4198:
x-microsoft-antispam-prvs: <OSBPR01MB41986DBB0FD0612A805E850DF7310@OSBPR01MB4198.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1D+eGmFJ97+5/9/+jsJ/biKNGL0zmGxMjSA9dk4sjamOTL7atVqCFzfjBpX6NPjBuijd6KS9iZy0Mlteeox6G8ZemR+Ujr2BnfuoUjywrPdsy6w2f2LjMnDaiKMx4oUf/aRCrkW+sjQbLA2MHYykXpyxIIQ5vagxJFjSSDsVfFfIrUeczslzvbUFE+ygAAmNwXIn8HLE9Sl6qCRwkSMW3pv/SJZasxS2QJzdD67qNnt0Esio4Z4d1ttuEzr2OVPxAH1a5p+coX57xHEaVkt5rhlx+OARaEEgZGOuWH752OCxoIlpoorXZ3ky6tEOH8bqidthBs94fG2FqVSgNHt0zhDPPKMHBgqT7DU1YhbrftpK+OJuz4SOOA/p14779BUF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(76116006)(8936002)(9686003)(2906002)(5660300002)(110136005)(316002)(7696005)(8676002)(4326008)(66476007)(66556008)(66446008)(66946007)(64756008)(26005)(6506007)(53546011)(71200400001)(83380400001)(186003)(55016002)(33656002)(478600001)(52536014)(86362001)(85182001)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4RE5/CjRyLHsYcUHpV8CSHtem49mBSbRpm11XZxq5wTUf9JYOwCBY02bJdE5JsRrHLTMLpEoTKQurpof0YeVvd/xZzmVs3De1vAwOlbuDjgqfTP9ZNJQ5jwoEa8RqEoRvcP7Ny0DCopX7lckhTpN+hMMV81Sp4t1BVpKEBOKG3p/hHFuTMp+GoNr8WRU1uZFR8z6Jvbxg1T3cQLolhW885wS9RXZhcB6CkuNUuOxpjI0KgGQCGCDhbzHxPKVZQxybpOi434rvMwrHNC7HnOPe363lRD+2oMqbkPCEXTpiP2LXaENviCxQOgbypq8h1kaa19t+vtEbrJ6J9pSMJv50PbFbLLr2DxJiHS5h47i9LZ44zvjMMOMEPFhs/lXfYtx9sV7HcInhcRyKZ1fTVwQGp7mwZ6Y9tEMAKKNm0xC6vuq07OYsGo56JkMz8fWzxim5MH0L1hDCI3Ywb3fp2SrgenDMlz2ky0SHIEY0Ma3sbQx6Xm46/92mdo28k7nB3ohArCCzvQrGjqhYDaK/SZz++08tD6dVl2mAkc/Br+hZLvrta8TeO0Jolpw5vJ92a5TU2qvoG+92PRKz6khFXQ18tEgo39DxOhr/UFvD50bagYWtvaPSU37AtKJddOLM29n2JmF4h1FJDXZDWHiivFUTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64da4d2f-8cb5-44b8-14e5-08d866cce01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 12:15:39.0794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfZHsY8U97hZIy9/OxpLsCz/tbhRS8HPBF41iL10ApF3ypcQdpMapbeAs4sZjwSWvMT/pKaIL6NaOAQuhI7LYy79GAPHdMn6a3Glyqg4Jlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4198
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel, Jeffrey, Mizuma-san

Sorry for the late reply.

> From: Masayoshi Mizuma <msys.mizuma@gmail.com>
> Sent: Thursday, October 1, 2020 12:05 PM
> To: Jeffrey Bastian <jbastian@redhat.com>
> Cc: Karel Zak <kzak@redhat.com>; Nakamura, Shunsuke
> <nakamura.shun@fujitsu.com>; util-linux@vger.kernel.org; Nakamura,
> Shunsuke <nakamura.shun@fujitsu.com>
> Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
>=20
> On Wed, Sep 30, 2020 at 04:53:34PM -0500, Jeffrey Bastian wrote:
> > On Wed, Sep 30, 2020 at 02:49:17PM -0400, Masayoshi Mizuma wrote:
> > > Hi Jeffrey and Karel,
> > >
> > > On Wed, Sep 30, 2020 at 07:40:27PM +0200, Karel Zak wrote:
> > > > On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
> > > > > On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
> > > > > > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura
> wrote:
> > > > > > >  sys-utils/lscpu-arm.c | 6 ++++++
> > > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > Applied, thanks.
> > > > >
> > > > >
> > > > > With the other ARM patch applied ("use SMBIOS tables on ARM for
> > > > > lscpu"), the output changes on an FX700 system:
> > > > >
> > > > > [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Step=
ping
> > > > > Vendor ID:                       FUJITSU
> > > > > Model:                           0
> > > > > Model name:                      461F0010
> > > > > Stepping:                        0x1
> > > > >
> > > > >
> > > > > The values here come from the SMBIOS Type 4 record:
> > > > >
> > > > > [root@fujitsu-fx700 ~]# strings
> > > > > /sys/firmware/dmi/entries/4-0/raw
> > > > > CPU1
> > > > > FUJITSU
> > > > > 461F0010
> > > > > 8K083MH14
> > > > >
> > > > >
> > > > > This FX700 system has firmware revision 1.4.0 (Jun 17 2020).
> > > >
> > > > hmm... 461F0010 does not seem user-friendly, "A64FX" seems better.
> > > >
> > > > Shunsuke, what about to update the firmware strings? ;-) (as
> > > > Jeffrey suggested in RH bugzilla)
> > > >
> > > > The another possibility is to exclude some vendors and do not use
> > > > SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
> > > > SMBIOS based solution is more elegant and ready for new CPU types
> > > > than in-lscpu hard coded tables.
> > >
> > > According to SMBIOS specification, the description of Processor
> > > Version (Type4) is "String number describing the Processor". It
> > > shows the version number of the processor, not a model, like as A64FX=
 and
> Cortex-A72 and so on.
> > > So I think we should not use the Processor Version as the modelname..=
.
> >
> > Hello Masa,
> >
> > I think I see your confusion because I was also confused by the
> > wording of the SMBIOS spec.  In this case, "String number" means the
> > number of the string appended to the Type 4 record, not a version
> > number of the processor.
> >
> > See section 6.1.3, "Text strings", of the SMBIOS spec (version 3.4.0).
> >
> > For Type 4, there can be up to 6 strings appended to the table:
> >   Offset 0x04: Socket Designation
> >   Offset 0x07: Processor Manufacturer
> >   Offset 0x10: Processor Version
> >   Offset 0x20: Serial Number
> >   Offset 0x21: Asset Tag
> >   Offset 0x22: Part Number
> >
> > Each string is optional.  If the byte at one of the above offsets is
> > 0, that means the string is not included.  If the byte is non-0, it
> > means refer to the first or second or third (or so on) string appended
> > to the table.  It's this non-0 number that the spec calls "String numbe=
r".
>=20
> Ohh... thank you for pointing it out! I misunderstood about "String numbe=
r".
>=20
> >
> > Example:
> >
> > A Type 4 record that only defined Processor Manufacturer and Processor
> > Version would therefore look like:
> >   Offset 0x04: 0x00
> >   Offset 0x07: 0x01
> >   Offset 0x10: 0x02
> >   Offset 0x20: 0x00
> >   Offset 0x21: 0x00
> >   Offset 0x22: 0x00
> >
> > The text of each string is free form.  Most vendors have chosen to use
> > Processor Manufacturer as the CPU vendor, and Processor Version as a
> > text description of the CPU.
> >
> > Some examples from existing servers (copy/paste from the other thread):
> >
> > [root@hp-m400 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> > Vendor ID:                       AppliedMicro
> > Model:                           1
> > Model name:                      X-Gene
> > Stepping:                        0x0
> >
> > [root@lenovo-hr330a ~]# ./lscpu | grep -i -e vendor -e model -e steppin=
g
> > Vendor ID:                       Ampere(TM)
> > Model:                           2
> > Model name:                      eMAG
> > Stepping:                        0x3
> >
> > [root@hpe-apollo-70 ~]# ./lscpu | grep -i -e vendor -e model -e steppin=
g
> > Vendor ID:                       Cavium Inc.
> > Model:                           1
> > Model name:                      Cavium ThunderX2(R) CPU CN9980 v2.1
> @ 2.20GHz
> > Stepping:                        0x1
> >
> >
> > Therefore, I believe you are free to change the string "461F0010" to
> > "A64FX" in the SMBIOS Type 4 record of the FX700 and FX1000 servers'
> > firmware.
>=20
> Thanks, I got the most vendors put their CPU model name to Processor Vers=
ion,
> however it depends on the vendor, right..? That's because the SMBIOS
> specification says just "String number describing the Processor", so vend=
ors can
> put any strings to describe the own processor, like "461F0010"...
>=20
> But I don't have strong opinion about the Processor Version of A64FX, let=
's wait
> for Shunsuke's comment.

I checked with the person in charge.

When the A64FX was designed, there was ambiguity in the Processer Version s=
pecification.=20
Therefore we defined it as "461F0010".
Considering the maintenance cost to keep up with the latest CPU, I agree to=
 get information
from the SMBIOS table rather than the hard code.
However, as Mizuma-san said, since "Processer Version" specs depends on the=
 interpretation
of the vendor, the expected value is not output in the processor group exis=
ting in the current table
as in the case of the A64FX.

Given these, I propose referring to the SMBIOS table if the processor versi=
on does not exist in
the current table. Can you give me your opinion?

Best Regards
>=20
> Thanks,
> Masa
