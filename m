Received: from us-smtp-delivery-109.mimecast.com (us-smtp-delivery-109.mimecast.com [170.10.133.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DACA6B
	for <util-linux@vger.kernel.org>; Sun, 22 Mar 2026 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774184234; cv=none; b=qArdG3huS1FmJCTnU5dQVp2K502i7jk03pPE/oIRNVg/djIssdf9R42Lb5x3b0WMUdRRjvJFVOh4zJDzFR1oB+IXvGa0JfVMdJJQ9aHy5yIcJ12381OuibHUaMM2/xtMbICPoOvqNAuhpWpwgKhXt8V6tb0n44H8NaMfsbyMACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774184234; c=relaxed/simple;
	bh=frm5QBZ8dILSUE0RTT2qiLITugn7FYfLmJnBRa4PEhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=F3Tk3iQTitpP0MdTvcg4c7+CGeEc6aAcsnVwoY2wFuGbLsLp+qepJhWDIC3clKh0RcNkbb98quLLhOu07/B0dmddFMO9sfaa728CU6pdR8mnynjN+4eJzOcqOoF1IW4n0RzQU4bSOlg5MzyXwPfC/sBhwFFXitYEVHB5RoMf2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu; spf=pass smtp.mailfrom=wgu.edu; dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b=Y5pCPwEn; arc=none smtp.client-ip=170.10.133.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wgu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b="Y5pCPwEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgu.edu; s=mimecast20181213;
	t=1774184232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frm5QBZ8dILSUE0RTT2qiLITugn7FYfLmJnBRa4PEhw=;
	b=Y5pCPwEnxKS0KoUzmisEW7cY3HPqEa9DI0BP3D2yQMcWUt4jkk2AVWxgZQco7YmrHZhVPd
	05WXC72NMoX2RKZlG284wgttWu6swDzxRqboXlxifMjDYQYz4LeHmJoyA3F4FvsWcG/Dt0
	ydl40p/kgj1w4SLMoMlNO12+AfihQhAUyxzeagNwa4ADhaWAt+AIAuyw/CFGx3umQ7chgM
	1UTFb/g21KqMADoQkvWZuW5UzUF5oRVWbxMG/owmCrNngRvgPkZqzgA0RmnBc47vW3hcVl
	VZVqXaxsgC6CTH8FKj+z6KOoPpeVvJ9lklO7BO46rEUX7mJUOGYtT7lekrAKeA==
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023126.outbound.protection.outlook.com
 [40.93.201.126]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-lSS5CH9jM7iCCPJXA9gGHQ-1; Sun, 22 Mar 2026 08:57:09 -0400
X-MC-Unique: lSS5CH9jM7iCCPJXA9gGHQ-1
X-Mimecast-MFC-AGG-ID: lSS5CH9jM7iCCPJXA9gGHQ_1774184228
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:3b8::14)
 by EA2P220MB1458.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:25a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Sun, 22 Mar
 2026 12:57:04 +0000
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa]) by SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 12:57:04 +0000
From: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
To: Chris Hofstaedtler <zeha@debian.org>, Karel Zak <kzak@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, Helmut Grohne
	<helmut@subdivi.de>
Subject: Re: unshare regression in 2.42-rc1
Thread-Topic: unshare regression in 2.42-rc1
Thread-Index: AQHcufG1rmTmn9s91EOfxJ0gLaXqm7W6fuOj
Date: Sun, 22 Mar 2026 12:57:03 +0000
Message-ID: <SJ0P220MB05417CC33D6BA305A9CEE320E94AA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <ab_SfC1JDOhNmg6D@zeha.at>
In-Reply-To: <ab_SfC1JDOhNmg6D@zeha.at>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P220MB0541:EE_|EA2P220MB1458:EE_
x-ms-office365-filtering-correlation-id: f20b0dcd-2079-4233-6818-08de881283fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|786006|366016|1800799024|10070799003|376014|38070700021|7053199007|22082099003|56012099003|18002099003
x-microsoft-antispam-message-info: 57KBxGtw/EhPwcEBrYIylrkDLhUCM815DD72FVkeXDBY/tV/T49Co38kxJCHLedFz3mS7gcJOrI33yphoBw/9oa+g9AOO0o+MikaYvjhrl3qxl1V8loHb5iu74OtCIgoQW4UVoxo4pQ5yhC9y6Y/Dg0Ug/z1DjvFPojjbWIpY7vZjeZAl/7dCK8Js4MS/v5XyPbY7YNqvPcnKXMVuGDHxwQjRe43DPNxhStjZ+RAIKgpHGGZpMQ/UvDDSB0PxtwirZH+ke48m0YXHmSL+Y5Jx+4oTLTWEHR6loujX1bpbBTATNdlzaIznSYINzjRb84+EZg6qISR/Zarg9RseTJ3RBnZattcV82rwxzspV8/58HrRuojK351iy7zQcYWssL9NInIwNjggAxAtoy2w+gQL9MXX9Hr8MVac59xAhK7dDzfR4zjBCzEHj3I0lFT11DhAHYYEfDFro5BWpKHdLORKxEMO7/atWbO0DAEWAPm53fiW9CIQshxwR6zAqdc8QMZWtEjuqMntjc+TsS4EEdCFIvOKF1XXlKq+A8+VFmU0B64sYSyLY6IyfBXfy8x0uBYnO8/8EvgBDzT0PyOhAz0u2G9t8y+EsD09opidX1HX/mWnxyk1n2Hh+7oHX0aR7aAvCT4swoorQYKEpLgAFSvwoQyIA5qTnqlqWnxn/xIgx6gtHmDkUO3rtchm1wpuo8x2F5cO5Y2ivofGJ8xSOGBmXMkA8m79eYOA+rlBrVAhddVdeCkG3KCm1KtjiHzEFJUzt9Cz5Z0LLnKiX/osHcbsEqetTHPjv16mCIjlgMk5Jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(1800799024)(10070799003)(376014)(38070700021)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0XYM5ihfn8onnRgVIDHy4fTugem0LtUwWHIl3JyYVJ7qY7U5QBi9EbSVElM?=
 =?us-ascii?Q?hCmcpCWHSrqDHciQYzO2pa2CN3d0SIlLE1kMXGJiInEAyn0CHRz82SSgIpeQ?=
 =?us-ascii?Q?iisqj69E70fLWVRmKOiOjhrWuUpJfnNdlTiNmGpzBSuLXUxhRaPHf5EV6wLB?=
 =?us-ascii?Q?uVx8Vvq8Xc2WD5G2zx1IgxW8Fj3IrdQ+WI2IwQh7P9TeHqMPJ4XpdyUtlaAp?=
 =?us-ascii?Q?TEcXyrfzkQ27tQ4oQnc4yxCIv7cozz3C6IhZ8GiuGrU6dV3PZWBH5pWUxEzs?=
 =?us-ascii?Q?zIEoQD9unYVKopjCcsIfqpHhVCO6LnakrakpaHCalTR63Ca4rvfQBcj3xrlu?=
 =?us-ascii?Q?a9Qu+6tSE3vNJ/TQ4JzoLNN5Cal3lrPc4uTUvyMIQRufH6zE8qWDcHGhZKBX?=
 =?us-ascii?Q?b653eifrAosP4seOoYGdIBQpRdU/IQy9uJWaOLmMajAK9Gia2bPMkYiG9J2h?=
 =?us-ascii?Q?iPmKrrcFBV4WzDCdBnLYcVQkKseiBi+Myo34AgkTryab6pLWa5yTVilttthu?=
 =?us-ascii?Q?HtwXi3EXQ2wKYZxHpU1py6/zw+Iwnz0ZPnX85MRR9dDQ/Nq6mVU82GAM80RQ?=
 =?us-ascii?Q?itAgY5z/TW1CSDaTgJz0eup/a+L9IsQsAodW2wVsqUbLYB2MiZDF5lkbjLqv?=
 =?us-ascii?Q?Aa6HbV76iaPMhnnw7bO5VKq5LVFaAXRIkhy3XBRfcV6cnwAmr+OZ9fJ/CIIr?=
 =?us-ascii?Q?n9LEhX30fnbhQxL/I7KaKIHJU7/mY1NSyg2OWoCWxmplt3uv9G4EN2jBIgWX?=
 =?us-ascii?Q?9NP13uJY+m6FCKKihQucyKQccDU0j+p0cjARr0WGP9qBBJIJMHiG8uBsFz88?=
 =?us-ascii?Q?SNWLS83GUe+OUaLjBfTtvcD5fAFnxGnH90wtXL4h4V1EaOSrjIucoJFtu4P/?=
 =?us-ascii?Q?q0GvT9wdybQuNAZsYHjJARKoRZDG/x7lNWCH+L0fULlI9xeztOIZXo+n2BD6?=
 =?us-ascii?Q?Vvg1iF7ITceLmd2FGu+vFr5x+5dwHbbtyUQ6ADQ5SaomEnCWEIGxONHA2il+?=
 =?us-ascii?Q?Caw9T9OBpnnDVGdMi/Wo8ZAvF7rZbZCIc2SuAwzMf0sKFWTRv1cK07m9rx9o?=
 =?us-ascii?Q?b2rPSyqUtaGwB3L47qngrrU+I555ukLnq+TgA59UMb9msG15pLgdF8GJPoRa?=
 =?us-ascii?Q?FVkb3gcN0sC8eI0eAjQ/It1+LAQ+gLQMsa7cfrYag91ACZN6pQomP+wZiJPT?=
 =?us-ascii?Q?RhdQMBJEsUckMk7BdNF1fSVXlt/tyZVVmaAagO6I+FOfYk7jFgX1XG0FuCxv?=
 =?us-ascii?Q?Z+AsbqX95AaaM07PxI9ZE+Nc5uNSFbrI+5CowpJUBatPGaADcTUXns6L66S6?=
 =?us-ascii?Q?NtyLNZIiDzoHePeoBnVQxYO05A2EOPM8p+n698tN0CnzXhDSk1QVpp+ZEakI?=
 =?us-ascii?Q?RKmATC1D86ZMbY6K3pXKjg3XvToSsjO9pD+p4Q9U83qYKfbYftCYnOky5V7D?=
 =?us-ascii?Q?de58zmJ8K5RjjZffdpsh5XR4z7SMjmtVfnDhjB2qYywOGmxijWUM/MAHDX2x?=
 =?us-ascii?Q?c1jmOEfCraX0MRHRIaz9uJlATMeNNFv6N27CpGBPAuoqGKesmh0FabPIjyyg?=
 =?us-ascii?Q?hYj/ztufvAGGs/fexSQtDWd+a0F8LgcWIAi99zguXbjBHPno6cDw0AMxcDkz?=
 =?us-ascii?Q?tT4AuPT9a5i6XlL4hG4qKk4ya4hJRjX6VWo86T9O9s7fiXGrY7yowbhu9sRb?=
 =?us-ascii?Q?HSFwZmaFeGuVEom1NNRgFxRETG9cmvvXlu8M1SXM/Xs96+rmtz0w65GCJ+gH?=
 =?us-ascii?Q?t8c9tpCDqA=3D=3D?=
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RSMGQhU6/rLTWgJKGKXlM0wFcfKTGcAasea7VNLxkx5kdIoOFHG7pcuVqnK2U4TLTLeDTaXNUg38CF4LgmmNo2pa+mgjsRKsxaxMHw6RSGu5gvLNJEKFTqt10dKaCADpIOOzr7diCHNUJflpNwxoWOtOBQGUL8T69XFNPqSLD1zoet1Oa6KPpTjlMNcaHk9kLf1No68wkyNQ5UNCubVtj69CJ/DavcrMePLQJJxGSzAa8k3JFQbuvdaGEW7DyNxAcFMD68T9ThOK350JN1VWxxaSCg6dJSY9fB08ROeP64L045UzmpIGioHheZQ6iRAQfbXxGLxxb/ptdzVZ3rZpJQ==
X-OriginatorOrg: wgu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f20b0dcd-2079-4233-6818-08de881283fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 12:57:03.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa792cf-7768-4341-8857-81754c2afa1f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqDO1FmfLQQpJmr+FbtH/GrIH16yvJtcZPmMB9dNvnoiQ+sv4FRigXHYrygK+KmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1458
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oiv8WIw8CUeF57vNdniKMtqBQAwBZWIS4gqzFkgR2aw_1774184228
X-Mimecast-Originator: wgu.edu
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thank you for pointing out this regression.

The problem is that if ul_getuserpw_str() cannot find any user with the pro=
vided
UID or username, the unshare internal helper function get_user() will error=
 out
and stop argument parsing, even if a valid numeric value was provided. Prev=
iously,
the code would fallback to simply converting the string to an unsigned int =
and use
it for the uid_t, so I added that behavior back.

I found this issue to be true for the --map-group option as well, so I went=
 ahead and fixed
both cases in this latest patch: https://github.com/util-linux/util-linux/p=
ull/4134/changes/c74df906b67b2f9930662ca4e1ba04c21569d529

Please let us know if this fixed the problem on your end.

Regards,

Christian Goeschel Ndjomouo

________________________________________
From: Chris Hofstaedtler <zeha@debian.org>
Sent: Sunday, March 22, 2026 7:37 AM
To: Karel Zak
Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; util-linux=
@vger.kernel.org; Christian Albrecht Goeschel Ndjomouo; Helmut Grohne
Subject: unshare regression in 2.42-rc1

Hi Karel, Christian,

Debian CI found a regression in the unshare command when using
--map-user with numeric UIDs. This worked in 2.41 and earlier:

% unshare --version && unshare --user --map-auto --map-user=3D65536 id
unshare from util-linux 2.41.3
uid=3D65536 gid=3D65534(nogroup) groups=3D65534(nogroup)

And is broken in 2.42-rc1:

% unshare --version && unshare --user --map-auto --map-user=3D65536 id
unshare from util-linux 2.42-rc1
unshare: failed to parse uid '65536'

Note the following (true in both cases):
$ grep 65536 /etc/passwd
%

I suspect (but did not verify yet) this was introduced in
commit 0a7fb806118bc4418e231081bd13c69bbc31b988
> unshare: use the new ul_get{grp,userpw}_str() routines
>
> This change refactors get_group() and get_user(), so that it
> uses the new routines ul_getgrp_str() and ul_getuserpw_str(),
> to simplify the code and remove the overkill mem allocations.
https://github.com/util-linux/util-linux/commit/0a7fb806118bc4418e231081bd1=
3c69bbc31b988<https://github.com/util-linux/util-linux/commit/0a7fb806118bc=
4418e231081bd13c69bbc31b988>

Thanks to Helmut Grohne for reducing the failed debvm CI run to the
short unshare command.

Best,
Chris

