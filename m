Received: from us-smtp-delivery-109.mimecast.com (us-smtp-delivery-109.mimecast.com [170.10.129.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C875801
	for <util-linux@vger.kernel.org>; Thu,  4 Jun 2026 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545835; cv=none; b=U3z+iCa1if//yP2waPpUAIJcPETbKew6xd6NIcpZ14BZHRQRJ7FOvdtmw85d1l3VWJ2kkmuoTfDIU07kX32FeWbWmGoEAX97PEG1ENdZ6U0qj9BI1qf5pl3yY1HW8dVOXthDhCG8fnpQMO/P5q5fMfNyGyp74eZnEK2D4bQHS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545835; c=relaxed/simple;
	bh=EwEzlzJCQNlyRvxMmZDQYJxakd9cgVt/myxbVa3Tq5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=egkGgt8ah1hNS3OmpZQZw9FX791gC6qlYnBrXdert7QUJWTchfssfpNs0JjT3Gs8ni7I0x+uTyyYliu8yf1iFHnr2mUYsZANxuRIYpBd7+wYsOLyXx677VlwYoO0GkCbq0+js3hHpKSAFEZS2Jey9vAL1jmrfVhCObp6rZ8yGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu; spf=pass smtp.mailfrom=wgu.edu; dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b=aH3tBEDt; arc=none smtp.client-ip=170.10.129.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wgu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b="aH3tBEDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgu.edu; s=mimecast20181213;
	t=1780545832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwEzlzJCQNlyRvxMmZDQYJxakd9cgVt/myxbVa3Tq5g=;
	b=aH3tBEDtyEmgzf8O6uFItBd9BDL1Tw8E0/Q7yZo1ViYK2VrG1LlWu+satOEvXua6nmxJEF
	7tzj3AdvUx7nTcJPCRSbXWtafHacuncNze7/6Z/7i5Pig5kkGH37mbpr/mGE3T3Qgmgmh/
	Mwu7uO+lzXso8RMFWTSHmW+MpRFwmwvpW99uMSsmSZIceNpMcrOqaw1pAi9oGonRLknQcY
	4BIvW0gD81wr3/8Ti3Kn4EaYyriM9Upd0gWauioOwwvQS/sr0svWq/fTuHBqgz1RB6JAzF
	pyGpqycm/l/eAKpXGlAvYBn8LQkIPoZduLQODsnhcbBpQJK3E0SH38p8FD4TLQ==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021073.outbound.protection.outlook.com
 [40.93.194.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-kdTJBSW_NMyU7U2bselYmQ-1; Thu, 04 Jun 2026 00:03:48 -0400
X-MC-Unique: kdTJBSW_NMyU7U2bselYmQ-1
X-Mimecast-MFC-AGG-ID: kdTJBSW_NMyU7U2bselYmQ_1780545827
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:3b8::14)
 by LV3P220MB1411.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:03:45 +0000
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa]) by SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 04:03:44 +0000
From: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
To: Chris Hofstaedtler <zeha@debian.org>, "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>
CC: Ralph Ronnquist <ralph@selfhost.au>, "1134639@bugs.debian.org"
	<1134639@bugs.debian.org>
Subject: Re: Bug#1134639: nsenter -t 1 -m escapes mount and pid namespaces
Thread-Topic: Bug#1134639: nsenter -t 1 -m escapes mount and pid namespaces
Thread-Index: AQHc84Z5i9P2abWTJ0+PC28pmRUZFrYttlzJ
Date: Thu, 4 Jun 2026 04:03:44 +0000
Message-ID: <SJ0P220MB0541F8F40FD5C0E972BBD715E9102@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
References: <aejkWHDXmpCX7Gh7@smyga.hemma> <aiBvnWAjX7uu8ydx@per.namespace.at>
In-Reply-To: <aiBvnWAjX7uu8ydx@per.namespace.at>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P220MB0541:EE_|LV3P220MB1411:EE_
x-ms-office365-filtering-correlation-id: cab1cc09-9b4d-43c9-c80c-08dec1ee4531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|786006|22082099003|18002099003|56012099006|4143699003|11063799006|6133799003|38070700021
x-microsoft-antispam-message-info: +k2fCXJ/ZxePEa6GAfd7YHeGHPPkuslxCDotXa7SXQvYPds0UUVX0RtFZl3c7/Zipb0tVmyyy42n94jperHyvDHNwKey+3Q+uXrJzVnnf0y/XYv3Kr5WsYpndBFhSeDUO3jF6Hz0+IrI0IU23OONwzWILVjBGPtAtX1GI1ZU1NPF7/bN7pB4nYH7duW0kust6uSC7Grt2lUDnoLtfojJCXSyMvywOdm+HkbuBEUZrV7BImAJZbYr/yGj2AumeeS4kkGddOytlWjNB1S6FH+iOUXj7F57YS/qGjqm2+ZAshjffONE045a765hHEAlTIVRKbj1CFvELq3FE/izLxJGn8Vki4qx49sjlgePAdjTSiCgICM3HnBoljNjcJSCBb/bVL/qp3X6mTiRhf2xhYB3PVSySjenD24wUEJvtbOjF8SbdT63Q4ZgKIdAgbUCrom+5fdPVeJD6EiS2OlXemUdyaVPKgr/ejWLarCitQAq3hH3+Efq4x4y37AKdLCvtlFlq0LoVSmvsFyVoY10M9E1jao50WvvwTUeIha2F9ntxwPtK8s59nswxQjogevPxPGFcJOJEmbhFoENDTGViGcJW+DoHayp/AW+KY7uV5qutT+uBjGTcNLrg2ATx1GlCQzs0vzsRJgVtZ3l50ahEt/oAx/dpS0j9kdrKl9qxN89Ag3UkVPcAnqf75HOp4B7RqmFQUHEojCvYwkKpjrp7AtvlAW6j+sm5fohhmY6QnJ/dzsKXZSiRpxk36GVyXcg2Zcr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(786006)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vA8Uk2276/J1kG+7az2l4tCcMXyQXrDPHB73XSKfEh5iFWCV4E1pvFpxJh?=
 =?iso-8859-1?Q?ctNPzzp3vtBYQCZVr+1HL1+Cko5GFWl3ELjUHPO9TlLzdJqsKjVJ+WPgWw?=
 =?iso-8859-1?Q?KZCRd4S+TZ+IKIgrsPbN6ZDsKCZSJyCYbL77Ls1+2BXJMZpMKK+aGXUz68?=
 =?iso-8859-1?Q?LYLFLG3/O6YjApAPENBoDQaqc5rkXvIgTyYDxMzVeIiHlbjCZey6EqBsrn?=
 =?iso-8859-1?Q?JM3G1y4YkG7zkdwsXj8cJ+8ULwzqZdkTWZs1Q8XSMHm5f1txCk/e5lk8KT?=
 =?iso-8859-1?Q?Cb9QWMiXY43JytCdLWeu3zNqr7j/HQg9iLWzYBlXG8K1oovaQMvIq8hhp+?=
 =?iso-8859-1?Q?g9fGOiP6R4S5Tt8aO7lYURvUtzykEbbtmk9RFyYoO8uilxheAM7Zcjz3na?=
 =?iso-8859-1?Q?M4zZ0nTarPF7YCJ9rXRygSgVFL8pKrIVVcl8ipqkNdwz5gge5BbHorGupj?=
 =?iso-8859-1?Q?JQr1tGfbwznXCZ6E1xSFY/ddhmHxWcXdzLwbwswvQJ6k0O84Dd7YkYFywv?=
 =?iso-8859-1?Q?6uHVSP7LEw6xO8M4p0fLY44LnTIiRT1FqXABegjy93UFZ7To8CrH9RyG1s?=
 =?iso-8859-1?Q?W+SBDzRCkI8d1c1ZbcrvAFGHIQPq6EymsBN1RjVc9DMNMEGo6fjMG7HQkN?=
 =?iso-8859-1?Q?J8zrDiEgLqvCilfaQsOnWhkigYA2Yt0I3/72SM2GY6X8GI677nlhtDWAfR?=
 =?iso-8859-1?Q?PgQ4nNBSItI6WQxwGZNOaCuxQAjineCGoT4+039Kh7rzlnMz60hh0+t5oR?=
 =?iso-8859-1?Q?SJhp8qzZtx8i6XfSKjF9+GKqjAzV7aJB/duU3Tj1qIhD9Gb05+KPFLqQ0D?=
 =?iso-8859-1?Q?zFhfRE8w+Pl9jaTmEoKrQQ/oGhGmw053QCw9ZQ7G/6g2SHyFCOHU9AVCH8?=
 =?iso-8859-1?Q?beeb6twfc4LHBlElkP6xcKbFMIV+0+Mmp3ayZeBCMNenlcdWT0BEcbFoaR?=
 =?iso-8859-1?Q?6VyJYiizvkHEIPZv0zPhQyiRE8Vamuuv6hSUp2cun0gtQSBEFdw19dj4fg?=
 =?iso-8859-1?Q?ZfNwTfue70u03+kgHQPczooD0WnLwkS7sC2NghWvZN29kUSP3BjD4YydEg?=
 =?iso-8859-1?Q?7j5JCDPjnSdxXc9TRc8Td2Wpovh8h0mCFO1WwtFd9NhSQag6WX1+2E0QM8?=
 =?iso-8859-1?Q?lHRJYUqksv80sEoMVhtmO0++0GKMkmkdlkJWqwFzuwEuYgTbYczyyjATDI?=
 =?iso-8859-1?Q?NLTeK6h91iJKXttJkS2ZczHWSc5KPCMSQju9h0GX6Qkc3jy42nTkBjrozR?=
 =?iso-8859-1?Q?hmJUCOOrgr2ipNTGJWKMA9cMY+2K3TzVa680dTiz3LSKZH5XtIBdyJ1Z4h?=
 =?iso-8859-1?Q?n84mDNADIVj40gFvXZCWBslS6pgR3/Aty8w6LfhLKPjlgpvx1pvrV/biOG?=
 =?iso-8859-1?Q?pkqKbInYpsjxXuXpdVpwYp8XjZaGKgwe2tFxr2HYj126xGOw1kq+favRPM?=
 =?iso-8859-1?Q?BDh3Y3no+m80Q8pKo27SMQcwLdeQAYz0CaCO+p8uqGWbXdlgjy9/G4bLjz?=
 =?iso-8859-1?Q?XHZYKBVUUVLTGw2jMU+kODDNJNMxhuh2h3EWez050c3TxB0xdXSz77b1S3?=
 =?iso-8859-1?Q?lLSTqz+8RKPAx13QN7Ubn4N/KCSe3S5Yt2rT5jajJkk6lbQLze83nFIhjp?=
 =?iso-8859-1?Q?q6FNcMgbF30R4qJPf5o+ajwmu2vdrk1FSdJB4hl2lO9FTgvSW0kdmPc6Dp?=
 =?iso-8859-1?Q?uMS54LKUELsiqRVBvwCAdkRCsx74oVrQrUBjeRPmMcD8Wg9YoU89oaW+15?=
 =?iso-8859-1?Q?dtcjev0TczFyhSy8I2q4q3HgGkmHuGJYel6JkS8hvRkt8mHTfjSLuu/AGj?=
 =?iso-8859-1?Q?xsmR/BP3jg=3D=3D?=
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pz0bKQYURO6CPPZpgz7kIU1S8G/0jdJu2Z3LPJtlRrGQmJaMV/96nUaekevCJuBfKm+CvZ0jsZBQEic28rXc/q3+cT9AwGBYkykroZuSOP5HH2T9xEeXpwIzgzm0hH1FbOLA9tuUHa38ficfvXZDHALEIN5Bo4isnrjy3nVhErjZGYLj8oLm/k5GNaQte+Sjg68DIWmdCtq2RXBcDEg1T2Rr4G4qcpoG/gmJi/2dmz0Gs+s31cfi8zw4IZTPY6Xf3kbPIMrj08T5sDShxlCD2UUUylYzkXUtCLjj1wMGJaiGIbQa1lob8VObca+4MukwCLqbXUqDemvnyuYJlDOGwQ==
X-OriginatorOrg: wgu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cab1cc09-9b4d-43c9-c80c-08dec1ee4531
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 04:03:44.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa792cf-7768-4341-8857-81754c2afa1f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JC36PCQR4ZmtJY/8pLz4nxipwsa9d5h+2TWzEwMPesyobC4A9/BLO3wO0WoAOSZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1411
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZjO-tx76UOC1h9Hu9dUfSkH1qAuRG33xeOqN2nYJgkc_1780545827
X-Mimecast-Originator: wgu.edu
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

> First: {unshare -m -p -f chroot FS} will change root into that=0A> filesy=
stem with unshared mount and pid namespaces.=0A>=0A=0AThis will successfull=
y changes the root directory path of the child process,=0Ahowever, the newl=
y created mount namespace's root mount will still=0Apoint to the host's roo=
t filesystem, which is the actual root cause of the=0Aescape (it'll become =
clearer below).=0A=0A> Next: {mount -t proc proc /proc} will mount the proc=
fs for that pid=0A> namespace. We see with {ls -l /proc/1/ns/mnt} the ident=
ity of the=0A> unshared mount namespace, which is different from the identi=
ty before=0A> chroot.=0A>=0A=0AAs the mount(8) command has copied the execu=
tion context of the container=0Aprocess, it will see it's root filesystem a=
s `FS`, so the 'procfs' will be mounted=0Aon FS/proc, rightfully so. The ls=
 command is also running with that context,=0Aand will show the container's=
 mount namespace ID.=0A=0A> But: {nsenter -t 1 -m -- ls -l /proc/1/ns/mnt} =
shows the identity of=0A> the host mount namespace -- the outer namespace.=
=0A>=0A> Thus {nsenter -t 1 -m} "escapes" from the unshared namespace to th=
e=0A> containing namespace. And for example: {nsenter -t 1 -m /bin/sh}=0A> =
starts a shell in the outer mount and pid namespace(s)!=0A>=0A=0AThe reason=
 why you escaped is that when nsenter(1) calls setns(fd, CLONE_NEWNS)=0A, t=
he kernel will set the root filesystem for the calling process to the absol=
ute root of=0Athe target mount namespace. And, whatever binary it forks wil=
l now be decoupled=0Afrom the container's chroot and point back to the host=
's root filesystem. This is why=0Ayou are also able to view the host's moun=
t table or resolve paths relative to the host=0Afs while inside the contain=
er, for example, when you executed a shell with nsenter(8).=0A=0AIf you wis=
h to completely cut ties with the VFS structure of the host, you can make u=
se=0Aof pivot_root(8). It let's you set the global root mount of the mount =
namespace and truly=0Aisolates the mount namespace.=0A=0AYou can do somethi=
ng like this:=0A=0A$ unshare --mount --pid --fork=0A$ mount --bind FS FS/=
=0A$ cd FS/=0A$ mkdir -p old_root/=0A$ /sbin/pivot_root . old_root/=0A$ cd =
/=0A$ mount -t proc proc /proc=0A$ umount -l old_root/=0A$ rmdir old_root=
=0A=0AYou should then be able to see the exact same mnt namespace ID.=0A=0A=
$ ls -l /proc/1/ns/mnt=0A[...] /proc/1/ns/mnt -> 'mnt:[4026533461]'=0A$ nse=
nter --mount --target 1 -- ls -l /proc/1/ns/mnt=0A[...] /proc/1/ns/mnt -> '=
mnt:[4026533461]'=0A=0A=0AMaybe Karel has more to say about this.=0A=0AAnyw=
ays I hope this cleared up at least some of the confusion.=0A=0A=0AChristia=
n Goeschel Ndjomouo=0A=0A

