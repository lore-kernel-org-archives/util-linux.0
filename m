Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37064 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbcEMNwD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 May 2016 09:52:03 -0400
Date: Fri, 13 May 2016 09:52:01 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sassan Panahinejad <sassan@sassan.me.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] libfdisk: Add support for altering GPT size
Message-ID: <20160513135201.GT26300@vapier.lan>
References: <1463054083-2485-1-git-send-email-sassan@sassan.me.uk>
 <1463054083-2485-2-git-send-email-sassan@sassan.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AO7xfgsPaN7qs9GL"
In-Reply-To: <1463054083-2485-2-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--AO7xfgsPaN7qs9GL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 12 May 2016 12:54, Sassan Panahinejad wrote:
> +static int gpt_check_table_overlap(struct fdisk_context *cxt,
> +				   uint64_t first_usable,
> +				   uint64_t last_usable)
> +{
> ...
> +		if (gpt_partition_start(&gpt->ents[i]) < first_usable) {
> +			fdisk_warnx(cxt, _("Partition #%u out of range (minimal start is %ju sectors)"),
> +		                    i + 1, first_usable);

%j is for uintmax_t but this is uint64_t, so you'll want to use ..." PRIu64 "...

> +		if (gpt_partition_end(&gpt->ents[i]) > last_usable) {
> +			fdisk_warnx(cxt, _("Partition #%u out of range (maximal end is %ju sectors)"),
> +		                    i + 1, last_usable - 1);

same here
-mike

--AO7xfgsPaN7qs9GL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNdwBAAoJEEFjO5/oN/WBrf0QALxEr5koiO9q/uyKZWCWDfhY
XIItN78IN6SbxiMgf59PzsuAGQ6z7HIQtmNeOPMmtBw9Z6A4aKJxjFLstpTwDHn4
kDRkGWJMTpBDdy1SAXR0bYxklhHZhctGmbz/kHxo+cJbIRzOCBi0QnhJwbVgg98j
nA0tKRdO//h3xywO+XVoA9mBhZSN4GjuOoremMWjx0ingaLVFaBK/MuYzYqSyKPb
6T2Vi0IrIYrWeJcY7Jc2mOqYbAJSaOjJmhpLwDrtT8YdF7bdQHXnANqIT8cNlR1S
Xo5187W+BU3CLvO3cE2NKBipgo/DHAauZn6nLQgvSAJ+mqEUoMilA4E+3U9e9fIn
n/+5d1MrEK24TMNvMpfjUKl/W2lHi2JuSZCtXH/EGF2Jr1QjoZQfjt/mjVJ7gkRz
vt7d6HI43CsqCfACu8iSku68Yt887AbZUKIoKYxZQskILxSUEtOacYLt5v/o8o86
+lFnrsmAhq0jgAkjuwWl5xLRg9yiom92HcZjjpUVNaMbBnSKuC9D5upaLJgmXnIy
yVbzvZ/TMSeM6+pLhr5DGV8STet6dJKlqK1YZ5uaoDewFpJLcwq0XZMTiI6PcfgL
IyASPuJOIeJNzYgTpZDkmeYIyxn2YuiGa/0TSbXxIwugQJj4Ves4neDXYOl8xz9V
kVmSud76m3Xtpdqr8DBG
=PxQr
-----END PGP SIGNATURE-----

--AO7xfgsPaN7qs9GL--
