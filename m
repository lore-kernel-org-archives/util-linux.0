Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893FC43219
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 18:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6396115B
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 18:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhKJSze (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:55:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:54417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhKJSxo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Nov 2021 13:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636570253;
        bh=a6oWvx4Dy+ZDfm/f649VRiSxyNIDEtTWzEdirfkvs8k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=UZSJ7sbvfJsA0MZSdJhpKoVOyqG3t6X2kiAI4sHXf2OcE4gOOOLcH/0hjl9uDgOax
         TBvFiyPXnUR7P5T+yjT81skUpWYKSoDksz3zSfkSN1khhHw6vEIZieuvnnpE2AWyui
         adr7aVE93gdHJNt4o7/zAidAOsWLNj2gixge+VBk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.16]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1mwSTm2spO-00G1qC; Wed, 10
 Nov 2021 19:50:52 +0100
Date:   Wed, 10 Nov 2021 19:50:51 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     Karel Zak <kzak@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] irqtop: add -c/--cpus option
Message-ID: <20211110195051.66091d14@gmx.net>
In-Reply-To: <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
References: <20211110031642.141240-1-pizhenwei@bytedance.com>
        <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWcEoFSwep7bO4hL+l0jUGOVToqeK3YSiZW9xB9cGMin+oAUma6
 UKk8m4ZFa7PCdt9tYqidXs+p09gvBzesCN6qapnz4tmJHiDROdUWD0M0blGRSkLH51kNt23
 oIL6nyzCY22+xZk6vcmadK3FBv1IL4J0qgcYqsPdHMmOcoSUBQ/ejsuWalb9XPxkRNv3pgc
 sDes257aQoIRfuQrcvdBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p39+t2L8hLs=:aHEihSnF5HIMT4J/uIvWVi
 OuEsfqrNiTWN0Z48NwLWK3P/7Y8pnlz5Ru4JFFzZQ7kZTfCEnlrQ++xokqllW9O6vP0T2P0nZ
 od0it2vy58fmHeygr5sXheQQOVooTFhg1f8M/n7AVBv3i8JNfnnQnNSk7ilXQrM9USNjhXobc
 Xwtaj0nlYiozGGw5wOmUA04lg1Y/3UPvOHyeDhPqPRl+s7Bp4VBK04FDTYBkbegRN1ck9pOe7
 WDShnApuKfgGx8o2Ab8Pl8YB3RKCOpJIjBttbABmqKbyz6HL7ov5amgoX6Oiz3DgUAEmYDNeR
 DaUCbzmHdpwELR9VbtA1Y7HpeRkrc/XrSy9pYwO5xXAvcDzqKBnBT5OwHWsUFM5Bb1uDrMi8y
 gvpcjD2FdFq4IPrJAeNOCvBJVeYIsQ2SEdDjwkh6t4clBMa7oN5auukIiP1LDFH5nVvX7ma+2
 nSEJDI0PDaf1s3nZ59CN5U8u4mXeJt9312cA55RyZkPABTqWcWzQXmlmf1yOuf8t+Ig/7bbas
 yHCO6nHESmFCE5ZZV0uIcu3UloIKy/VUc93pHddrzGZZanB/TWkFgiBOeLBYHFkH/qVF25xrR
 /khGLCeq4bW7GYQYi2letRvgtijKGm3tIPqb2170X2cpsmCt0uMwbtyCWZfqgf9cD3YLFHrw9
 joO+ElOn76QS7KerSAlBHGVNZhS1qw+4w8pO54zwsPcL3jCRnGv14h9eNU5B1d93gA/qc/FJ/
 cT6Gd0JUknTg6912qHytvfnWBE78mi1xiO/2W/ZJUEtLo41/fnaxHpX6KGkqGvyGUIcGZ1Wmv
 J+CKOe9YQfpQwZDfHXC/WbavmJStys1ZoGGAVEBuk+3vGY7+clpZbFXW9CTVn1y3eVupaiR2y
 MYsj9IDf159IL8LUS1lWbLgDSm9hU1Hy5HAzbWk1EEnrEwtYgQ5Mo94Gzfr0UUtU04tSFH9Xe
 4WUFznqZVD+LIvNbrqxEIJah3BqVh0oj5vNqGBx+1ve8I72vrMGU46uG5MIfHW2G/06XEiNGx
 IJRsxSC2zMgethUns3w9gacW1bLQHxDVRz+yNmDlfHKAufUwylfJm4SgBHU/GxhS9vEDF2mXf
 hutQji+8WXErKE=
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

On Wed, 10 Nov 2021 10:58:43 +0100, Karel Zak <kzak@redhat.com> wrote:

> On Wed, Nov 10, 2021 at 11:16:42AM +0800, zhenwei pi wrote:
> > Since a23aecc1bf("irqtop: add per-cpu stats"), irqtop always shows
> > per-cpu stats. Test on a modern AMD server with 2 socket(256 CPU),
> > irqtop shows like following:
>
> Thanks! This was on my TODO list too.
>
> > +	/* print cpus table or not by -c option */
> > +	do {
> > +		int x, y;
> > +
> > +		if (ctl->cpus =3D=3D irqtop_cpus_table_disable)
> > +			break;
> > +
> > +		scols_print_table_to_string(cpus, &data);
> > +		if (ctl->cpus =3D=3D irqtop_cpus_table_auto) {
> > +			/* detect window size */
> > +			getmaxyx(ctl->win, y, x);
> > +			y =3D y;	/* avoid build warning*/
> > +			p =3D strchr(data, '\n');
> > +			if (p) {
> > +				/* line is too long */
> > +				if ((p - data) > x) {
> > +					free(data);
> > +					break;
> > +				}
> > +			}
> > +		}
>
> libsmartcols provides scols_table_enable_nowrap(), this function
> forces the library trim the output. It seems more elegant.
>
> I have applied your patch with some changes
> https://github.com/util-linux/util-linux/commit/17f7caa45105f0cbf8bf9b56=
2468fba2c5d4a549
>
> (and https://github.com/util-linux/util-linux/commit/d1732bba383a95786b5=
ec7bc1f4a173b644fe871
>  as I forgot update bash-completion in the first commit)

@@ -275,6 +289,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 {
 	const char *outarg =3D NULL;
 	static const struct option longopts[] =3D {
+		{"cpus", required_argument, NULL, 'c'},
 		{"delay", required_argument, NULL, 'd'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},

s/cpus/cpu-stat/ ?

Regards,
Peter

>
> Thanks again!
>
>     Karel
>

